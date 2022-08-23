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
        
        try:
            options = webdriver.ChromeOptions()
            options.add_argument('--no-sandbox')
            options.add_argument('--disable-dev-shm-usage')      
            print('Launching webdriver remote...')
            driver = webdriver.Remote(command_executor="http://127.0.1.1:4444/wd/hub",desired_capabilities=DesiredCapabilities.CHROME, options=options)
            print('connection established.')
        
            # We retrieve active links for scrapper in django model Scrapper_Active_Links
            active_links = Scrapper_Active_Links.objects.filter(scrapper_id=1)
            print(bcolors.OKBLUE, active_links)

            for i in range(0, len(active_links)):
                driver.get(active_links[i].link)

                league = active_links[i].league
                print(league)

                time.sleep(5)

                if i == 0:
                    driver.maximize_window()
                    driver.find_element_by_xpath('/html/body/div[1]/div/div/div/div[2]/div/button[3]').click()
                    time.sleep(5)

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

                    print('retriev position')

                    menu_link_selector = '//*[@id="stats_defense_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])

                    e = driver.find_element_by_xpath(menu_link_selector)

                    print('Location;', e.location)

                    time.sleep(10)

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

                    filename = 'genstats_' + teams_names[j] + '_' + match_season + '.csv'

                    try:
                        self.retrieveStatsBasics(driver,filename, league)
                    except:
                        self.retrieveStatsBasics(driver, filename, league)

                    
                    ############################################################################################################
                    #
                    # GOALKEEPER
                    #
                    ############################################################################################################
                    
                    time.sleep(2)

                    if int(match_season) > 2016:
                        driver.execute_script("window.scrollTo(750, 2600);")
                    else:
                        driver.execute_script("window.scrollTo(750, 2300);")

                    time.sleep(2)

                    menu_link_selector = '//*[@id="stats_keeper_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_keeper_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])

                    menu_links = [
                        menu_link_selector,
                        '/html/body/div[3]/div[6]/div[8]/div[1]/div/ul/li[1]/span',
                        '/html/body/div[3]/div[6]/div[6]/div[1]/div/ul/li[1]/span'
                    ]

                    self.hoverDropdownMenu(driver, menu_links)

                    csv_links = [
                        csv_link_selector,
                        '/html/body/div[3]/div[6]/div[8]/div[1]/div/ul/li[1]/div/ul/li[4]/button',
                        '/html/body/div[3]/div[6]/div[6]/div[1]/div/ul/li[1]/div/ul/li[4]/button'
                    ]
                    
                    try:
                        get_csv = self.retrieveCsvDropdown(driver, csv_links)
                    except StaleElementReferenceException as e:
                        print(bcolors.FAIL + 'StaleElementReferenceException: relaunch hovering element and retrieveCsvDropdown()...')
                        self.hoverDropdownMenu(driver, menu_links)
                        get_csv = self.retrieveCsvDropdown(driver, csv_links)

                    try:
                        click_link = ActionChains(driver).move_to_element(get_csv)
                        click_link.click().perform()
                        pre = [
                            '/html/body/div[3]/div[6]/div[8]/div[2]/div/pre',
                            '/html/body/div[3]/div[6]/div[6]/div[2]/div/pre'
                        ]
                        
                        for p in pre: 
                            try:
                                csv_to_insert = driver.find_element_by_xpath(p)
                                break
                            except Exception as e:
                                print('Pre not found')
                                continue
                        

                    except Exception as e:
                        # We log error into db
                        print(e, 'Relaunch page...')
                        log = ScrapperLogs(scrapper_id=1, type='error', text='Cannot click on the element', date=datetime.now(timezone.utc))
                        log.save()                    
                        
                    filename = 'goalkeeper_' + teams_names[j] + '_' + match_season + '.csv'

                    if not os.path.exists("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/goalkeeper/{1}".format(league,filename)):
                        f = open("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/goalkeeper/{1}".format(league,filename), "w")
                        f.write(csv_to_insert.text)
                        f.close()
                    else: 
                        print('File already exists')

                    print('Save goalkeeper')
                    

                    ############################################################################################################
                    #
                    # GOALKEEPER ADVANCED
                    #
                    ############################################################################################################
                
                    

                    if int(match_season) > 2016:
                        time.sleep(2)
                        driver.execute_script("window.scrollTo(2600, 2900);")
                        time.sleep(2)

                        try:
                            menu_link_selector = '//*[@id="stats_keeper_adv_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                            csv_link_selector = '//*[@id="stats_keeper_adv_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])

                            menu_links = [
                                menu_link_selector,
                                '/html/body/div[3]/div[6]/div[10]/div[1]/div/ul/li[1]/span',
                                '/html/body/div[3]/div[6]/div[7]/div[1]/div/ul/li[1]/span'
                            ]

                            self.hoverDropdownMenu(driver, menu_links)

                            csv_links = [
                                csv_link_selector,
                                '/html/body/div[3]/div[6]/div[10]/div[1]/div/ul/li[1]/div/ul/li[4]/button',
                                '/html/body/div[3]/div[6]/div[7]/div[1]/div/ul/li[1]/div/ul/li[4]/button'
                            ]
                            
                            try:
                                get_csv = self.retrieveCsvDropdown(driver, csv_links)
                            except StaleElementReferenceException as e:
                                print(bcolors.FAIL + 'StaleElementReferenceException: relaunch hovering element and retrieveCsvDropdown()...')
                                self.hoverDropdownMenu(driver, menu_links)
                                get_csv = self.retrieveCsvDropdown(driver, csv_links)

                            try:
                                click_link = ActionChains(driver).move_to_element(get_csv)
                                click_link.click().perform()
                                
                                pre = [
                                    '/html/body/div[3]/div[6]/div[10]/div[2]/div/pre',
                                    '/html/body/div[3]/div[6]/div[7]/div[2]/div/pre'
                                    
                                ]
                                
                                for p in pre: 
                                    try:
                                        csv_to_insert = driver.find_element_by_xpath(p)
                                        break
                                    except Exception as e:
                                        print('Pre not found')
                                        continue

                            except Exception as e:
                                # We log error into db
                                print(e)
                                log = ScrapperLogs(scrapper_id=1, type='error', text='Cannot click on the element', date=datetime.now(timezone.utc))
                                log.save()                    
                                    
                            filename = 'goalkeeper_advanced_' + teams_names[j] + '_' + match_season + '.csv'
                            if not os.path.exists("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/goalkeeper/{1}".format(league,filename)):
                                f = open("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/goalkeeper/{1}".format(league,filename), "w")
                                f.write(csv_to_insert.text)
                                f.close()
                            else: 
                                print('File already exists')

                            print('Save goalkeeper advanced')
                            time.sleep(2)

                            driver.execute_script("window.scrollTo(2900, 3200);")

                        except NoSuchElementException as e:
                            print("There is no stats for goalkeeper advanced")
                    else:
                        driver.execute_script("window.scrollTo(2300, 2700);")


                     ############################################################################################################
                    #
                    # SHOTS
                    #
                    ############################################################################################################

                    time.sleep(2)


                    menu_link_selector = '//*[@id="stats_shooting_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_shooting_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])


                    menu_links = [
                        menu_link_selector,
                        '/html/body/div[3]/div[6]/div[11]/div[1]/div/ul/li[1]/span',
                        '/html/body/div[3]/div[6]/div[9]/div[1]/div/ul/li[1]/span'
                    ]

                    self.hoverDropdownMenu(driver, menu_links)

                    csv_links = [
                        csv_link_selector,
                        '/html/body/div[3]/div[6]/div[11]/div[1]/div/ul/li[1]/div/ul/li[4]/button',
                        '/html/body/div[3]/div[6]/div[9]/div[1]/div/ul/li[1]/div/ul/li[4]/button'
                    ]

                    try:
                        get_csv = self.retrieveCsvDropdown(driver, csv_links)
                    except StaleElementReferenceException as e:
                        print(bcolors.FAIL + 'StaleElementReferenceException: relaunch hovering element and retrieveCsvDropdown()...')
                        self.hoverDropdownMenu(driver, menu_links)
                        get_csv = self.retrieveCsvDropdown(driver, csv_links)

                    try:
                        click_link = ActionChains(driver).move_to_element(get_csv)
                        click_link.click().perform()
                        
                        pre = [
                            '/html/body/div[3]/div[6]/div[11]/div[2]/div/pre',
                            '/html/body/div[3]/div[6]/div[9]/div[2]/div/pre'
                        ]
                        
                        for p in pre: 
                            try:
                                csv_to_insert = driver.find_element_by_xpath(p)
                                break
                            except Exception as e:
                                print('Pre not found')
                                continue

                    except Exception as e:
                        # We log error into db
                        print(e, 'Relaunch page...')
                        # driver.close()
                        # driver.quit()
                        # os.environ['PATH'] += os.pathsep + '/usr/src/app/web/staticfiles/run_script/management/commands'
                        # process = subprocess.Popen(["python", 'manage.py', 'fbref_get_players_csv'])
                        # log = ScrapperLogs(scrapper_id=1, type='error', text='Cannot click on the element', date=datetime.now(timezone.utc))
                        # log.save()                    
                    filename = 'shots_' + teams_names[j] + '_' + match_season + '.csv'
                    
                    if not os.path.exists("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/shots/{1}".format(league,filename)):
                        f = open("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/shots/{1}".format(league,filename), "w")
                        f.write(csv_to_insert.text)
                        f.close()
                    else: 
                        print('File already exists')

                    print('Save shots advanced')


                     ############################################################################################################
                    #
                    # PASSES
                    #
                    ############################################################################################################
                    
                    if int(match_season) > 2016:
                        time.sleep(2)

                        driver.execute_script("window.scrollTo(3200, 4000);")

                        time.sleep(2)


                        menu_link_selector = '//*[@id="stats_passing_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                        csv_link_selector = '//*[@id="stats_passing_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])


                        menu_links = [
                            menu_link_selector,
                            '/html/body/div[3]/div[6]/div[12]/div[1]/div/ul/li[1]/span',
                            '/html/body/div[3]/div[6]/div[10]/div[1]/div/ul/li[1]/span'
                        ]

                        self.hoverDropdownMenu(driver, menu_links)

                        csv_links = [
                            csv_link_selector,
                            '/html/body/div[3]/div[6]/div[12]/div[1]/div/ul/li[1]/div/ul/li[4]/button',
                            '/html/body/div[3]/div[6]/div[10]/div[1]/div/ul/li[1]/div/ul/li[4]/button'
                        ]

                        try:
                            get_csv = self.retrieveCsvDropdown(driver, csv_links)
                        except StaleElementReferenceException as e:
                            print(bcolors.FAIL + 'StaleElementReferenceException: relaunch hovering element and retrieveCsvDropdown()...')
                            self.hoverDropdownMenu(driver, menu_links)
                            get_csv = self.retrieveCsvDropdown(driver, csv_links)

                        try:
                            click_link = ActionChains(driver).move_to_element(get_csv)
                            click_link.click().perform()

                            pre = [
                                '/html/body/div[3]/div[6]/div[12]/div[2]/div/pre',
                                '/html/body/div[3]/div[6]/div[10]/div[2]/div/pre'
                            ]
                            
                            for p in pre: 
                                try:
                                    csv_to_insert = driver.find_element_by_xpath(p)
                                    break
                                except Exception as e:
                                    print('Pre not found')
                                    continue

                        except Exception as e:
                            # We log error into db
                            print(e)
                            log = ScrapperLogs(scrapper_id=1, type='error', text='Cannot click on the element', date=datetime.now(timezone.utc))
                            log.save()                    
                        filename = 'passes_' + teams_names[j] + '_' + match_season + '.csv'

                        if not os.path.exists("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/passes/{1}".format(league,filename)):
                            f = open("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/passes/{1}".format(league,filename), "w")
                            f.write(csv_to_insert.text)
                            f.close()
                        else: 
                            print('File already exists')

                        print('Save passes advanced')

                        ############################################################################################################
                        #
                        # PASSES TYPE
                        #
                        ############################################################################################################
                        
                        time.sleep(7)

                        driver.execute_script("window.scrollTo(4000, 4800);")

                        time.sleep(5)


                        menu_link_selector = '//*[@id="stats_passing_types_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                        csv_link_selector = '//*[@id="stats_passing_types_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])


                        menu_links = [
                            menu_link_selector,
                            '/html/body/div[3]/div[6]/div[14]/div[1]/div/ul/li[1]/span',
                            '/html/body/div[3]/div[6]/div[11]/div[1]/div/ul/li[1]/span'
                        ]

                        self.hoverDropdownMenu(driver, menu_links)

                        csv_links = [
                            csv_link_selector,
                            '/html/body/div[3]/div[6]/div[14]/div[1]/div/ul/li[1]/div/ul/li[4]/button',
                            '/html/body/div[3]/div[6]/div[11]/div[1]/div/ul/li[1]/div/ul/li[4]/button'
                        ]

                        try:
                            get_csv = self.retrieveCsvDropdown(driver, csv_links)
                        except StaleElementReferenceException as e:
                            print(bcolors.FAIL + 'StaleElementReferenceException: relaunch hovering element and retrieveCsvDropdown()...')
                            self.hoverDropdownMenu(driver, menu_links)
                            get_csv = self.retrieveCsvDropdown(driver, csv_links)

                        try:
                            click_link = ActionChains(driver).move_to_element(get_csv)
                            click_link.click().perform()
                            
                            pre = [
                                '/html/body/div[3]/div[6]/div[14]/div[2]/div/pre',
                                '/html/body/div[3]/div[6]/div[11]/div[2]/div/pre'
                            ]
                            
                            for p in pre: 
                                try:
                                    csv_to_insert = driver.find_element_by_xpath(p)
                                    break
                                except Exception as e:
                                    print('Pre not found')
                                    continue

                        except Exception as e:
                            # We log error into db
                            print(e, 'Relaunch page...')
                            log = ScrapperLogs(scrapper_id=1, type='error', text='Cannot click on the element', date=datetime.now(timezone.utc))
                            log.save()                    
                        filename = 'passes_type_' + teams_names[j] + '_' + match_season + '.csv'

                        if not os.path.exists("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/passes/{1}".format(league,filename)):
                            f = open("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/passes/{1}".format(league,filename), "w")
                            f.write(csv_to_insert.text)
                            f.close()
                        else: 
                            print('File already exists')

                        print('Save passes type')

                        ############################################################################################################
                        #
                        # PENALTY PREPARATION
                        #
                        ############################################################################################################
                        
                        time.sleep(7)

                        driver.execute_script("window.scrollTo(4800, 5600);")

                        time.sleep(5)

                        menu_link_selector = '//*[@id="stats_gca_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                        csv_link_selector = '//*[@id="stats_gca_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])


                        menu_links = [
                            menu_link_selector,
                            '/html/body/div[3]/div[6]/div[15]/div[1]/div/ul/li[1]/span',
                            '/html/body/div[3]/div[6]/div[13]/div[1]/div/ul/li[1]/span'
                        ]

                        self.hoverDropdownMenu(driver, menu_links)

                        csv_links = [
                            csv_link_selector,
                            '/html/body/div[3]/div[6]/div[15]/div[1]/div/ul/li[1]/div/ul/li[4]/button',
                            '/html/body/div[3]/div[6]/div[13]/div[1]/div/ul/li[1]/div/ul/li[4]/button'
                            
                        ]

                        try:
                            get_csv = self.retrieveCsvDropdown(driver, csv_links)
                        except StaleElementReferenceException as e:
                            print(bcolors.FAIL + 'StaleElementReferenceException: relaunch hovering element and retrieveCsvDropdown()...')
                            self.hoverDropdownMenu(driver, menu_links)
                            get_csv = self.retrieveCsvDropdown(driver, csv_links)

                        try:
                            click_link = ActionChains(driver).move_to_element(get_csv)
                            click_link.click().perform()

                            pre = [
                                '/html/body/div[3]/div[6]/div[15]/div[2]/div/pre',
                                '/html/body/div[3]/div[6]/div[13]/div[2]/div/pre'
                            ]
                            
                            for p in pre: 
                                try:
                                    csv_to_insert = driver.find_element_by_xpath(p)
                                    break
                                except Exception as e:
                                    print('Pre not found')
                                    continue

                        except Exception as e:
                            # We log error into db
                            print(e, 'Relaunch page...')
                            log = ScrapperLogs(scrapper_id=1, type='error', text='Cannot click on the element', date=datetime.now(timezone.utc))
                            log.save()                    
                        filename = 'penalty_preparation_' + teams_names[j] + '_' + match_season + '.csv'

                        if not os.path.exists("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/penalty/{1}".format(league,filename)):
                            f = open("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/penalty/{1}".format(league,filename), "w")
                            f.write(csv_to_insert.text)
                            f.close()
                        else: 
                            print('File already exists')

                        print('Save penalty preparation')

                        ############################################################################################################
                        #
                        # DEFENSIVE ACTIONS
                        #
                        ############################################################################################################
                        
                        time.sleep(7)

                        driver.execute_script("window.scrollTo(5600, 6300);")

                        time.sleep(5)

                        menu_link_selector = '//*[@id="stats_defense_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                        csv_link_selector = '//*[@id="stats_defense_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])


                        menu_links = [
                            menu_link_selector,
                            '/html/body/div[3]/div[6]/div[16]/div[1]/div/ul/li[1]/span',
                            '/html/body/div[3]/div[6]/div[14]/div[1]/div/ul/li[1]/span'
                        ]

                        self.hoverDropdownMenu(driver, menu_links)

                        csv_links = [
                            csv_link_selector,
                            '/html/body/div[3]/div[6]/div[16]/div[1]/div/ul/li[1]/div/ul/li[4]/button',
                            '/html/body/div[3]/div[6]/div[14]/div[1]/div/ul/li[1]/div/ul/li[4]/button'
                        ]

                        try:
                            get_csv = self.retrieveCsvDropdown(driver, csv_links)
                        except StaleElementReferenceException as e:
                            print(bcolors.FAIL + 'StaleElementReferenceException: relaunch hovering element and retrieveCsvDropdown()...')
                            self.hoverDropdownMenu(driver, menu_links)
                            get_csv = self.retrieveCsvDropdown(driver, csv_links)

                        try:
                            click_link = ActionChains(driver).move_to_element(get_csv)
                            click_link.click().perform()
                            
                            pre = [
                                '/html/body/div[3]/div[6]/div[16]/div[2]/div/pre',
                                '/html/body/div[3]/div[6]/div[14]/div[2]/div/pre'
                            ]
                            
                            for p in pre: 
                                try:
                                    csv_to_insert = driver.find_element_by_xpath(p)
                                    break
                                except Exception as e:
                                    print('Pre not found')
                                    continue

                        except Exception as e:
                            # We log error into db
                            print(e, 'Relaunch page...')
                            log = ScrapperLogs(scrapper_id=1, type='error', text='Cannot click on the element', date=datetime.now(timezone.utc))
                            log.save()                    
                        filename = 'defensive_actions_' + teams_names[j] + '_' + match_season + '.csv'

                        if not os.path.exists("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/defensive_actions/{1}".format(league,filename)):
                            f = open("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/defensive_actions/{1}".format(league,filename), "w")
                            f.write(csv_to_insert.text)
                            f.close()
                        else: 
                            print('File already exists')

                        print('Save defensive actions')


                        ############################################################################################################
                        #
                        # POSSESSION
                        #
                        ############################################################################################################
                        
                        time.sleep(7)

                        driver.execute_script("window.scrollTo(6300, 7000);")

                        time.sleep(5)

                        menu_link_selector = '//*[@id="stats_possession_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                        csv_link_selector = '//*[@id="stats_possession_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])


                        menu_links = [
                            menu_link_selector,
                            '/html/body/div[3]/div[6]/div[17]/div[1]/div/ul/li[1]/span',
                            '/html/body/div[3]/div[6]/div[15]/div[1]/div/ul/li[1]/span'
                        ]

                        self.hoverDropdownMenu(driver, menu_links)

                        csv_links = [
                            csv_link_selector,
                            '/html/body/div[3]/div[6]/div[17]/div[1]/div/ul/li[1]/div/ul/li[4]/button',
                            '/html/body/div[3]/div[6]/div[15]/div[1]/div/ul/li[1]/div/ul/li[4]/button'
                        ]


                        try:
                            get_csv = self.retrieveCsvDropdown(driver, csv_links)
                        except StaleElementReferenceException as e:
                            print(bcolors.FAIL + 'StaleElementReferenceException: relaunch hovering element and retrieveCsvDropdown()...')
                            self.hoverDropdownMenu(driver, menu_links)
                            get_csv = self.retrieveCsvDropdown(driver, csv_links)

                        try:
                            click_link = ActionChains(driver).move_to_element(get_csv)
                            click_link.click().perform()

                            pre = [
                                '/html/body/div[3]/div[6]/div[17]/div[2]/div/pre',
                                '/html/body/div[3]/div[6]/div[15]/div[2]/div/pre'
                            ]
                            
                            for p in pre: 
                                try:
                                    csv_to_insert = driver.find_element_by_xpath(p)
                                    break
                                except Exception as e:
                                    print('Pre not found')
                                    continue

                        except Exception as e:
                            # We log error into db
                            print(e, 'Relaunch page...')
                            log = ScrapperLogs(scrapper_id=1, type='error', text='Cannot click on the element', date=datetime.now(timezone.utc))
                            log.save()                    
                        filename = 'possession_' + teams_names[j] + '_' + match_season + '.csv'

                        if not os.path.exists("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/possession/{1}".format(league,filename)):
                            f = open("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/possession/{1}".format(league,filename), "w")
                            f.write(csv_to_insert.text)
                            f.close()
                        else: 
                            print('File already exists')

                        print('Save possession')

                        driver.execute_script("window.scrollTo(7000, 7700);")

                        time.sleep(5)
                    else:
                        driver.execute_script("window.scrollTo(2900, 3400);")
                        time.sleep(5)


                    ############################################################################################################
                    #
                    # PLAYING TIME
                    #
                    ############################################################################################################

                    menu_link_selector = '//*[@id="stats_playing_time_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_playing_time_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])


                    menu_links = [
                        menu_link_selector,
                        '/html/body/div[3]/div[6]/div[18]/div[1]/div/ul/li[1]/span',
                        '/html/body/div[3]/div[6]/div[16]/div[1]/div/ul/li[1]/span'
                    ]

                    self.hoverDropdownMenu(driver, menu_links)

                    csv_links = [
                        csv_link_selector,
                        '/html/body/div[3]/div[6]/div[18]/div[1]/div/ul/li[1]/div/ul/li[4]/button',
                        '/html/body/div[3]/div[6]/div[16]/div[1]/div/ul/li[1]/div/ul/li[4]/button'
                        
                    ]

                    try:
                        get_csv = self.retrieveCsvDropdown(driver, csv_links)
                    except StaleElementReferenceException as e:
                        print(bcolors.FAIL + 'StaleElementReferenceException: relaunch hovering element and retrieveCsvDropdown()...')
                        self.hoverDropdownMenu(driver, menu_links)
                        get_csv = self.retrieveCsvDropdown(driver, csv_links)

                    try:
                        click_link = ActionChains(driver).move_to_element(get_csv)
                        click_link.click().perform()

                        pre = [
                            '/html/body/div[3]/div[6]/div[18]/div[2]/div/pre',
                            '/html/body/div[3]/div[6]/div[16]/div[2]/div/pre'
                        ]
                        
                        for p in pre: 
                            try:
                                csv_to_insert = driver.find_element_by_xpath(p)
                                break
                            except Exception as e:
                                print('Pre not found')
                                continue
                    except Exception as e:
                        # We log error into db
                        print(e, 'Relaunch page...')
                        # driver.close()    
                        # driver.quit()
                        # os.environ['PATH'] += os.pathsep + '/usr/src/app/web/staticfiles/run_script/management/commands'
                        # process = subprocess.Popen(["python", 'manage.py', 'fbref_get_players_csv'])
                        # log = ScrapperLogs(scrapper_id=1, type='error', text='Cannot click on the element', date=datetime.now(timezone.utc))
                        # log.save()                    
                        # 
                    filename = 'playing_time_' + teams_names[j] + '_' + match_season + '.csv'

                    if not os.path.exists("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/playing_time/{1}".format(league,filename)):
                        f = open("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/playing_time/{1}".format(league,filename), "w")
                        f.write(csv_to_insert.text)
                        f.close()
                    else: 
                        print('File already exists')

                    print('Save playing time')

                    ############################################################################################################
                    #
                    # VARIOUS STATISTICS
                    #
                    ############################################################################################################
                    
                    if int(match_season) > 2016:
                        time.sleep(5)
                        driver.execute_script("window.scrollTo(7700, 8400);")
                    else:
                        driver.execute_script("window.scrollTo(3400, 4200);")

                    menu_link_selector = '//*[@id="stats_misc_{}_sh"]/div/ul/li[1]/span'.format(leagueIds[league])
                    csv_link_selector = '//*[@id="stats_misc_{}_sh"]/div/ul/li[1]/div/ul/li[4]/button'.format(leagueIds[league])


                    menu_links = [
                        menu_link_selector,
                        '/html/body/div[3]/div[6]/div[19]/div[1]/div/ul/li[1]/span',
                        '/html/body/div[3]/div[6]/div[17]/div[1]/div/ul/li[1]/span'
                        
                    ]

                    self.hoverDropdownMenu(driver, menu_links)

                    csv_links = [
                        csv_link_selector,
                        '/html/body/div[3]/div[6]/div[19]/div[1]/div/ul/li[1]/div/ul/li[4]/button',
                        '/html/body/div[3]/div[6]/div[17]/div[1]/div/ul/li[1]/div/ul/li[4]/button'
                    ]

                    try:
                        get_csv = self.retrieveCsvDropdown(driver, csv_links)
                    except StaleElementReferenceException as e:
                        print(bcolors.FAIL + 'StaleElementReferenceException: relaunch hovering element and retrieveCsvDropdown()...')
                        self.hoverDropdownMenu(driver, menu_links)
                        get_csv = self.retrieveCsvDropdown(driver, csv_links)

                    try:
                        click_link = ActionChains(driver).move_to_element(get_csv)
                        click_link.click().perform()

                        pre = [
                            '/html/body/div[3]/div[6]/div[19]/div[2]/div/pre',
                            '/html/body/div[3]/div[6]/div[17]/div[2]/div/pre'
                        ]
                        
                        for p in pre: 
                            try:
                                csv_to_insert = driver.find_element_by_xpath(p)
                                break
                            except Exception as e:
                                print('Pre not found')
                                continue

                    except Exception as e:
                        # We log error into db
                        print(e, 'Relaunch page...')
                        # driver.close()
                        # driver.quit()
                        # os.environ['PATH'] += os.pathsep + '/usr/src/app/web/staticfiles/run_script/management/commands'
                        # process = subprocess.Popen(["python", 'manage.py', 'fbref_get_players_csv'])
                        # log = ScrapperLogs(scrapper_id=1, type='error', text='Cannot click on the element', date=datetime.now(timezone.utc))
                        # log.save()

                    filename = 'various_statistics_' + teams_names[j] + '_' + match_season + '.csv'

                    if not os.path.exists("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/genstats/{1}".format(league,filename)):
                        f = open("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/genstats/{1}".format(league,filename), "w")
                        f.write(csv_to_insert.text)
                        f.close()
                    else: 
                        print('File already exists')

                    print('Save various statistics')


                    exclude = Exclude_Team_Links(scrapper_id=1, link=teams_links[j])
                    exclude.save()

                Scrapper_Active_Links.objects.filter(link=active_links[i].link).delete()
        except Exception as e:
            print('Error:', e)
            driver.close()
            driver.quit()
            os.environ['PATH'] += os.pathsep + '/usr/src/app/web/staticfiles/run_script/management/commands'
            process = subprocess.Popen(["python", 'manage.py', 'fbref_get_players_csv'])


    def retrieveStatsBasics(self, driver, filename, league):
        ############################################################################################################
        #
        # STATS BASIQUES
        #
        ############################################################################################################
        
        time.sleep(5)
        
        driver.switch_to.default_content()
        driver.execute_script("window.scrollTo(0, 500);")

        time.sleep(2)

        menu_links = [
            '/html/body/div[3]/div[6]/div[3]/div[1]/div/ul/li[1]/span',
            '/html/body/div[2]/div[6]/div[3]/div[1]/div/ul/li[1]/span',
            '/html/body/div[3]/div[6]/div[2]/div[1]/div/ul/li[1]/span'
        ]

        self.hoverDropdownMenu(driver, menu_links)
        
        csv_links = [
            "/html/body/div[3]/div[6]/div[3]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
            "/html/body/div[3]/div[6]/div[2]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
            "/html/body/div[3]/div[6]/div[4]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
            "/html/body/div[2]/div[6]/div[4]/div[1]/div/ul/li[2]/div/ul/li[4]/button",
            "/html/body/div[2]/div[6]/div[4]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
            "/html/body/div[2]/div[6]/div[3]/div[1]/div/ul/li[2]/div/ul/li[4]/button",
            "/html/body/div[2]/div[6]/div[3]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
            "/html/body/div[3]/div[6]/div[4]/div[1]/div/ul/li[2]/div/ul/li[4]/button",
            "/html/body/div[3]/div[6]/div[3]/div[1]/div/ul/li[2]/div/ul/li[4]/button"
        ]

        try:
            get_csv = self.retrieveCsvDropdown(driver, csv_links)
        except StaleElementReferenceException as e:
            print(bcolors.FAIL + 'StaleElementReferenceException: relaunch hovering element and retrieveCsvDropdown()...')
            self.hoverDropdownMenu(driver, csv_links)
            get_csv = self.retrieveCsvDropdown(driver, csv_links)

        try:
            click_link = ActionChains(driver).move_to_element(get_csv)
            click_link.click().perform()
            csv_to_insert = driver.find_element_by_xpath('//pre')
        except Exception as e:
            # We log error into db
            log = ScrapperLogs(scrapper_id=1, type='error', text='Cannot click on the element', date=datetime.now(timezone.utc))
            log.save()

        if not os.path.exists("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/genstats/{1}".format(league,filename)):
            print(filename)
            f = open("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/genstats/{1}".format(league ,filename), "w")
            f.write(csv_to_insert.text)
            f.close()
        else: 
            print('File already exists')

        print('Save genstats')



    def hoverDropdownMenu(self, driver, menu_links):
        export_menu = None

        for link in menu_links:
            try:
                driver.switch_to.default_content()
                export_menu = driver.find_element_by_xpath(link)
                time.sleep(5)
                if export_menu != None:
                    print(bcolors.OKGREEN + link + ' is on the page.')
                    break
            except NoSuchElementException:
                print(bcolors.FAIL + "Oups element is not on the page... Try another one.")

        if export_menu != None:
            try:
                driver.switch_to.default_content()
                hover_export = ActionChains(driver).move_to_element(export_menu)
                hover_export.perform()
                print(bcolors.OKGREEN, 'hover is performed. Success?')
            except StaleElementReferenceException:
                print(bcolors.FAIL + "Oups an error has occured")


    def retrieveCsvDropdown(self, driver, csv_links):
        wait = WebDriverWait(driver, 8)

        for link in csv_links:
            try:
                get_csv = wait.until(EC.element_to_be_clickable((By.XPATH, link)))
                if get_csv != None:
                    print(bcolors.OKGREEN + link + ' is on the page.')
                    return get_csv
            except TimeoutException:
                print(bcolors.FAIL + link + " is not on the page. Try another one." + bcolors.ENDC)
        
        raise StaleElementReferenceException('No link for csv on page.')