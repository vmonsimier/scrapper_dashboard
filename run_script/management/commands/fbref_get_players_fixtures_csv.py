from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.support.wait import WebDriverWait 
from selenium.webdriver.common.by import By
import selenium.webdriver.support.expected_conditions as EC

import re
import time
import requests
import json
import os
import sys

from django.core.management.base import BaseCommand
from run_script.models import *

from ..basis.scrapper import Colors
from ..basis.scrapper import Scrapper
from ..basis.fbref import ScrapperLogic

leagueIds = {
    'Premier League': 9,
    'Ligue 1': 13,
    'Serie A': 11,
    'Bundesliga': 20,
    'Liga': 12
}

class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            '--node',
            default=False,
            help='Handle the node id for paralellism scrapping'
        )
        parser.add_argument(
            '--relaunch',
            default=False,
            help="Relauch specific node"
        )

    def handle(self, *args, **options):
        bcolors = Colors()

        if 'node' in options and options['node'] != False:
            node = int(options['node'])
        elif 'relaunch' in options and options['relaunch'] != False:
            node = int(options['relaunch'])
        else:
            node = 1
        
        print_scrapper = bcolors.FAIL + "Scrapper {0} -".format(str(node))

        scrapper = Scrapper()
        driver = scrapper.webdriverFromNode(node)
        
        try:
            scrapper_logic = ScrapperLogic()
            active_links = Scrapper_Active_Links.objects.filter(scrapper_id=2, node_id=node)

            for i in range(0, len(active_links)):
                driver.get(active_links[i].link)

                league = active_links[i].league

                if i == 0:
                    driver.maximize_window()
                    scrapper_logic.clickCookiesAccept(driver, print_scrapper)
                    time.sleep(2)

                
                time.sleep(2)
                scrapper_logic.removeFooterWrapper(driver, print_scrapper)
                time.sleep(3)

                season_links = [
                    '//*[@id="meta"]/div[2]/h1',
                    "/html/body/div[3]/div[3]/div[1]/div[2]/h1",
                    "/html/body/div[2]/div[3]/div[1]/div[2]/h1"
                ]

                for link in season_links:
                    try:
                        season = driver.find_element_by_xpath(link)
                        if season != None:
                            break
                    except NoSuchElementException:
                        message = 'Cannot find title. Try another xpath..'
                        print(print_scrapper, bcolors.FAIL + message + bcolors.ENDC)
                        scrapper.logger(message, node)

                try:
                    match_season = re.search(r"[0-9]{4}", season.get_attribute("innerText")).group(0)
                except Exception as e:
                    print(print_scrapper, e)
                    scrapper.logger(str(e), node)
                    
                driver.execute_script("window.scrollTo(0, 750);")

                time.sleep(5)

                tname_links = [
                    "/html/body/div[1]/div[6]/div[3]/div[4]/div[1]/table/tbody/tr/td[1]/a",
                    "/html/body/div[2]/div[6]/div[3]/div[4]/div[1]/table/tbody/tr/td[1]/a",
                    "/html/body/div[3]/div[6]/div[3]/div[4]/div[2]/table/tbody/tr/td[1]/a",
                    "/html/body/div[3]/div[6]/div[3]/div[4]/div[1]/table/tbody/tr/td[1]/a",
                    "/html/body/div[3]/div[6]/div[2]/div[4]/div[1]/table/tbody/tr/td[1]/a",
                    "/html/body/div[3]/div[6]/div[3]/div[4]/div[1]/table/tbody/tr/td[1]/a",
                    "/html/body/div[2]/div[6]/div[2]/div[4]/div[1]/table/tbody/tr/td[1]/a"
                ]

                for link in tname_links:
                    try:
                        teams = driver.find_elements_by_xpath(link)
                        if len(teams) != 0:
                            break
                    except NoSuchElementException:
                        message = 'Cannot find teams. Try another xpath...'
                        print(print_scrapper, bcolors.FAIL + message + bcolors.ENDC)
                        scrapper.logger(message, node)
                if len(teams) == 0:
                    # We log error into db
                    message = 'Teams are empty'
                    print(print_scrapper, bcolors.FAIL + message)
                    scrapper.logger(message, node)
                    log = ScrapperLogs(scrapper_id=2, type='error', text='Teams are empty', date="")
                    log.save()
                    

                teams_links = []
                teams_names = []

                # We retrieve team links already scrapped
                exclude_teams = Exclude_Team_Links.objects.filter(scrapper_id=2)
                exclude_teams = list(map(lambda x: x.link, exclude_teams))

                for team in teams:
                    if team.get_attribute('href') not in exclude_teams:
                        message = team.get_attribute('href')
                        print(print_scrapper, bcolors.OKBLUE + message)
                        teams_links.append(team.get_attribute('href'))
                        teams_names.append(team.get_attribute("innerText"))
                        scrapper.logger(message, node)

                for j in range(0, len(teams_links)):

                    driver.get(teams_links[j])

                    time.sleep(3)
                    scrapper_logic.removeFooterWrapper(driver, print_scrapper)
                    scrapper_logic.removeAdsiFrame(driver, print_scrapper)
                    driver.execute_script("window.scrollTo(0, 600);")

                    time.sleep(5)

                    flink_selector = '//*[@id="stats_standard_{0}"]/tbody/tr/td[29]/a'.format(leagueIds[league])

                    flinks = [
                        flink_selector,
                        '/html/body/div[2]/div[6]/div[3]/div[2]/table/tbody/tr/td[20]/a',
                        '/html/body/div[2]/div[6]/div[2]/div[2]/table/tbody/tr/td[20]/a',
                        '/html/body/div[3]/div[6]/div[3]/div[2]/table/tbody/tr/td[20]/a'
                    ]

                    for link in flinks:
                        try:
                            fixtures_links = driver.find_elements_by_xpath(link)
                            if len(fixtures_links) != 0:
                                break
                        except NoSuchElementException:
                            message = 'No to player fixture is not on the page. Try another one'
                            print(print_scrapper, message)
                            scrapper.logger(message, node)

                    if len(fixtures_links) == 0:
                        message = 'Players are empty'
                        print(print_scrapper, bcolors.FAIL + message)
                        scrapper.logger(message, node)
                        driver.quit()

                    fixtures_players = []

                    for fixture_link in fixtures_links:
                        fixtures_players.append(fixture_link.get_attribute('href'))
                        message = fixture_link.get_attribute('href')
                        print(print_scrapper, bcolors.OKCYAN + message)
                        scrapper.logger(message, node)


                    message = 'Number of players : ' + str(len(fixtures_players))
                    print(print_scrapper, bcolors.WARNING + message + bcolors.ENDC)
                    scrapper.logger(message, node)

                    ############################################################################################################
                    #
                    # FIXTURE PLAYERS
                    #
                    ############################################################################################################

                    for fixture_player in fixtures_players:
                        # We retrieve team links already scrapped
                        exclude_players = Exclude_Player_Links.objects.filter(scrapper_id=2)
                        exclude_players = list(map(lambda x: x.link, exclude_players))

                        if fixture_player in exclude_players:
                            continue

                        driver.get(fixture_player)
                        message = 'Go to ' + fixture_player
                        print(print_scrapper, bcolors.WARNING + message + bcolors.ENDC)
                        scrapper.logger(message, node)
                        
                        time.sleep(2)
                        scrapper_logic.removeFooterWrapper(driver, print_scrapper)
                        scrapper_logic.removeAdsiFrame(driver, print_scrapper)
                        time.sleep(2)

                        try:
                            player_name = driver.find_element_by_xpath('//*[@id="meta"]/div[2]/h1/span[1]')
                        except:
                            player_name = driver.find_element_by_xpath('//*[@id="meta"]/div/h1/span[1]')

                        player_name = player_name.get_attribute('innerText')
                        print(print_scrapper, bcolors.OKBLUE + player_name)
                        scrapper.logger(player_name, node)
                        

                        try:
                            element = driver.find_element_by_xpath('//*[@id="matchlogs_all_sh"]/div/ul/li[2]/span')
                        except:
                            element = driver.find_element_by_xpath('//*[@id="matchlogs_all_sh"]/div/ul/li[1]/span')

                        scrollTo = str(int(element.location['y']) - 200)
                        driver.execute_script("window.scrollTo(0, {});".format(scrollTo))

                        time.sleep(2)

                        filename = 'genstats_' + teams_names[j] + '_' + player_name + '_' + match_season + '.csv'

                        if not scrapper.checkFileExists(2, league, filename):

                            menu_link_selector = ['//*[@id="matchlogs_all_sh"]/div/ul/li[1]/span', '//*[@id="matchlogs_all_sh"]/div/ul/li[2]/span']
                            csv_link_selector = ['//*[@id="matchlogs_all_sh"]/div/ul/li[1]/div/ul/li[4]/button', '//*[@id="matchlogs_all_sh"]/div/ul/li[2]/div/ul/li[4]/button']
                            pre_selector = '//*[@id="csv_matchlogs_all"]'

                            for k in range(0, len(menu_link_selector)):
                                try:
                                    selectors = {
                                        'menu_link': menu_link_selector[k],
                                        'csv_link': csv_link_selector[k],
                                        'pre_link': pre_selector
                                    }

                                    element = scrapper_logic.retrieveStats(driver, 2, league, filename, selectors, print_scrapper)

                                    if element:
                                        break

                                except Exception as e:
                                    message = 'Try another element...'
                                    print(print_scrapper, bcolors.FAIL + message)
                                    scrapper.logger(message, node) 


                        filename = 'passes_' + player_name + '_' + teams_names[j] + '_' + match_season + '.csv'

                        if not scrapper.checkFileExists(2, league, filename):
                            try:
                                passes = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[2]/a', print_scrapper)
                            except:
                                passes = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[2]/div[2]/a', print_scrapper)

                            if passes:
                                time.sleep(2)
                                scrapper_logic.removeFooterWrapper(driver, print_scrapper)
                                scrapper_logic.removeAdsiFrame(driver, print_scrapper)
                                time.sleep(2)
                                
                                self.retrieveSpecificData(driver, league, filename, print_scrapper)
                                
                                time.sleep(3)
                        
                        filename = 'passes-type_' + player_name + '_' + teams_names[j] + '_' + match_season + '.csv'

                        if not scrapper.checkFileExists(2, league, filename):
                            try:
                                passes_type = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[3]/a', print_scrapper)
                            except:
                                passes_type = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[2]/div[3]/a', print_scrapper)

                            if passes_type:
                                time.sleep(2)
                                scrapper_logic.removeFooterWrapper(driver, print_scrapper)
                                scrapper_logic.removeAdsiFrame(driver, print_scrapper)
                                time.sleep(2)

                                self.retrieveSpecificData(driver, league, filename, print_scrapper)

                                time.sleep(3)
                        

                        filename = 'penalty-prep_' + player_name + '_' + teams_names[j] + '_' + match_season + '.csv'

                        if not scrapper.checkFileExists(2, league, filename):
                            try:
                                penalty_prep = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[4]/a', print_scrapper)
                            except:
                                penalty_prep = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[2]/div[4]/a', print_scrapper)

                            if penalty_prep:
                                time.sleep(2)
                                scrapper_logic.removeFooterWrapper(driver, print_scrapper)
                                scrapper_logic.removeAdsiFrame(driver, print_scrapper)
                                time.sleep(2)

                                self.retrieveSpecificData(driver, league, filename, print_scrapper)
                                
                                time.sleep(3)
                        
                        filename = 'defensive-actions_' + player_name + '_' + teams_names[j] + '_' + match_season + '.csv'
                        
                        if not scrapper.checkFileExists(2, league, filename):
                            try:
                                defensive_actions = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[5]/a', print_scrapper)
                            except:
                                defensive_actions = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[2]/div[5]/a', print_scrapper)

                            if defensive_actions:
                                time.sleep(2)
                                scrapper_logic.removeFooterWrapper(driver, print_scrapper)
                                scrapper_logic.removeAdsiFrame(driver, print_scrapper)
                                time.sleep(2)

                                self.retrieveSpecificData(driver, league, filename, print_scrapper)

                                time.sleep(3)
                        
                        filename = 'possession_' + player_name + '_' + teams_names[j] + '_' + match_season + '.csv'

                        if not scrapper.checkFileExists(2, league, filename):
                            try:
                                possession = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[6]/a', print_scrapper)
                            except:
                                possession = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[2]/div[6]/a', print_scrapper)


                            if possession:
                                time.sleep(2)
                                scrapper_logic.removeFooterWrapper(driver, print_scrapper)
                                scrapper_logic.removeAdsiFrame(driver, print_scrapper)
                                time.sleep(2)

                                self.retrieveSpecificData(driver, league, filename, print_scrapper)

                                time.sleep(3)
                        
                        filename = 'various-stats_' + player_name + '_' + teams_names[j] + '_' + match_season + '.csv'

                        if not scrapper.checkFileExists(2, league, filename):
                            try:
                                various_stats = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[7]/a', print_scrapper)
                            except:
                                various_stats = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[2]/div[7]/a', print_scrapper)

                            if various_stats:
                                time.sleep(2)
                                scrapper_logic.removeFooterWrapper(driver, print_scrapper)
                                scrapper_logic.removeAdsiFrame(driver, print_scrapper)
                                time.sleep(2)

                                self.retrieveSpecificData(driver, league, filename, print_scrapper)
                        
                        try:
                            keeper = scrapper_logic.checkElementExists(driver, '//*[@id="content"]/div[3]/div[8]/a')
                        except:
                            keeper = scrapper_logic.checkElementExists(driver, '//*[@id="content"]/div[2]/div[8]/a')
                                                
                        if keeper:
                            filename = 'keeper_' + player_name + '_' + teams_names[j] + '_' + match_season + '.csv'

                            if not scrapper.checkFileExists(2, league, filename):
                                try:
                                    click_keeper = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[8]/a', print_scrapper)
                                except:
                                    click_keeper = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[8]/a', print_scrapper)

                                if click_keeper:
                                    time.sleep(2)
                                    scrapper_logic.removeFooterWrapper(driver, print_scrapper)
                                    scrapper_logic.removeAdsiFrame(driver, print_scrapper)
                                    time.sleep(2)

                                    self.retrieveSpecificData(driver, league, filename, print_scrapper)

                        logText = 'Done player ' + player_name + ' | team ' + teams_names[j] + ' | ' + match_season
                        print(print_scrapper, bcolors.OKGREEN +  logText)
                        scrapper.logger(logText, node)
                        exclude_player = Exclude_Player_Links(scrapper_id=2, link=fixture_player)
                        exclude_player.save()

                    exclude_team = Exclude_Team_Links(scrapper_id=2, link=teams_links[j])
                    exclude_team.save()

                Scrapper_Active_Links.objects.filter(link=active_links[i]).delete()
        except Exception as e:
            exc_type, exc_obj, exc_tb = sys.exc_info()
            fname = os.path.split(exc_tb.tb_frame.f_code.co_filename)[1]
            print(e, 'File', fname, 'Line', exc_tb.tb_lineno)
            scrapper_logic.relaunchScrapper(driver, print_scrapper)


    def retrieveSpecificData(self, driver, league, filename, print_scrapper):
        try:
            scrapper_logic = ScrapperLogic()

            menu_link_selector = ['//*[@id="matchlogs_all_sh"]/div/ul/li[1]/span', '//*[@id="matchlogs_all_sh"]/div/ul/li[2]/span']
            csv_link_selector = ['//*[@id="matchlogs_all_sh"]/div/ul/li[1]/div/ul/li[4]/button', '//*[@id="matchlogs_all_sh"]/div/ul/li[2]/div/ul/li[4]/button']
            pre_selector = '//*[@id="csv_matchlogs_all"]'

            for k in range(0, len(menu_link_selector)):
                try:
                    selectors = {
                        'menu_link': menu_link_selector[k],
                        'csv_link': csv_link_selector[k],
                        'pre_link': pre_selector
                    }

                    try:
                        element = scrapper_logic.retrieveStats(driver, 2, league, filename, selectors, print_scrapper)
                    except Exception as e:
                        message = 'Error retrieving file ' + e
                        print(print_scrapper, message)
                        scrapper.logger(message, node)

                    if element:
                        break

                except Exception as e:
                    message = 'Try another element...'
                    print(print_scrapper, message)
                    scrapper.logger(message, node)
        
        except Exception as e:
            scrapper_logic.relaunchScrapper(driver, print_scrapper)
