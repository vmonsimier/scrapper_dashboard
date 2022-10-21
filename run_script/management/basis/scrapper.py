import csv
import os
from selenium import webdriver

scrapper_directories = {
    '1': 'players_data',
    '2': 'fixtures_data'
}

class Colors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

class Scrapper:
    def webdriverFromNode(self, node_id):
        options = webdriver.ChromeOptions()
        options.add_argument('--no-sandbox')
        options.add_argument('--disable-dev-shm-usage')        
        print('Launching Chrome webdriver remote...')
        return webdriver.Remote(command_executor="http://127.0.0.1:4444/wd/hub", options=options)

    
    def saveCsvFile(self, scrapper_id, csvToInsert, league, filename):
        bcolors = Colors()
        directory = scrapper_directories[str(scrapper_id)]

        if int(scrapper_id) == 2:
            sub = filename.split('_')[0]
            subdirectory = "/{}".format(sub)
        else:
            subdirectory = ''

        path = "/home/valentinm/Documents/football/datafiles/{0}/{1}{2}/{3}".format(directory, league, subdirectory, filename)
        data = csvToInsert.get_attribute('innerText')
        
        if not os.path.exists(path):
            f = open(path, "w")
            f.write(data)
            f.close()
        else: 
            print('File already exists')

        print(bcolors.OKGREEN + 'Save {} '.format(filename) + bcolors.ENDC)
        return -1
    
    def checkFileExists(self, scrapper_id, league, filename):
        directory = scrapper_directories[str(scrapper_id)]
        
        if int(scrapper_id) == 2:
            sub = filename.split('_')[0]
            subdirectory = "/{}".format(sub)
        else:
            subdirectory = ''

        path = "/home/valentinm/Documents/football/datafiles/{0}/{1}/{2}/{3}".format(directory, league, subdirectory, filename)

        if os.path.exists(path):
            return True
        else:
            return False