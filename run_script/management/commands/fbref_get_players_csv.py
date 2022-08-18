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
            "/html/body/div[3]/div[6]/div[2]/div[1]/div/ul/li[1]/div/ul/li[4]/button",
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
        
        raise StaleElementReferenceException('No link for csv on page.')

    def handle(self, *args, **options):
        
        options = webdriver.ChromeOptions()
        options.add_argument('--no-sandbox')
        options.add_argument('--disable-dev-shm-usage')      
        print('Launching webdriver remote...')
        driver = webdriver.Remote(command_executor="http://127.0.1.1:4444/wd/hub",desired_capabilities=DesiredCapabilities.CHROME, options=options)
        
        try:
            print('connection established.')
            # We retrieve active links for scrapper in django model Scrapper_Active_Links
            active_links = Scrapper_Active_Links.objects.filter(scrapper_id=1)
            active_links = list(map(lambda x: x.link, active_links))
            print(bcolors.OKBLUE, active_links)
            for i in range(0, len(active_links)):

                driver.get(active_links[i])
                driver.maximize_window()

                time.sleep(5)

                if i == 0:
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
                driver.execute_script("window.scrollTo(0, 550);")

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

                exclude_teams = Exclude_Team_Links.objects.filter(scrapper_id=2)
                exclude_teams = list(map(lambda x: x.link, exclude_teams))
                
                for team in teams:
                    if team.get_attribute('href') not in exclude_teams:
                        print(team.get_attribute('href'))
                        teams_links.append(team.get_attribute('href'))
                        teams_names.append(team.text)


                for j in range(0, len(teams_links)):

                    driver.get(teams_links[j])
                    
                    time.sleep(10)

                    driver.switch_to.default_content()

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
                                print(bcolors.OKGREEN + link + ' is on the page.')
                                break
                        except NoSuchElementException:
                            print(bcolors.FAIL + "Oups element is not on the page... Try another one.")


                    time.sleep(5)

                    try:
                        hover_export = ActionChains(driver).move_to_element(export_menu)
                        hover_export.perform()
                        print(bcolors.OKGREEN, 'hover is performed. Success?')
                    except StaleElementReferenceException:
                        print(bcolors.FAIL + "Oups an error has occured")
                        return

                    try:
                        get_csv = self.retrieveCsv(driver)
                    except StaleElementReferenceException as e:
                        print(bcolors.FAIL + 'StaleElementReferenceException: relaunch hovering element and retrieveCsv()...')
                        hover_export = ActionChains(driver).move_to_element(export_menu)
                        hover_export.perform()
                        get_csv = self.retrieveCsv(driver)

                    try:
                        click_link = ActionChains(driver).move_to_element(get_csv)
                        click_link.click().perform()
                        csv_to_insert = driver.find_element_by_xpath('//pre')
                    except Exception as e:
                        # We log error into db
                        print(e)
                        log = ScrapperLogs(scrapper_id=1, type='error', text='Cannot click on the element', date=datetime.now(timezone.utc))
                        log.save()

                    filename = teams_names[j] + '_' + match_season + '.csv'

                    print(filename)

                    f = open("/home/valentinm/Documents/FootballData/datafiles/players_data/{}".format(filename), "w")
                    f.write(csv_to_insert.text)
                    f.close()
                    exclude = Exclude_Team_Links(scrapper_id=1, link=teams_links[j])
                    exclude.save()
            remove_active_link = Scrapper_Active_Links.objects.filter(link=active_links[i])
            remove_active_link.delete()
        except Exception as e:
            print('Error:', e)
            log = ScrapperLogs(scrapper_id=1, type='error', text=e, date=datetime.now(timezone.utc))
            log.save()
            driver.quit()
            driver.close()