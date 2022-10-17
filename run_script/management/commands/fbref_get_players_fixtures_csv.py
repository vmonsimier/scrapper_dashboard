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
    def handle(self, *args, **options):
        options = webdriver.ChromeOptions()
        options.add_argument('--no-sandbox')
        options.add_argument('--disable-dev-shm-usage')        
        print('Launching webdriver remote...')
        driver = webdriver.Remote(command_executor="http://127.0.0.1:4444/wd/hub", options=options)
    
        print('connection established.')
        
        try:
            bcolors = Colors()
            scrapper_logic = ScrapperLogic()
            scrapper = Scrapper()

            # We retrieve active links for scrapper in django model Scrapper_Active_Links
            active_links = Scrapper_Active_Links.objects.filter(scrapper_id=2)
            
            for i in range(0, len(active_links)):
                driver.get(active_links[i].link)

                league = active_links[i].league

                if i == 0:
                    driver.maximize_window()
                    scrapper_logic.clickCookiesAccept(driver)
                    time.sleep(2)

                
                time.sleep(2)
                scrapper_logic.removeFooterWrapper(driver)
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
                        print(bcolors.FAIL + 'Cannot find title. Try another xpath..' + bcolors.ENDC)

                try:
                    match_season = re.search(r"[0-9]{4}", season.get_attribute("innerText")).group(0)
                except Exception as e:
                    print(e)
                    
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
                        print(bcolors.FAIL + 'Cannot find teams. Try another xpath...' + bcolors.ENDC)

                if len(teams) == 0:
                    # We log error into db
                    print(bcolors.FAIL, 'Teams are empty')
                    log = ScrapperLogs(scrapper_id=2, type='error', text='Teams are empty', date="")
                    log.save()
                    

                teams_links = []
                teams_names = []

                # We retrieve team links already scrapped
                exclude_teams = Exclude_Team_Links.objects.filter(scrapper_id=2)
                exclude_teams = list(map(lambda x: x.link, exclude_teams))

                for team in teams:
                    if team.get_attribute('href') not in exclude_teams:
                        print(bcolors.OKBLUE + team.get_attribute('href'))
                        teams_links.append(team.get_attribute('href'))
                        teams_names.append(team.get_attribute("innerText"))

                for j in range(0, len(teams_links)):

                    driver.get(teams_links[j])

                    time.sleep(3)
                    scrapper_logic.removeFooterWrapper(driver)
                    scrapper_logic.removeAdsiFrame(driver)
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
                            print('No to player fixture is not on the page. Try another one')

                    if len(fixtures_links) == 0:
                        print(bcolors.FAIL, 'Players are empty')
                        driver.quit()

                    fixtures_players = []

                    for fixture_link in fixtures_links:
                        fixtures_players.append(fixture_link.get_attribute('href'))
                        print(bcolors.OKCYAN + fixture_link.get_attribute('href'))

                    print(bcolors.WARNING + 'Number of players : ' + str(len(fixtures_players)) + bcolors.ENDC)

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
                        print(bcolors.WARNING + 'Go to ', fixture_player + bcolors.ENDC)

                        time.sleep(2)
                        scrapper_logic.removeFooterWrapper(driver)
                        scrapper_logic.removeAdsiFrame(driver)
                        time.sleep(2)
                        try:
                            player_name = driver.find_element_by_xpath('//*[@id="meta"]/div[2]/h1/span[1]')
                            player_name = player_name.get_attribute('innerText')
                            print(player_name)
                        except NoSuchElementException:
                            print(bcolors.FAIL + "Cannot find player name..." + bcolors.ENDC)

                        if player_name == None:
                            # We log error into db
                            print(bcolors.FAIL + 'Cannot retrieve player name')
                            log = ScrapperLogs(scrapper_id=2, type='error', text='Cannot find player name', date=datetime.now(timezone.utc))
                            log.save()

                        element = driver.find_element_by_xpath('//*[@id="matchlogs_all_sh"]/div/ul/li[2]/span')
                        scrollTo = str(int(element.location['y']) - 200)

                        driver.execute_script("window.scrollTo(0, {});".format(scrollTo))

                        time.sleep(2)

                        filename = 'genstats_' + teams_names[j] + '_' + player_name + '_' + match_season + '.csv'

                        if scrapper.checkFileExists(2, league, filename):

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

                                    element = scrapper_logic.retrieveStats(driver, 2, league, filename, selectors)

                                    if element:
                                        break

                                except Exception as e:
                                    print(bcolors.FAIL + 'Try another element...') 


                        filename = 'passes_' + player_name + '_' + teams_names[j] + '_' + match_season + '.csv'

                        if scrapper.checkFileExists(2, league, filename):
                            try:
                                passes = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[2]/a')
                            except:
                                passes = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[2]/div[2]/a')

                            if passes:
                                time.sleep(2)
                                scrapper_logic.removeFooterWrapper(driver)
                                scrapper_logic.removeAdsiFrame(driver)
                                time.sleep(2)
                                
                                self.retrieveSpecificData(driver, league, filename)
                                
                                time.sleep(3)
                        
                        filename = 'passes_type_' + player_name + '_' + teams_names[j] + '_' + match_season + '.csv'

                        if scrapper.checkFileExists(2, league, filename):
                            try:
                                passes_type = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[3]/a')
                            except:
                                passes_type = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[2]/div[3]/a')

                            if passes_type:
                                time.sleep(2)
                                scrapper_logic.removeFooterWrapper(driver)
                                scrapper_logic.removeAdsiFrame(driver)
                                time.sleep(2)

                                self.retrieveSpecificData(driver, league, filename)

                                time.sleep(3)
                        

                        filename = 'penalty_prep_' + player_name + '_' + teams_names[j] + '_' + match_season + '.csv'

                        if scrapper.checkFileExists(2, league, filename):
                            try:
                                penalty_prep = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[4]/a')
                            except:
                                penalty_prep = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[2]/div[4]/a')

                            if penalty_prep:
                                time.sleep(2)
                                scrapper_logic.removeFooterWrapper(driver)
                                scrapper_logic.removeAdsiFrame(driver)
                                time.sleep(2)

                                self.retrieveSpecificData(driver, league, filename)
                                
                                time.sleep(3)
                        
                        filename = 'defensive_actions_' + player_name + '_' + teams_names[j] + '_' + match_season + '.csv'
                        
                        if scrapper.checkFileExists(2, league, filename):
                            try:
                                defensive_actions = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[5]/a')
                            except:
                                defensive_actions = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[2]/div[5]/a')

                            if defensive_actions:
                                time.sleep(2)
                                scrapper_logic.removeFooterWrapper(driver)
                                scrapper_logic.removeAdsiFrame(driver)
                                time.sleep(2)

                                self.retrieveSpecificData(driver, league, filename)

                                time.sleep(3)
                        
                        filename = 'possession_' + player_name + '_' + teams_names[j] + '_' + match_season + '.csv'

                        if scrapper.checkFileExists(2, league, filename):
                            try:
                                possession = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[6]/a')
                            except:
                                possession = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[2]/div[6]/a')


                            if possession:
                                time.sleep(2)
                                scrapper_logic.removeFooterWrapper(driver)
                                scrapper_logic.removeAdsiFrame(driver)
                                time.sleep(2)

                                self.retrieveSpecificData(driver, league, filename)

                                time.sleep(3)
                        
                        filename = 'various_stats_' + player_name + '_' + teams_names[j] + '_' + match_season + '.csv'

                        if scrapper.checkFileExists(2, league, filename):
                            try:
                                various_stats = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[7]/a')
                            except:
                                various_stats = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[2]/div[7]/a')

                            if various_stats:
                                time.sleep(2)
                                scrapper_logic.removeFooterWrapper(driver)
                                scrapper_logic.removeAdsiFrame(driver)
                                time.sleep(2)

                                self.retrieveSpecificData(driver, league, filename)
                        
                        try:
                            keeper = scrapper_logic.checkElementExists(driver, '//*[@id="content"]/div[3]/div[8]/a')
                        except:
                            keeper = scrapper_logic.checkElementExists(driver, '//*[@id="content"]/div[2]/div[8]/a')
                                                
                        if keeper:
                            filename = 'keeper_' + player_name + '_' + teams_names[j] + '_' + match_season + '.csv'

                            if scrapper.checkFileExists(2, league, filename):
                                try:
                                    click_keeper = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[8]/a')
                                except:
                                    click_keeper = scrapper_logic.clickButton(driver, '//*[@id="content"]/div[3]/div[8]/a')

                                if click_keeper:
                                    time.sleep(2)
                                    scrapper_logic.removeFooterWrapper(driver)
                                    scrapper_logic.removeAdsiFrame(driver)
                                    time.sleep(2)

                                    self.retrieveSpecificData(driver, league, filename)


                        logText = 'Done player ' + player_name + ' | team ' + teams_names[j] + ' | ' + match_season
                        print(bcolors.OKGREEN + logText)
                        # We add exclude player links to database for next execution
                        exclude_player = Exclude_Player_Links(scrapper_id=2, link=fixture_player)
                        exclude_player.save()

                    exclude_team = Exclude_Team_Links(scrapper_id=2, link=teams_links[j])
                    exclude_team.save()

                Scrapper_Active_Links.objects.filter(link=active_links[i]).delete()
        except Exception as e:
            url_stop = 'http://localhost:3000/stop_scrapper'
            url_start = 'http://localhost:3000/execute_scrapper'
            body = json.dumps({'body': {'path': 'fbref_get_players_fixtures_csv'}})
            
            r = requests.post(url=url_stop, data=body)
            r = requests.post(url=url_start, data=body)


    def retrieveSpecificData(self, driver, league, filename):
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
                        element = scrapper_logic.retrieveStats(driver, 2, league, filename, selectors)
                    except Exception as e:
                        print('Error retrieving file', e)

                    if element:
                        break

                except Exception as e:
                    print('Try another element...')
        
        except Exception as e:
            print('Error retrieving specific data', e)
            self.retrieveSpecificData(driver, league, filename)
