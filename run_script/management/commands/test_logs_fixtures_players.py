from django.core.management.base import BaseCommand
from ..basis.scrapper import Colors
from ..basis.tests import Tests

bcolors = Colors()
tests = Tests()

class Command(BaseCommand):
    def add_arguments(self, parser):
        parser.add_argument(
            '--file',
            default=False,
            help="Contains the file name to test"
        )
    def handle(self, *args, **options):
        # Erase content output file
        tests.eraseContentOutput()

        filename = options['file']
        f = open('/home/valentinm/Documents/football/scrapper_dashboard/run_script/management/logs/{0}'.format(filename), 'r')
        
        players_list = []
        players_tests = []
        teams_done = []
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

            if 'Done' in x:
                team_name = x.strip().split('team ')[1].split(' | ')[0]
                if team_name not in teams_done:
                    teams_done.append(team_name)


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


        message = 'Total number players: ' + str(len(players_list))
        tests.appendOutputFile(message)
        print(bcolors.WARNING + message)
        
        
        fails = self.getResultTest(players_tests, False)

        players_list = [*set(players_list)]
        total_links = len(players_list)
        total_test = len(players_tests)
        
        message = 'Links found: ' + str(total_links)
        tests.appendOutputFile(message)
        print(message)

        message = 'Test executed: ' + str(total_test) + '\n'
        tests.appendOutputFile(message)
        print(message)

        message = 'Failed tests: {}\n'.format(str(len(fails)))
        tests.appendOutputFile(message)
        print(message)

        self.getResultTest(fails, True)

        if total_links != total_test:
            message = '\nMissing links:' + str(int(total_links) - int(total_test))
            tests.appendOutputFile(message)
            print(message)

            test_links = [t['link'] for t in players_tests]

            for link in players_list:
                if link not in test_links:
                    message = 'Missing test for ' + link
                    tests.appendOutputFile(message)
                    print(bcolors.FAIL + message) 
        
        message = '\nTeams done: ' + str(len(teams_done)) + '\n'
        tests.appendOutputFile(message)
        print(bcolors.OKGREEN + message)
        for team in teams_done:
            message = team + ' - OK'
            tests.appendOutputFile(message)
            print(bcolors.OKGREEN + message + bcolors.ENDC)

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
                    message = test['link']
                    tests.appendOutputFile(message)
                    print(bcolors.WARNING + message)
                else:
                    if test[key] == True  and bool(logger) == True:
                        message = key + ' - OK'
                        tests.appendOutputFile(message)
                        print(bcolors.OKGREEN + message)
                    elif test[key] == False:
                        if key != 'keeper':
                            if test not in fails:
                                fails.append(test)
                        if bool(logger) == True:
                            message = key  + ' - FAIL'
                            tests.appendOutputFile(message)
                            print(bcolors.FAIL + key)
        return fails

