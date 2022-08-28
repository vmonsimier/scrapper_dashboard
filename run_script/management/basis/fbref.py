import time
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import NoSuchElementException, StaleElementReferenceException

from run_script.models import *

from .scrapper import *

class ScrapperLogic:
    def checkElementExists(self, driver, xpath):
        try:
            driver.find_element_by_xpath(xpath)
        except NoSuchElementException:
            return False
        return True

    def retrieveStats(self, driver, filename, selectors):
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
                print(bcolors.FAIL + 'StaleElementReferenceException: relaunch hovering element and retrieveCsvDropdown()...')
                self.hoverDropdownMenu(driver, csv_links)
                get_csv = self.retrieveCsvDropdown(driver, selectors['csv_link'])

            try:
                click_link = ActionChains(driver).move_to_element(get_csv)
                click_link.click().perform()
                csv_to_insert = driver.find_element_by_xpath(selectors['pre_link'])
            except Exception as e:
                log.save()

            #Scrapper.saveCsvFile()

        except Exception as e:
            return False

        return True

    def clickButton(self, driver, xpath):
        button = driver.find_element_by_xpath(xpath)

        if button.value_of_css_property('color') == 'rgba(0, 0, 0, 1)':
            print('Button is inactive for this season/player')
            return False

        try:
            click = ActionChains(driver).move_to_element(button)
            click.click().perform()
        except Exception as e:
            print(bcolors.FAIL + 'Cannot click on the element...')
            return False
        
        return True

    def hoverDropdownMenu(self, driver, menu_link):
        export_menu = None
        try:
            export_menu = driver.find_element_by_xpath(menu_link)
            time.sleep(2)
        except NoSuchElementException:
            print(bcolors.FAIL + "Oups element of dropdown menu is not on the page...")

        if export_menu != None:
            try:
                hover_export = ActionChains(driver).move_to_element(export_menu)
                hover_export.perform()
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
    
    def clickCookiesAccept(self, driver):
        try:
            cookiesAcceptance = '/html/body/div[1]/div/div/div/div[2]/div/button[3]'
            btnAccept = driver.find_element_by_xpath(cookiesAcceptance)
            click_btn = ActionChains(driver).move_to_element(btnAccept)
            click_btn.click().perform()
        except NoSuchElementException:
            print('Ok fbref nos asking for cookies')

    def removeAdsiFrame(self, driver):
        all_iframes = driver.find_elements_by_tag_name("iframe")
        if len(all_iframes) > 0:
            driver.execute_script("""
                let a = document.getElementsByClassName('adblock');
                for(const l of a) {
                    l.style.height = 0;
                }
                """)
            print('Total Ads removed: ' + str(len(all_iframes)))
        else:
            print('No ads found')
        return -1