from selenium import webdriver
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.firefox.firefox_binary import FirefoxBinary
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.common.exceptions import NoSuchElementException, TimeoutException, StaleElementReferenceException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.options import Options
import requests
import lxml
import psycopg2
import re
import asyncio
import json
import sys
import time

from django.core.management.base import BaseCommand, CommandError
from run_script.models import *

class Command(BaseCommand):
    def handle(self, *args, **options):
        options = webdriver.ChromeOptions()
        options.add_argument('--headless')

        driver = webdriver.Remote(command_executor='http://10.0.0.44:4444/wd/hub',desired_capabilities=DesiredCapabilities.CHROME, options=options)

        # We retrieve active links for scrapper in django model Scrapper_Active_Links
        active_links = Scrapper_Active_Links.objects.filter(scrapper_id=1)
        active_links = list(map(lambda x: x.link, active_links))

        for i in range(0, len(active_links)):

            driver.get(active_links[i])
            driver.maximize_window()

            time.sleep(5)

            if i == 0:
                driver.find_element_by_xpath('/html/body/div[1]/div/div/div/div[2]/div/button[3]').click()
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
                    print('Cannot find title. Try another xpath..')

            match_season = re.search(r"[0-9]{4}", season.text).group(0)

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
                except NoSuchElementException:
                    print('Cannot find teams. Try another xpath...')

                if len(teams) != 0:
                    break

            teams_links = []
            teams_names = []

            for team in teams:
                print(team.get_attribute('href'))
                teams_links.append(team.get_attribute('href'))
                teams_names.append(team.text)

            for j in range(0, len(teams_links)):

                driver.get(teams_links[j])

                driver.maximize_window()

                time.sleep(5)

                driver.execute_script("window.scrollTo(0, 500);")

                time.sleep(10)

                menu_links = [
                    '/html/body/div[2]/div[6]/div[3]/div[1]/div/ul/li[1]/span',
                    '/html/body/div[3]/div[6]/div[2]/div[1]/div/ul/li[1]/span',
                    '/html/body/div[3]/div[6]/div[3]/div[1]/div/ul/li[1]/span'
                ]

                for link in menu_links:
                    try:
                        export_menu = driver.find_element_by_xpath(link)
                        time.sleep(5)
                        if export_menu != None:
                            break
                    except NoSuchElementException:
                        print("Oups element is not on the page... Try another one.")


                time.sleep(5)

                try:
                    hover_export = ActionChains(driver).move_to_element(export_menu)
                    hover_export.perform()
                except StaleElementReferenceException:
                    print("Oups an error has occured")
                    return

                wait = WebDriverWait(driver, 8)

                csv_links = [
                    "/html/body/div[2]/div[6]/div[3]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
                    "/html/body/div[3]/div[6]/div[2]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
                    "/html/body/div[3]/div[6]/div[3]/div[1]/div/ul/li[1]/div/ul/li[4]/button"
                ]

                for link in csv_links:
                    try:
                        get_csv = wait.until(EC.element_to_be_clickable((By.XPATH, link)))
                        if get_csv != None:
                            break
                    except TimeoutException:
                        print("Oups element is not on the page... Try another one.")

                click_link = ActionChains(driver).move_to_element(get_csv)
                click_link.click().perform()

                csv_to_insert = driver.find_element_by_xpath('//pre')

                print('Youpi !')

                filename = teams_names[j] + '_' + match_season + '.csv'

                print(filename)

                f = open("/home/valentinm/Documents/FootballData/datafiles/player_data/{}".format(filename), "w")
                f.write(csv_to_insert.text)
                f.close()

        driver.close()
