from selenium import webdriver
from selenium.common.exceptions import NoSuchElementException
from selenium.webdriver.support.ui import WebDriverWait
import re
import time
import subprocess
import os

from django.core.management.base import BaseCommand
from run_script.models import *

from ..basis.scrapper import bcolors
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

        scrapper_logic = ScrapperLogic()

        try:
            # We retrieve active links for scrapper in django model Scrapper_Active_Links
            active_links = Scrapper_Active_Links.objects.filter(scrapper_id=1)

            for i in range(0, len(active_links)):
                driver.get(active_links[i].link)

                league = active_links[i].league
                print(league)

                time.sleep(2)

                if i == 0:
                    driver.maximize_window()
                    driver.find_element_by_xpath('/html/body/div[1]/div/div/div/div[2]/div/button[3]').click()
                    time.sleep(1)

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
                        print(bcolors.FAIL + 'Cannot find title. Try another xpath..')

                match_season = re.search(r"[0-9]{4}", season.get_attribute("innerText")).group(0)
                print(match_season)
                driver.execute_script("window.scrollTo(0, 750);")

                time.sleep(5)

                tname_links = [
                    "/html/body/div[3]/div[6]/div[2]/div[4]/div[2]/table/tbody/tr/td[1]/a",
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
                        print(bcolors.FAIL + 'Cannot find teams. Try another xpath...')

                if len(teams) == 0:
                    print(bcolors.FAIL, 'Teams are empty')

                teams_links = []
                teams_names = []

                # We retrieve team links already scrapped
                exclude_teams = Exclude_Team_Links.objects.filter(scrapper_id=1)
                exclude_teams = list(map(lambda x: x.link, exclude_teams))
                
                for team in teams:
                    if team.get_attribute('href') not in exclude_teams:
                        print(team.get_attribute('href'))
                        teams_links.append(team.get_attribute('href'))
                        teams_names.append(team.get_attribute("innerText"))


                for j in range(0, len(teams_links)):

                    driver.get(teams_links[j])

                    time.sleep(3)

                    scrapper_logic.removeAdsiFrame(driver)

                    ############################################################################################################
                    #
                    # STATS BASIQUES
                    #
                    ############################################################################################################

                    filename = 'genstats_' + teams_names[j] + '_' + match_season + '.csv'
                    
                    menu_link_selector = '//*[@id="stats_standard_{0}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_standard_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])
                    pre_selector = '//*[@id="csv_stats_standard_{}"]'.format(leagueIds[league])
                    selectors = {
                        'menu_link': menu_link_selector,
                        'csv_link': csv_link_selector,
                        'pre_link': pre_selector
                    }

                    try:
                        scrapper_logic.retrieveStats(driver, filename, selectors)
                    except:
                        scrapper_logic.retrieveStats(driver, filename, selectors)

                    
                    ############################################################################################################
                    #
                    # GOALKEEPER
                    #
                    ############################################################################################################
                    

                    time.sleep(2)

                    filename = 'goalkeeper_' + teams_names[j] + '_' + match_season + '.csv'

                    menu_link_selector = '//*[@id="stats_keeper_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_keeper_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])
                    pre_selector = '//*[@id="csv_stats_keeper_{}"]'.format(leagueIds[league])
                    
                    selectors = {
                        'menu_link': menu_link_selector,
                        'csv_link': csv_link_selector,
                        'pre_link': pre_selector
                    }

                    keeper = scrapper_logic.checkElementExists(driver, menu_link_selector)

                    if keeper:
                        try:
                            scrapper_logic.retrieveStats(driver, filename, selectors)
                        except:
                            scrapper_logic.retrieveStats(driver, filename, selectors)
                    

                    ############################################################################################################
                    #
                    # GOALKEEPER ADVANCED
                    #
                    ############################################################################################################
                    time.sleep(2)

                    filename = 'goalkeeper_adv' + teams_names[j] + '_' + match_season + '.csv'
                
                    menu_link_selector = '//*[@id="stats_keeper_adv_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_keeper_adv_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])
                    pre_selector = '//*[@id="csv_stats_keeper_adv_{}"]'.format(leagueIds[league])
                    selectors = {
                        'menu_link': menu_link_selector,
                        'csv_link': csv_link_selector,
                        'pre_link': pre_selector
                    }

                    keeper_advanced = scrapper_logic.checkElementExists(driver, menu_link_selector)

                    if keeper_advanced:
                        try:
                            scrapper_logic.retrieveStats(driver, filename, selectors)
                        except:
                            scrapper_logic.retrieveStats(driver, filename, selectors)


                     ############################################################################################################
                    #
                    # SHOTS
                    #
                    ############################################################################################################

                    time.sleep(2)

                    filename = 'shots_' + teams_names[j] + '_' + match_season + '.csv'

                    menu_link_selector = '//*[@id="stats_shooting_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_shooting_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])
                    pre_selector = '//*[@id="csv_stats_shooting_{}"]'.format(leagueIds[league])
                    selectors = {
                        'menu_link': menu_link_selector,
                        'csv_link': csv_link_selector,
                        'pre_link': pre_selector
                    }

                    shots = scrapper_logic.checkElementExists(driver, menu_link_selector)

                    if shots:
                        try:
                            scrapper_logic.retrieveStats(driver, filename, selectors)
                        except:
                            scrapper_logic.retrieveStats(driver, filename, selectors)
                   

                    ############################################################################################################
                    #
                    # PASSES
                    #
                    ############################################################################################################
                    
                    time.sleep(2)

                    filename = 'passes_' + teams_names[j] + '_' + match_season + '.csv'

                    menu_link_selector = '//*[@id="stats_passing_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_passing_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])
                    pre_selector = '//*[@id="csv_stats_passing_{}"]'.format(leagueIds[league])
                    selectors = {
                        'menu_link': menu_link_selector,
                        'csv_link': csv_link_selector,
                        'pre_link': pre_selector
                    }

                    passes = scrapper_logic.checkElementExists(driver, menu_link_selector)

                    if passes:
                        try:
                            scrapper_logic.retrieveStats(driver, filename, selectors)
                        except:
                            scrapper_logic.retrieveStats(driver, filename, selectors)


                    ############################################################################################################
                    #
                    # PASSES TYPE
                    #
                    ############################################################################################################
                    
                    time.sleep(2)

                    filename = 'passes_type_' + teams_names[j] + '_' + match_season + '.csv'

                    menu_link_selector = '//*[@id="stats_passing_types_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_passing_types_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])
                    pre_selector = '//*[@id="csv_stats_passing_types_{}"]'.format(leagueIds[league])
                    selectors = {
                        'menu_link': menu_link_selector,
                        'csv_link': csv_link_selector,
                        'pre_link': pre_selector
                    }

                    passes_type = scrapper_logic.checkElementExists(driver, menu_link_selector)

                    if passes_type:
                        try:
                            scrapper_logic.retrieveStats(driver, filename, selectors)
                        except:
                            scrapper_logic.retrieveStats(driver, filename, selectors)


                    ############################################################################################################
                    #
                    # PENALTY PREPARATION
                    #
                    ############################################################################################################
                    
                    time.sleep(2)

                    filename = 'penalty_preparation_' + teams_names[j] + '_' + match_season + '.csv'

                    menu_link_selector = '//*[@id="stats_gca_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_gca_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])
                    pre_selector = '//*[@id="csv_stats_gca_{}"]'.format(leagueIds[league])
                    selectors = {
                        'menu_link': menu_link_selector,
                        'csv_link': csv_link_selector,
                        'pre_link': pre_selector
                    }

                    free_kick = scrapper_logic.checkElementExists(driver, menu_link_selector)

                    if free_kick:
                        try:
                            scrapper_logic.retrieveStats(driver, filename, selectors)
                        except:
                            scrapper_logic.retrieveStats(driver, filename, selectors)


                    ############################################################################################################
                    #
                    # DEFENSIVE ACTIONS
                    #
                    ############################################################################################################
                        
                    time.sleep(2)

                    filename = 'defensive_actions_' + teams_names[j] + '_' + match_season + '.csv'  

                    menu_link_selector = '//*[@id="stats_defense_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_defense_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])
                    pre_selector = '//*[@id="csv_stats_defense_{}"]'.format(leagueIds[league])
                    selectors = {
                        'menu_link': menu_link_selector,
                        'csv_link': csv_link_selector,
                        'pre_link': pre_selector
                    }

                    defensive_actions = scrapper_logic.checkElementExists(driver, menu_link_selector)

                    if defensive_actions:
                        try:
                            scrapper_logic.retrieveStats(driver, filename, selectors)
                        except:
                            scrapper_logic.retrieveStats(driver, filename, selectors)

                    ############################################################################################################
                    #
                    # POSSESSION
                    #
                    ############################################################################################################
                        
                    time.sleep(2)

                    filename = 'possession_' + teams_names[j] + '_' + match_season + '.csv'

                    menu_link_selector = '//*[@id="stats_possession_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_possession_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])
                    pre_selector = '//*[@id="csv_stats_possession_{}"]'.format(leagueIds[league])
                    selectors = {
                        'menu_link': menu_link_selector,
                        'csv_link': csv_link_selector,
                        'pre_link': pre_selector
                    }

                    possession = scrapper_logic.checkElementExists(driver, menu_link_selector)

                    if possession:
                        try:
                            scrapper_logic.retrieveStats(driver, filename, selectors)
                        except:
                            scrapper_logic.retrieveStats(driver, filename, selectors)


                    ############################################################################################################
                    #
                    # PLAYING TIME
                    #
                    ############################################################################################################

                    time.sleep(2)
                    
                    filename = 'playing_time_' + teams_names[j] + '_' + match_season + '.csv'

                    menu_link_selector = '//*[@id="stats_playing_time_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_playing_time_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])
                    pre_selector = '//*[@id="csv_stats_playing_time_{}"]'.format(leagueIds[league])
                    selectors = {
                        'menu_link': menu_link_selector,
                        'csv_link': csv_link_selector,
                        'pre_link': pre_selector
                    }

                    playing_time = scrapper_logic.checkElementExists(driver, menu_link_selector)

                    if playing_time:
                        try:
                            scrapper_logic.retrieveStats(driver, filename, selectors)
                        except:
                            scrapper_logic.retrieveStats(driver, filename, selectors)

                    ############################################################################################################
                    #
                    # VARIOUS STATISTICS
                    #
                    ############################################################################################################
                    
                    time.sleep(2)

                    filename = 'various_statistics_' + teams_names[j] + '_' + match_season + '.csv'

                    menu_link_selector = '//*[@id="stats_misc_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_misc_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])
                    pre_selector = '//*[@id="csv_stats_misc_{}"]'.format(leagueIds[league])
                    selectors = {
                        'menu_link': menu_link_selector,
                        'csv_link': csv_link_selector,
                        'pre_link': pre_selector
                    }

                    various_stats = scrapper_logic.checkElementExists(driver, menu_link_selector)

                    if various_stats:
                        try:
                            scrapper_logic.retrieveStats(driver, filename, selectors)
                        except:
                            scrapper_logic.retrieveStats(driver, filename, selectors)

                    exclude_player = Exclude_Player_Links(scrapper_id=1, link=teams_links[j])
                    exclude_player.save()
                # We delete the active link from db
                Scrapper_Active_Links.objects.filter(link=active_links[i].link).delete()

        except Exception as e:
            print('Unexpected error:', e)
            driver.close()
            driver.quit()
            os.environ['PATH'] += os.pathsep + '/usr/src/app/web/staticfiles/run_script/management/commands'
            process = subprocess.Popen(["python", 'manage.py', 'fbref_get_players_csv'])



