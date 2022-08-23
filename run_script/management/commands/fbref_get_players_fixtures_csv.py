from selenium import webdriver
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.common.exceptions import NoSuchElementException, TimeoutException, StaleElementReferenceException
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

class Command(BaseCommand):
    def retrieveCsv(self, driver):
        wait = WebDriverWait(driver, 8)

        csv_links = [
            "/html/body/div[3]/div[6]/div[4]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
            "/html/body/div[2]/div[6]/div[4]/div[1]/div/ul/li[2]/div/ul/li[4]/button",
            "/html/body/div[2]/div[6]/div[4]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
            "/html/body/div[2]/div[6]/div[3]/div[1]/div/ul/li[2]/div/ul/li[4]/button",
            "/html/body/div[2]/div[6]/div[3]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
            "/html/body/div[3]/div[6]/div[3]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
            "/html/body/div[3]/div[6]/div[4]/div[1]/div/ul/li[2]/div/ul/li[4]/button",
            "/html/body/div[3]/div[6]/div[3]/div[1]/div/ul/li[2]/div/ul/li[4]/button"
        ]

        for link in csv_links:
            try:
                get_csv = wait.until(EC.element_to_be_clickable((By.XPATH, link)))
                if get_csv != None:
                    print(bcolors.OKGREEN + link + ' is on the page.')
                    return get_csv
            except TimeoutException:
                print(bcolors.FAIL + link + " is not on the page. Try another one." + bcolors.ENDC)


    def handle(self, *args, **options):
        try:
            options = webdriver.ChromeOptions()
            options.add_argument('--no-sandbox')
            options.add_argument('--disable-dev-shm-usage')        
            print('Launching webdriver remote...')
            driver = webdriver.Remote(command_executor="http://127.0.1.1:4444/wd/hub",desired_capabilities=DesiredCapabilities.CHROME, options=options)
        
            print('connection established.')

            # We retrieve active links for scrapper in django model Scrapper_Active_Links
            active_links = Scrapper_Active_Links.objects.filter(scrapper_id=2)
            active_links = list(map(lambda x: x.link, active_links))
            print(bcolors.OKBLUE, active_links)
            
            for i in range(0, len(active_links)):
                print(bcolors.WARNING + active_links[i] + bcolors.ENDC)
                print('link', active_links[i])
                driver.get(active_links[i])
                driver.maximize_window()

                time.sleep(5)

                try:
                    cookiesAcceptance = '/html/body/div[1]/div/div/div/div[2]/div/button[3]'
                    btnAccept = driver.find_element_by_xpath(cookiesAcceptance)
                    click_btn = ActionChains(driver).move_to_element(btnAccept)
                    click_btn.click().perform()
                except NoSuchElementException:
                    print('Ok fbref nos asking for cookies')

                driver.execute_script("window.scrollTo(0, 0);")

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
                        print(bcolors.FAIL + 'Cannot find title. Try another xpath..' + bcolors.ENDC)
                        time.sleep(10)

                try:
                    print(season.text)
                    match_season = re.search(r"[0-9]{4}", season.text).group(0)
                except Exception as e:
                    print(e)
                    #We log error into db
                    log = ScrapperLogs(scrapper_id=2, type='error', text=e, date=datetime.now(timezone.utc))
                    log.save()
                    # driver.quit()

                driver.execute_script("window.scrollTo(0, 550);")

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
                    print(link)
                    try:
                        teams = driver.find_elements_by_xpath(link)
                        print('teams element', teams)
                        if len(teams) != 0:
                            break
                    except NoSuchElementException:
                        print(bcolors.FAIL + 'Cannot find teams. Try another xpath...' + bcolors.ENDC)

                if len(teams) == 0:
                    # We log error into db
                    print('teams', teams)
                    log = ScrapperLogs(scrapper_id=2, type='error', text='Cannot find teams', date=datetime.now(timezone.utc))
                    log.save()
                    

                teams_links = []
                teams_names = []

                # We retrieve team links already scrapped
                exclude_teams = Exclude_Team_Links.objects.filter(scrapper_id=2)
                exclude_teams = list(map(lambda x: x.link, exclude_teams))

                for team in teams:
                    if team.get_attribute('href') not in exclude_teams:
                        print(team.get_attribute('href'))
                        teams_links.append(team.get_attribute('href'))
                        teams_names.append(team.text)

                for j in range(0, len(teams_links)):

                    driver.get(teams_links[j])

                    print(teams_names[j] + ' - ' + match_season)

                    time.sleep(5)

                    driver.execute_script("window.scrollTo(0, 600);")

                    time.sleep(10)

                    flinks = [
                        '/html/body/div[2]/div[6]/div[3]/div[2]/table/tbody/tr/td[20]/a',
                        '//*[@id="stats_standard_603"]/tbody/tr/td[20]/a',
                        '//*[@id="stats_standard_11183"]/tbody/tr/td[29]/a',
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
                        # We log error into db
                        log = ScrapperLogs(scrapper_id=2, type='error', text='Cannot find fixture links of players', date=datetime.now(timezone.utc))
                        log.save()
                        driver.quit()
                        

                    fixtures_players = []

                    for fixture_link in fixtures_links:
                        fixtures_players.append(fixture_link.get_attribute('href'))
                        print(fixture_link.get_attribute('href'))

                    print(bcolors.WARNING + 'Number of players : ' + str(len(fixtures_players)) + bcolors.ENDC)

                    for fixture_player in fixtures_players:
                        print(bcolors.WARNING + 'go to player : ', fixture_player + bcolors.ENDC)

                        # We retrieve team links already scrapped
                        exclude_players = Exclude_Player_Links.objects.filter(scrapper_id=2)
                        exclude_players = list(map(lambda x: x.link, exclude_players))

                        if fixture_player in exclude_players:
                            continue

                        driver.get(fixture_player)

                        pname_links = [
                            "/html/body/div[2]/div[3]/div[1]/div[2]/h1/span[1]",
                            "/html/body/div[3]/div[3]/div[1]/div[2]/h1/span[1]",
                            "/html/body/div[2]/div[3]/div[1]/div/h1/span[1]",
                            "/html/body/div[3]/div[3]/div[1]/div/h1/span[1]"
                        ]

                        for link in pname_links:
                            try:
                                player_name = driver.find_element_by_xpath(link)
                                if player_name != None:
                                    break
                            except NoSuchElementException:
                                print(bcolors.FAIL + "Cannot find player name. Try another one..." + bcolors.ENDC)

                        if player_name == None:
                            # We log error into db
                            log = ScrapperLogs(scrapper_id=2, type='error', text='Cannot find player name', date=datetime.now(timezone.utc))
                            log.save()
                            

                        time.sleep(5)

                        driver.execute_script("window.scrollTo(0, 200);")

                        menu_links = [
                            '/html/body/div[2]/div[6]/div[4]/div[1]/div/ul/li[1]/span',
                            '/html/body/div[3]/div[6]/div[3]/div[1]/div/ul/li[1]/span',
                            '/html/body/div[2]/div[6]/div[3]/div[1]/div/ul/li[1]/span',
                            '/html/body/div[2]/div[6]/div[3]/div[1]/div/ul/li[2]/span',
                            '/html/body/div[2]/div[6]/div[4]/div[1]/div/ul/li[2]/span',
                            '/html/body/div[3]/div[6]/div[4]/div[1]/div/ul/li[1]/span',
                            '/html/body/div[3]/div[6]/div[3]/div[1]/div/ul/li[2]/span',
                            '/html/body/div[3]/div[6]/div[4]/div[1]/div/ul/li[2]/span'
                        ]

                        for link in menu_links:
                            try:
                                export_menu = driver.find_element_by_xpath(link)
                                time.sleep(5)
                                if export_menu != None:
                                    print(bcolors.OKGREEN + link + ' is on the page.')
                                    break
                            except NoSuchElementException:
                                print(bcolors.FAIL + "Oups element is not on the page... Try another one." + bcolors.ENDC)

                        time.sleep(5)

                        try:
                            hover_export = ActionChains(driver).move_to_element(export_menu)
                            hover_export.perform()
                            print(bcolors.OKGREEN, 'hover is performed. Success?')
                        except StaleElementReferenceException as e:
                            print(bcolors.FAIL + "Oups an error has occured when hovering the menu" + bcolors.ENDC)
                            # We log error into db
                            log = ScrapperLogs(scrapper_id=2, type='error', text=e, date=datetime.now(timezone.utc))
                            log.save()
                          
                        try:
                            get_csv = self.retrieveCsv(driver)
                        except StaleElementReferenceException as e:
                            print('StaleElementReferenceException: relaunch hovering element and retrieveCsv()...')
                            hover_export = ActionChains(driver).move_to_element(export_menu)
                            hover_export.perform()
                            get_csv = self.retrieveCsv(driver)

                        try:
                            click_link = ActionChains(driver).move_to_element(get_csv)
                            click_link.click().perform()
                            csv_to_insert = driver.find_element_by_xpath('//pre')
                        except Exception as e:
                            # We log error into db
                            log = ScrapperLogs(scrapper_id=2, type='error', text=e, date=datetime.now(timezone.utc))
                            log.save()
                            

                        try:
                            filename = teams_names[j] + '_' + player_name.text + '_' + match_season + '.csv'
                            print(bcolors.OKGREEN, filename)
                            f = open("/home/valentinm/Documents/FootballData/datafiles/fixtures_data/{}".format(filename), "w")
                            f.write(csv_to_insert.text)
                            f.close()
                        except Exception as e:
                            log = ScrapperLogs(scrapper_id=2, type='error', text=e, date=datetime.now(timezone.utc))
                            log.save()
                            

                        print(bcolors.OKGREEN + 'File {} saved!'.format(filename) + bcolors.ENDC)

                        # We log state "Done player [playerName]"
                        logText = 'Done player ' + player_name.text + ' | team ' + teams_names[j] + ' | ' + match_season
                        log = ScrapperLogs(scrapper_id=2, type='info', text=logText, date=datetime.now(timezone.utc))
                        log.save()

                        # We add exclude player links to database for next execution
                        new_exclude_player = Exclude_Player_Links(scrapper_id=2, link=fixture_player)
                        new_exclude_player.save()
                Scrapper_Active_Links.objects.filter(link=active_links[i]).delete()
        except Exception as e:
            driver.quit()
            driver.close()
            os.environ['PATH'] += os.pathsep + '/usr/src/app/web/staticfiles/run_script/management/commands'
            process = subprocess.Popen(["python", 'manage.py', 'fbref_get_players_csv'])
