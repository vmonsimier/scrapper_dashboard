import time
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import NoSuchElementException, StaleElementReferenceException

class Logic:
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
    