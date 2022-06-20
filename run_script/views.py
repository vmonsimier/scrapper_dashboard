from django.shortcuts import render
from django.contrib.auth import authenticate
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.csrf import csrf_protect
from django.contrib.auth.decorators import login_required
import os
import signal
import subprocess
import json
import psutil
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
            scrapper = Scrappers.objects.get(path=body['body']['path'])
            if scrapper.enable == True:
                print('Trying to execute ' + scrapper.path)
                os.environ['PATH'] += os.pathsep + '/usr/src/app/web/staticfiles/run_script/management/commands'
                process = subprocess.Popen(["python", 'manage.py', scrapper.path])
                scrapper.current_pid = str(process.pid)
                scrapper.in_execution = True
                scrapper.save()

            return HttpResponse(status=200)
        except Scrappers.DoesNotExist:
            print('Error')
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
                subprocess.run(["pkill", "-f", str(scrapper.path)])
                subprocess.run(["pkill", "-f", 'Firefox'])
                subprocess.run(["pkill", "-f", 'firefox'])
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

# @csrf_exempt
# def insert_files_db(request):
#     """
#     insert files in db
#     """
#     if request.method == "GET":
#         try:
#             files = os.listdir('/Volumes/TOSHIBA EXT/Football_Dashboard/football_dashboard/files/players_csv/')
#             for el in files:
#                 team = el.split('_')[0]
#                 player = el.split('_')[1]
#                 season = int(el.split('_')[2].split('.')[0])
#                 new_file = Files(path=el, player=player, team=team, league='league', season=season, dateIns=datetime.now(timezone.utc))
#                 new_file.save()
#         except Exception as err:
#             print(err)
#     return HttpResponse(status=200)
