import time
import requests
import json
import re
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import NoSuchElementException, StaleElementReferenceException, TimeoutException

from run_script.models import *

from .scrapper import Colors, Scrapper

bcolors = Colors()

class ScrapperLogic:
    def checkElementExists(self, driver, xpath):
        try:
            driver.find_element_by_xpath(xpath)
        except NoSuchElementException:
            return False
        return True

    def retrieveStats(self, driver, scrapper_id, league, filename, selectors, print_scrapper):
        try:       
            time.sleep(2)
            
            element = driver.find_element_by_xpath(selectors['menu_link'])
            scrollTo = str(int(element.location['y']) - 200)

            driver.execute_script("window.scrollTo(0, {});".format(scrollTo))

            time.sleep(2)

            self.hoverDropdownMenu(driver, selectors['menu_link'])

            try:
                get_csv = self.retrieveCsvDropdown(driver, selectors['csv_link'])
            except StaleElementReferenceException as e:
                reg = re.search("\d", print_scrapper)
                node = reg.group()
                url_stop = 'http://localhost:3000/stop_scrapper'
                url_start = 'http://localhost:3000/execute_scrapper'
                body = json.dumps({'body': {'path': 'fbref_get_players_fixtures_csv', 'relaunch': node}})
                
                r = requests.post(url=url_stop, data=body)
                r = requests.post(url=url_start, data=body)

            try:
                click_link = ActionChains(driver).move_to_element(get_csv)
                click_link.click().perform()
                csv_to_insert = driver.find_element_by_xpath(selectors['pre_link'])
            except Exception as e:
                print(print_scrapper, 'Can\'t click link.')

            scrapper = Scrapper()
            scrapper.saveCsvFile(scrapper_id, csv_to_insert, league, filename)

        except Exception as e:
            return False

        return True

    def clickButton(self, driver, xpath, print_scrapper):
        button = driver.find_element_by_xpath(xpath)

        if button.value_of_css_property('color') == 'rgba(0, 0, 0, 1)':
            print(print_scrapper, 'Button is inactive for this season/player')
            return False

        try:
            click = ActionChains(driver).move_to_element(button)
            click.click().perform()
        except Exception as e:
            print(print_scrapper, bcolors.FAIL + 'Cannot click on the element...')
            return False
        
        return True

    def hoverDropdownMenu(self, driver, menu_link, print_scrapper):
        export_menu = None
        try:
            export_menu = driver.find_element_by_xpath(menu_link)
            time.sleep(2)
        except NoSuchElementException:
            print(print_scrapper, bcolors.FAIL + "Oups element of dropdown menu is not on the page...")

        if export_menu != None:
            try:
                hover_export = ActionChains(driver).move_to_element(export_menu)
                hover_export.perform()
            except StaleElementReferenceException:
                print(print_scrapper, bcolors.FAIL + "Oups an error has occured while performing hover...")


    def retrieveCsvDropdown(self, driver, csv_link, print_scrapper):
        wait = WebDriverWait(driver, 8)

        try:
            get_csv = wait.until(EC.element_to_be_clickable((By.XPATH, csv_link)))
            if get_csv != None:
                return get_csv
        except TimeoutException:
            print(print_scrapper, bcolors.FAIL + csv_link + " is not on the page..." + bcolors.ENDC)
            raise Error(csv_link + " is not on the page...")
        
        raise StaleElementReferenceException('No link for csv on page...')
    
    def clickCookiesAccept(self, driver, print_scrapper):
        try:
            cookiesAcceptance = '//*[@id="qc-cmp2-ui"]/div[2]/div/button[3]'
            btnAccept = driver.find_element_by_xpath(cookiesAcceptance)
            click_btn = ActionChains(driver).move_to_element(btnAccept)
            click_btn.click().perform()
        except NoSuchElementException:
            print(print_scrapper, 'Ok fbref nos asking for cookies')

    def removeAdsiFrame(self, driver, print_scrapper):
        all_iframes = driver.find_elements_by_tag_name("iframe")
        if len(all_iframes) > 0:
            driver.execute_script("""
                let a = document.getElementsByClassName('adblock');
                for(const l of a) {
                    l.style.height = 0;
                }
                """)
            print(print_scrapper, bcolors.WARNING + 'Total Ads removed: ' + str(len(all_iframes)) + bcolors.ENDC)
        else:
            print(print_scrapper, 'No ads found')
        return -1

    def removeFooterWrapper(self, driver, print_scrapper):
        try:
            time.sleep(3)
            driver.execute_script("""
                let a = document.getElementById('fs-sticky-footer');
                a.style.visibility = 'hidden';
            """)
        except Exception as e:
            print(print_scrapper, 'Error removing wrapper')
        
        return -1