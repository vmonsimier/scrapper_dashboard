from django.core.management.base import BaseCommand
from ..basis.scrapper import Colors

bcolors = Colors()

class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            '--file',
            default=False,
            help="Contains the file name to test"
        )
    def handle(self, *args, **options):
        filename = options['file']
        f = open('/home/valentinm/Documents/football/football_dashboard/run_script/management/commands/logs/{0}'.format(filename), 'r')
        
        players_list = []
        players_tests = []
        current_test = {'first': True, 'link': ''}

        for x in f:
            #number total players links
            if 'Go to' not in x and 'https://fbref.com/fr/joueurs/' in x:
                if x.strip() not in players_list:
                    players_list.append(x.strip())
            if 'Go to ' in x:
                l = x.strip().split('Go to ')[1]
                if current_test['link'] != l:
                    if 'first' not in current_test:
                        players_tests.append(current_test)
                
                    current_test = self.resetCurrentTest()
                    current_test['link'] = l

            elif 'Save' in x:
                if 'genstats' in x:
                    current_test['genstats'] = True
                
                if 'passes' in x:
                    current_test['passes'] = True

                if 'passes-type' in x:
                    current_test['passes-type'] = True
                
                if 'penalty-prep' in x:
                    current_test['penalty-prep'] = True
                
                if 'defensive-actions' in x:
                    current_test['defensive-actions'] = True

                if 'possession' in x:
                    current_test['possession'] = True 
                
                if 'various-stats' in x:
                    current_test['various-stats'] = True

                if 'keeper' in x:
                    current_test['keeper'] = True

        print(bcolors.WARNING + 'Total number players:', len(players_list))
        
        
        fails = self.getResultTest(players_tests, False)

        players_list = [*set(players_list)]
        total_links = len(players_list)
        total_test = len(players_tests)
        


        print('Links found:', total_links)
        print('Test executed:', total_test, '\n')
        print('Failed tests above:\n')
        self.getResultTest(fails, True)

        if total_links != total_test:
            print('\nMissing links:', int(total_links) - int(total_test))
            test_links = [t['link'] for t in players_tests]

            for link in players_list:
                if link not in test_links:
                    print(bcolors.FAIL + 'Missing test for', link) 

    def resetCurrentTest(self):
        return {
            'link': '',
            'genstats': False,
            'passes': False,
            'passes-type': False,
            'penalty-prep': False,
            'defensive-actions': False,
            'possession': False,
            'various-stats': False,
            'keeper': False
        }

    def getResultTest(self, result, logger=False):
        fails = []
        for test in result:
            keys = test.keys()
            for key in keys:
                if key == 'link' and bool(logger) == True:
                    print(bcolors.WARNING + test['link'])
                else:
                    if test[key] == True  and bool(logger) == True:
                        print(bcolors.OKGREEN + key)
                    elif test[key] == False:
                        if key != 'keeper':
                            if test not in fails:
                                fails.append(test)
                        if bool(logger) == True:
                            print(bcolors.FAIL + key)
        return fails

