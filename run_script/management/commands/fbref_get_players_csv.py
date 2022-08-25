import csv
from selenium import webdriver
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.common.exceptions import NoSuchElementException, TimeoutException, StaleElementReferenceException, WebDriverException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from datetime import datetime, timezone
import re
import time
import subprocess
import os

from django.core.management.base import BaseCommand
from run_script.models import *

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

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
        driver = webdriver.Remote(command_executor="http://127.0.0.1:4445/wd/hub", options=options)
        print('connection established.')

        try:
            # We retrieve active links for scrapper in django model Scrapper_Active_Links
            active_links = Scrapper_Active_Links.objects.filter(scrapper_id=1)
            print(bcolors.OKBLUE, active_links)

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

                match_season = re.search(r"[0-9]{4}", season.text).group(0)
                print(match_season)
                driver.switch_to.default_content()
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

                    time.sleep(2)
                    driver.switch_to.default_content()

                    all_iframes = driver.find_elements_by_tag_name("iframe")
                    if len(all_iframes) > 0:
                        print("Ad Found\n")
                        driver.execute_script("""
                            let a = document.getElementsByClassName('adblock');
                            for(const l of a) {
                                l.style.height = 0;
                            }
                            """)
                        print('Total Ads: ' + str(len(all_iframes)))
                    else:
                        print('No frames found')

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
                        self.retrieveStats(driver, league, filename, selectors)
                    except:
                        self.retrieveStats(driver, league, filename, selectors)

                    
                    ############################################################################################################
                    #
                    # GOALKEEPER
                    #
                    ############################################################################################################
                    

                    time.sleep(2)

                    menu_link_selector = '//*[@id="stats_keeper_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_keeper_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])
                    pre_selector = '//*[@id="csv_stats_keeper_{}"]'.format(leagueIds[league])
                    
                    selectors = {
                        'menu_link': menu_link_selector,
                        'csv_link': csv_link_selector,
                        'pre_link': pre_selector
                    }     
                        
                    filename = 'goalkeeper_' + teams_names[j] + '_' + match_season + '.csv'

                    try:
                        self.retrieveStats(driver, league, filename, selectors)
                    except:
                        self.retrieveStats(driver, league, filename, selectors)
                    

                    ############################################################################################################
                    #
                    # GOALKEEPER ADVANCED
                    #
                    ############################################################################################################
                
                    menu_link_selector = '//*[@id="stats_keeper_adv_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_keeper_adv_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])
                    pre_selector = '//*[@id="csv_stats_keeper_adv_{}"]'.format(leagueIds[league])
                    selectors = {
                        'menu_link': menu_link_selector,
                        'csv_link': csv_link_selector,
                        'pre_link': pre_selector
                    }

                    keeper_advanced = self.checkElementExists(driver, menu_link_selector)

                    if keeper_advanced:
                        try:
                            self.retrieveStats(driver, league, filename, selectors)
                        except:
                            self.retrieveStats(driver, league, filename, selectors)


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

                    shots = self.checkElementExists(driver, menu_link_selector)

                    if shots:
                        try:
                            self.retrieveStats(driver, league, filename, selectors)
                        except:
                            self.retrieveStats(driver, league, filename, selectors)
                   

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

                    passes = self.checkElementExists(driver, menu_link_selector)

                    if passes:
                        try:
                            self.retrieveStats(driver, league, filename, selectors)
                        except:
                            self.retrieveStats(driver, league, filename, selectors)


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

                    passes_type = self.checkElementExists(driver, menu_link_selector)

                    if passes_type:
                        try:
                            self.retrieveStats(driver, league, filename, selectors)
                        except:
                            self.retrieveStats(driver, league, filename, selectors)


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

                    free_kick = self.checkElementExists(driver, menu_link_selector)

                    if free_kick:
                        try:
                            self.retrieveStats(driver, league, filename, selectors)
                        except:
                            self.retrieveStats(driver, league, filename, selectors)


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

                    defensive_actions = self.checkElementExists(driver, menu_link_selector)

                    if defensive_actions:
                        try:
                            self.retrieveStats(driver, league, filename, selectors)
                        except:
                            self.retrieveStats(driver, league, filename, selectors)

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

                    possession = self.checkElementExists(driver, menu_link_selector)

                    if possession:
                        try:
                            self.retrieveStats(driver, league, filename, selectors)
                        except:
                            self.retrieveStats(driver, league, filename, selectors)


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

                    playing_time = self.checkElementExists(driver, menu_link_selector)

                    if playing_time:
                        try:
                            self.retrieveStats(driver, league, filename, selectors)
                        except:
                            self.retrieveStats(driver, league, filename, selectors)

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

                    various_stats = self.checkElementExists(driver, menu_link_selector)

                    if various_stats:
                        try:
                            self.retrieveStats(driver, league, filename, selectors)
                        except:
                            self.retrieveStats(driver, league, filename, selectors)
                
                # We delete the active link from db
                Scrapper_Active_Links.objects.filter(link=active_links[i].link).delete()

        except Exception as e:
            print('Unexpected error:', e)
            driver.close()
            driver.quit()
            os.environ['PATH'] += os.pathsep + '/usr/src/app/web/staticfiles/run_script/management/commands'
            process = subprocess.Popen(["python", 'manage.py', 'fbref_get_players_csv'])

    def checkElementExists(self, driver, xpath):
        try:
            driver.find_element_by_xpath(xpath)
        except NoSuchElementException:
            return False
        return True

    def retrieveStats(self, driver, league, filename, selectors):        
        time.sleep(2)
        
        element = driver.find_element_by_xpath(selectors['menu_link'])
        scrollTo = str(int(element.location['y']) - 200)

        print('Scroll to', int(scrollTo))

        driver.switch_to.default_content()
        driver.execute_script("window.scrollTo(0, {});".format(scrollTo))

        time.sleep(2)

        self.hoverDropdownMenu(driver, selectors['menu_link'])

        try:
            get_csv = self.retrieveCsvDropdown(driver, selectors['csv_link'])
        except StaleElementReferenceException as e:
            print(bcolors.FAIL + 'StaleElementReferenceException: relaunch hovering element and retrieveCsvDropdown()...')
            self.hoverDropdownMenu(driver, csv_links)
            get_csv = self.retrieveCsvDropdown(driver, selectors['csv_link'])

        try:
            click_link = ActionChains(driver).move_to_element(get_csv)
            click_link.click().perform()
            csv_to_insert = driver.find_element_by_xpath(selectors['pre_link'])
        except Exception as e:
            log = ScrapperLogs(scrapper_id=1, type='error', text='Cannot click on the element', date=datetime.now(timezone.utc))
            log.save()

        #self.saveCsvFile()

    def saveCsvFile(self, filename):
        
        if not os.path.exists("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/genstats/{1}".format(league,filename)):
            print(filename)
            f = open("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/genstats/{1}".format(league ,filename), "w")
            f.write(csv_to_insert.text)
            f.close()
        else: 
            print('File already exists')

        print('Save {}'.format(filename))

        return -1


    def hoverDropdownMenu(self, driver, menu_link):
        export_menu = None
        try:
            driver.switch_to.default_content()
            export_menu = driver.find_element_by_xpath(menu_link)
            time.sleep(2)
        except NoSuchElementException:
            print(bcolors.FAIL + "Oups element of dropdown menu is not on the page...")

        if export_menu != None:
            try:
                driver.switch_to.default_content()
                hover_export = ActionChains(driver).move_to_element(export_menu)
                hover_export.perform()
                print(bcolors.OKGREEN, 'Hover is performed. Success?')
            except StaleElementReferenceException:
                print(bcolors.FAIL + "Oups an error has occured while performing hover...")


    def retrieveCsvDropdown(self, driver, csv_link):
        wait = WebDriverWait(driver, 8)

        try:
            get_csv = wait.until(EC.element_to_be_clickable((By.XPATH, csv_link)))
            if get_csv != None:
                return get_csv
        except TimeoutException:
            print(bcolors.FAIL + csv_link + " is not on the page..." + bcolors.ENDC)
        
        raise StaleElementReferenceException('No link for csv on page...')