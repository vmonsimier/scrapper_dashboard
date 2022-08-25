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

class Scrapper:
    
    def saveCsvFile(self, filename):    
        if not os.path.exists("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/genstats/{1}".format(league,filename)):
            print(filename)
            f = open("/home/valentinm/Documents/FootballData/datafiles/players_data/{0}/genstats/{1}".format(league ,filename), "w")
            f.write(csv_to_insert.text)
            f.close()
        else: 
            print('File already exists')

        print('Save {}'.format(filename))
        return -1