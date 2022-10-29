from django.shortcuts import render
from django.contrib.auth import authenticate
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.csrf import csrf_protect
from django.contrib.auth.decorators import login_required
import os
import subprocess
import json
from datetime import datetime, timezone

from .models import *

@login_required
def index(request):
    scrappers = Scrappers.objects.all()

    data = {
        'scrappers': scrappers
    }

    return render(request, 'run_script/index.html', data)


@csrf_exempt
def execute_scrapper(request):
    """
    Execute a scrapper according to its path
    """
    if request.method == "POST":
        try:
            body = json.loads(request.body)
            if 'nodes' in body['body']:
                nodes = int(body['body']['node'])
            else:
                nodes = 3
            
            scrapper = Scrappers.objects.get(path=body['body']['path'])
            if scrapper.enable == True:
                os.environ['PATH'] += os.pathsep + '/usr/src/app/web/staticfiles/run_script/management/commands'
                if 'relaunch' in body['body']:
                    relaunch = int(body['body']['relaunch'])
                    process = subprocess.Popen(['python3', 'manage.py', scrapper.path, '--relaunch', str(relaunch)])
                else:
                    for i in range(0, nodes):
                        node= i+1
                        print('Trying to execute', scrapper.path, 'with node', node)
                        process = subprocess.Popen(['python3', 'manage.py', scrapper.path, '--node', str(node)])
                        scrapper.current_pid = str(process.pid)
                        scrapper.in_execution = True
                        scrapper.save()
            return HttpResponse(status=200)
        except Scrappers.DoesNotExist as e:
            print('Error', e)
            return HttpResponse(status=404)

    return HttpResponse(status=404)

@csrf_exempt
def stop_scrapper(request):
    """
    Stop a scrapper according to its path
    """
    if request.method == "POST":
        try:
            body = json.loads(request.body)
            scrapper = Scrappers.objects.get(path=body['body']['path'])

            print('Trying to kill ' + scrapper.path + '/ process ' + str(scrapper.current_pid))
            try:
                subprocess.run(["killall", "chrome"])
                subprocess.run(["killall", "chromedriver"])
                scrapper.current_pid = 0
                scrapper.in_execution = False
                scrapper.last_execution = datetime.now(timezone.utc)
                scrapper.save()
            except Exception as err:
                print(err)
            return HttpResponse(status=200)

        except Scrappers.DoesNotExist:
            return HttpResponse(status=404)

    return HttpResponse(status=404)

@csrf_exempt
def update_scrapper(request):
    """
    Update a scrapper according to its id
    """
    if request.method == "POST":
        try:
            body = json.loads(request.body)
            scrapper = Scrappers.objects.get(id=body['id'])
            try:
                # We update scrapper information
                scrapper.name = body['name']
                scrapper.path = body['path']
                scrapper.enable = body['enable']
                scrapper.save()

                # We delete scrapper active links
                active_links = Scrapper_Active_Links.objects.filter(scrapper_id=body['id'])
                active_links.delete()

                # We add active scrapper active links
                for league in body['selectedLeagues']:
                    for season in body['selectedSeasons']:
                        link = FbrefLinks.objects.get(league=league, season=season)
                        new_active = Scrapper_Active_Links(scrapper_id=body['id'], link=link.link, league=league, season=season)
                        new_active.save()

            except Exception as err:
                print(err)
            return HttpResponse(status=200)

        except Scrappers.DoesNotExist:
            return HttpResponse(status=404)

    return HttpResponse(status=404)

@csrf_exempt
def execute_test(request):
    """
    Execute a test according to its path
    """
    if request.method == "POST":
        try:
            body = json.loads(request.body)
            test = Tests.objects.get(path=body['body']['path'])
            os.environ['PATH'] += os.pathsep + '/usr/src/app/web/staticfiles/run_script/management/commands'

            print('Trying to execute', test.path)
            process = subprocess.Popen(['python3', 'manage.py', test.path, '--file', test.file])
            return HttpResponse(status=200)

        except Tests.DoesNotExist as e:
            print('Error', e)
            return HttpResponse(status=404)

    return HttpResponse(status=404)

@csrf_exempt
def update_test(request):
    """
    Update a test according to its id
    """
    if request.method == "POST":
        try:
            body = json.loads(request.body)
            test = Tests.objects.get(id=body['id'])
            try:
                # We update test information
                test.name = body['name']
                test.path = body['path']
                test.file = body['file']
                test.save()

            except Exception as err:
                print(err)
            return HttpResponse(status=200)

        except Tests.DoesNotExist:
            return HttpResponse(status=404)

    return HttpResponse(status=404)