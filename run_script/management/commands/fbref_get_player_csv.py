from selenium import webdriver
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.firefox.firefox_binary import FirefoxBinary
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.common.exceptions import NoSuchElementException, TimeoutException, StaleElementReferenceException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.options import Options
# from selenium.webdriver.chrome.options import Options
from datetime import datetime, timezone
import subprocess
import requests
import lxml
import psycopg2
import socket
import re
import os
import asyncio
import json
import sys
import time

from django.core.management.base import BaseCommand, CommandError
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
    def kill_process(self):
        scrapper = Scrappers.objects.get(id=2)
        print('Trying to kill ' + scrapper.path + '/ process ' + str(scrapper.current_pid))
        try:
            subprocess.run(["pkill", "-f", str(scrapper.path)])
            subprocess.run(["pkill", "-f", 'Firefox'])
            subprocess.run(["pkill", "-f", 'firefox'])
        except Exception as err:
            print(err)

    def handle(self, *args, **options):
        # options = Options()
        # options.binary_location = r'/usr/bin/firefox'
        # options.add_argument("--headless")
            
        # driver = webdriver.Firefox(options=options, executable_path="geckodriver")

        # driver.set_page_load_timeout(5)

        # We retrieve active links for scrapper in django model Scrapper_Active_Links
        active_links = Scrapper_Active_Links.objects.filter(scrapper_id=2)
        active_links = list(map(lambda x: x.link, active_links))

        for i in range(0, len(active_links)):
            print(bcolors.WARNING + active_links[i] + bcolors.ENDC)
            print('link', active_links[i])
            driver.get(active_links[i])
            # driver.maximize_window()

            time.sleep(5)

            season_links = [
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
                match_season = re.search(r"[0-9]{4}", season.text).group(0)
            except Exception as e:
                #We log error into db
                log = ScrapperLogs(scrapper_id=2, type='error', text=e, date=datetime.now(timezone.utc))
                log.save()
                self.kill_process()

            driver.execute_script("window.scrollTo(0, 550);")

            time.sleep(5)

            tname_links = [
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
                log = ScrapperLogs(scrapper_id=2, type='error', text='Cannot find teams', date=datetime.now(timezone.utc))
                log.save()
                self.kill_process()

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
                    self.kill_process()

                fixtures_players = []

                for fixture_link in fixtures_links:
                    fixtures_players.append(fixture_link.get_attribute('href'))

                for link in fixtures_links:
                    print(link.get_attribute('href'))

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
                        self.kill_process()

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
                                break
                        except NoSuchElementException:
                            print(bcolors.FAIL + "Oups element is not on the page... Try another one." + bcolors.ENDC)

                    time.sleep(5)

                    try:
                        hover_export = ActionChains(driver).move_to_element(export_menu)
                        hover_export.perform()
                    except StaleElementReferenceException as e:
                        print(bcolors.FAIL + "Oups an error has occured when hovering the menu" + bcolors.ENDC)
                        # We log error into db
                        log = ScrapperLogs(scrapper_id=2, type='error', text=e, date=datetime.now(timezone.utc))
                        log.save()
                        self.kill_process()


                    wait = WebDriverWait(driver, 8)

                    csv_links = [
                        "/html/body/div[2]/div[6]/div[4]/div[1]/div/ul/li[2]/div/ul/li[4]/button",
                        "/html/body/div[2]/div[6]/div[4]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
                        "/html/body/div[2]/div[6]/div[3]/div[1]/div/ul/li[2]/div/ul/li[4]/button",
                        "/html/body/div[2]/div[6]/div[3]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
                        "/html/body/div[3]/div[6]/div[3]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
                        "/html/body/div[3]/div[6]/div[4]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
                        "/html/body/div[3]/div[6]/div[4]/div[1]/div/ul/li[2]/div/ul/li[4]/button",
                        "/html/body/div[3]/div[6]/div[3]/div[1]/div/ul/li[2]/div/ul/li[4]/button"
                    ]

                    for link in csv_links:
                        try:
                            get_csv = wait.until(EC.element_to_be_clickable((By.XPATH, link)))
                            if get_csv != None:
                                break
                        except TimeoutException:
                            print(bcolors.FAIL + "Oups element is not on the page... Try another one." + bcolors.ENDC)

                    try:
                        click_link = ActionChains(driver).move_to_element(get_csv)
                        click_link.click().perform()
                        csv_to_insert = driver.find_element_by_xpath('//pre')
                    except Exception as e:
                        # We log error into db
                        log = ScrapperLogs(scrapper_id=2, type='error', text=e, date=datetime.now(timezone.utc))
                        log.save()
                        self.kill_process()

                    try:
                        filename = teams_names[j] + '_' + player_name.text + '_' + match_season + '.csv'
                        f = open("/home/valentinm/Documents/FootballData/datafiles/player_data/{}".format(filename), "w")
                        f.write(csv_to_insert.text)
                        f.close()
                    except Exception as e:
                        # We log error into db
                        log = ScrapperLogs(scrapper_id=2, type='error', text=e, date=datetime.now(timezone.utc))
                        log.save()
                        self.kill_process()

                    print(bcolors.OKGREEN + 'File {} saved!'.format(filename) + bcolors.ENDC)

                    # We log state "Done player [playerName]"
                    logText = 'Done player ' + player_name.text + ' | team ' + teams_names[j] + ' | ' + match_season
                    log = ScrapperLogs(scrapper_id=2, type='info', text=logText, date=datetime.now(timezone.utc))
                    log.save()

                    # We add exclude player links to database for next execution
                    new_exclude_player = Exclude_Player_Links(scrapper_id=2, link=fixture_player)
                    new_exclude_player.save()

            driver.close()
