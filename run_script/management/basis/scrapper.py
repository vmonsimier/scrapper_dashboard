import csv
import os

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
    
    def saveCsvFile(self, csvToInsert, league, filename):
        bcolors = Colors()
        path = "/home/valentinm/Documents/football/datafiles/fixtures_data/{0}/{1}".format(league,filename)
        data = csvToInsert.get_attribute('innerText')
        
        if not os.path.exists(path):
            f = open("/home/valentinm/Documents/football/datafiles/fixtures_data/{0}/{1}".format(league ,filename), "w")
            f.write(data)
            f.close()
        else: 
            print('File already exists')

        print(bcolors.OKGREEN + 'Save {} '.format(filename) + bcolors.ENDC)
        return -1