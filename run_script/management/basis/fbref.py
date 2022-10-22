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
scrapper = Scrapper()

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

            self.hoverDropdownMenu(driver, selectors['menu_link'], print_scrapper)

            try:
                get_csv = self.retrieveCsvDropdown(driver, selectors['csv_link'], print_scrapper)
            except StaleElementReferenceException as e:
                self.relaunchScrapper(driver, print_scrapper)

            try:
                click_link = ActionChains(driver).move_to_element(get_csv)
                click_link.click().perform()
                csv_to_insert = driver.find_element_by_xpath(selectors['pre_link'])
            except Exception as e:
                message = 'Can\'t click link.'
                print(print_scrapper, message)
                node = scrapper.getNode(print_scrapper)
                scrapper.logger(str(message), node)

            scrapper = Scrapper()
            scrapper.saveCsvFile(scrapper_id, csv_to_insert, league, filename, print_scrapper)

        except Exception as e:
            return False

        return True

    def clickButton(self, driver, xpath, print_scrapper):
        button = driver.find_element_by_xpath(xpath)

        if button.value_of_css_property('color') == 'rgba(0, 0, 0, 1)':
            message = 'Button is inactive for this season/player'
            print(print_scrapper, message)
            node = scrapper.getNode(print_scrapper)
            scrapper.logger(str(message), node)
            return False

        try:
            click = ActionChains(driver).move_to_element(button)
            click.click().perform()
        except Exception as e:
            message = 'Cannot click on the element...'
            print(print_scrapper, bcolors.FAIL + message)
            node = scrapper.getNode(print_scrapper)
            scrapper.logger(str(message), node)
            return False
        
        return True

    def hoverDropdownMenu(self, driver, menu_link, print_scrapper):
        export_menu = None
        try:
            export_menu = driver.find_element_by_xpath(menu_link)
            time.sleep(2)
        except NoSuchElementException:
            message = "Oups element of dropdown menu is not on the page..."
            print(print_scrapper, bcolors.FAIL + message)
            node = scrapper.getNode(print_scrapper)
            scrapper.logger(str(message), node)

        if export_menu != None:
            try:
                hover_export = ActionChains(driver).move_to_element(export_menu)
                hover_export.perform()
            except StaleElementReferenceException:
                message = "Oups an error has occured while performing hover..."
                print(print_scrapper, bcolors.FAIL + message)
                node = scrapper.getNode(print_scrapper)
                scrapper.logger(str(message), node)


    def retrieveCsvDropdown(self, driver, csv_link, print_scrapper):
        wait = WebDriverWait(driver, 8)

        try:
            get_csv = wait.until(EC.element_to_be_clickable((By.XPATH, csv_link)))
            if get_csv != None:
                return get_csv
        except Exception:
            message = csv_link + " is not on the page..."
            print(print_scrapper, bcolors.FAIL + message + bcolors.ENDC)
            node = scrapper.getNode(print_scrapper)
            scrapper.logger(str(message), node)
            raise Error(csv_link + " is not oin the page...")
        
        raise StaleElementReferenceException('No link for csv on page...')
    
    def clickCookiesAccept(self, driver, print_scrapper):
        try:
            cookiesAcceptance = '//*[@id="qc-cmp2-ui"]/div[2]/div/button[3]'
            btnAccept = driver.find_element_by_xpath(cookiesAcceptance)
            click_btn = ActionChains(driver).move_to_element(btnAccept)
            click_btn.click().perform()
        except NoSuchElementException:
            message = 'Ok fbref nos asking for cookies'
            print(print_scrapper, message)
            node = scrapper.getNode(print_scrapper)
            scrapper.logger(str(message), node)

    def removeAdsiFrame(self, driver, print_scrapper):
        all_iframes = driver.find_elements_by_tag_name("iframe")
        if len(all_iframes) > 0:
            driver.execute_script("""
                let a = document.getElementsByClassName('adblock');
                for(const l of a) {
                    l.style.height = 0;
                }
                """)
            message = 'Total Ads removed: ' + str(len(all_iframes))
            print(print_scrapper, bcolors.WARNING + message + bcolors.ENDC)
            node = scrapper.getNode(print_scrapper)
            scrapper.logger(str(message), node)
        else:
            message = 'No ads found'
            print(print_scrapper, message)
            node = scrapper.getNode(print_scrapper)
            scrapper.logger(str(message), node)
        return -1

    def removeFooterWrapper(self, driver, print_scrapper):
        try:
            time.sleep(3)
            driver.execute_script("""
                let a = document.getElementById('fs-sticky-footer');
                a.style.visibility = 'hidden';
            """)
        except Exception as e:
            message = 'Error removing wrapper'
            print(print_scrapper, message)
            node = scrapper.getNode(print_scrapper)
            scrapper.logger(str(message), node)

        
        return -1

    def relaunchScrapper(self, driver, print_scrapper):
        try:
            node = scrapper.getNode(print_scrapper)
            url_start = 'http://localhost:3000/execute_scrapper'
            body = json.dumps({'body': {'path': 'fbref_get_players_fixtures_csv', 'relaunch': node}})
            r = requests.post(url=url_start, data=body)
        except Exception as e:
            message1 = 'Cannot relaunch. Quit...'
            message2 = 'Error relauch ' + e
            print(print_scrapper, message1)
            print(print_scrapper, message2)
            node = scrapper.getNode(print_scrapper)
            scrapper.logger(str(message1), node)
            scrapper.logger(str(message2), node)