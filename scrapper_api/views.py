from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser
from run_script.models import *
from rest_framework import serializers

################################################################################
# Scrappers
################################################################################

@csrf_exempt
def scrappers_list(request):
    """
    List all code scrappers, or create a new scrapper.
    """
    if request.method == 'GET':
        scrappers = Scrappers.objects.all()
        serializer = serializers.ModelSerializer(scrappers, many=True)
        return JsonResponse(serializer.data, safe=False)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = ScrappersSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

@csrf_exempt
def scrapper_detail(request, pk):
    """
    Retrieve, update or delete a code snippet.
    """
    try:
        scrapper = Scrappers.objects.get(pk=pk)
    except Scrappers.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'GET':
        serializer = ScrappersSerializer(scrapper)
        return JsonResponse(serializer.data)

    elif request.method == 'PUT':
        data = JSONParser().parse(request)
        serializer = ScrappersSerializer(scrapper, data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data)
        return JsonResponse(serializer.errors, status=400)

    elif request.method == 'DELETE':
        scrapper.delete()

################################################################################
# Fbref links
################################################################################

@csrf_exempt
def fbref_links_list(request):
    """
    List all fbref links to scrap
    """
    if request.method == 'GET':
        fbref_links = FbrefLinks.objects.all()
        serializer = serializers.ModelSerializer(fbref_links, many=True)
        return JsonResponse(serializer.data, safe=False)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = FbrefLinksSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

@csrf_exempt
def fbref_link_detail(request, pk):
    """
    Retrieve, update or delete a code snippet.
    """
    try:
        fbref_link = FbrefLinks.objects.get(pk=pk)
    except FbrefLinks.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'GET':
        serializer = FbrefLinksSerializer(fbref_link)
        return JsonResponse(serializer.data)

    elif request.method == 'PUT':
        data = JSONParser().parse(request)
        serializer = FbrefLinksSerializer(fbref_link, data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data)
        return JsonResponse(serializer.errors, status=400)

    elif request.method == 'DELETE':
        fbref_link.delete()

################################################################################
# Scrappers active links
################################################################################

@csrf_exempt
def scrapper_active_links(request):
    """
    List all scrapper active links
    """
    if request.method == 'GET':
        active_links = Scrapper_Active_Links.objects.all()
        serializer = serializers.ModelSerializer(active_links, many=True)
        return JsonResponse(serializer.data, safe=False)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = ScrappersActiveLinksSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

@csrf_exempt
def scrapper_active_link_detail(request, pk):
    """
    Retrieve, update or delete a code snippet.
    """
    try:
        active_link = Scrapper_Active_Links.objects.get(pk=pk)
    except Scrapper_Active_Links.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'GET':
        serializer = ScrappersActiveLinksSerializer(active_link)
        return JsonResponse(serializer.data)

    elif request.method == 'PUT':
        data = JSONParser().parse(request)
        serializer = ScrappersActiveLinksSerializer(active_link, data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data)
        return JsonResponse(serializer.errors, status=400)

    elif request.method == 'DELETE':
        active_link.delete()

################################################################################
# Exclude Team links
################################################################################

@csrf_exempt
def exclude_team_links(request):
    """
    List all scrapper exclude team links.
    """
    if request.method == 'GET':
        exclude_links = Exclude_Team_Links.objects.all()
        serializer = serializers.ModelSerializer(exclude_links, many=True)
        return JsonResponse(serializer.data, safe=False)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = ExcludeTeamLinksSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

@csrf_exempt
def exclude_team_link_detail(request, pk):
    """
    Retrieve, update or delete a code snippet.
    """
    try:
        exclude_team_link = Exclude_Team_Links.objects.get(pk=pk)
    except Exclude_Team_Links.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'GET':
        serializer = ExcludeTeamLinksSerializer(exclude_team_link)
        return JsonResponse(serializer.data)

    elif request.method == 'PUT':
        data = JSONParser().parse(request)
        serializer = ExcludeTeamLinksSerializer(exclude_team_link, data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data)
        return JsonResponse(serializer.errors, status=400)

    elif request.method == 'DELETE':
        exclude_team_link.delete()

################################################################################
# Exclude Player links
################################################################################

@csrf_exempt
def exclude_player_links(request):
    """
    List all scrapper exclude player links
    """
    if request.method == 'GET':
        exclude_links = Exclude_Player_Links.objects.all()
        serializer = serializers.ModelSerializer(exclude_links, many=True)
        return JsonResponse(serializer.data, safe=False)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = ExcludePlayerLinksSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

@csrf_exempt
def exclude_player_link_detail(request, pk):
    """
    Retrieve, update or delete a code snippet.
    """
    try:
        exclude_player_link = Exclude_Player_Links.objects.get(pk=pk)
    except Exclude_Player_Links.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'GET':
        serializer = ExcludePlayerLinksSerializer(exclude_player_link)
        return JsonResponse(serializer.data)

    elif request.method == 'PUT':
        data = JSONParser().parse(request)
        serializer = ExcludePlayerLinksSerializer(exclude_player_link, data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data)
        return JsonResponse(serializer.errors, status=400)

    elif request.method == 'DELETE':
        exclude_player_link.delete()

################################################################################
# Tests
################################################################################

@csrf_exempt
def tests_list(request):
    """
    List all code tests, or create a new test.
    """
    if request.method == 'GET':
        tests = Tests.objects.all()
        serializer = serializers.ModelSerializer(tests, many=True)
        return JsonResponse(serializer.data, safe=False)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = TestsSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

@csrf_exempt
def test_detail(request, pk):
    """
    Retrieve, update or delete a code snippet.
    """
    try:
        test = Tests.objects.get(pk=pk)
    except Tests.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'GET':
        serializer = TestsSerializer(test)
        return JsonResponse(serializer.data)

    elif request.method == 'PUT':
        data = JSONParser().parse(request)
        serializer = TestsSerializer(test, data=data)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data)
        return JsonResponse(serializer.errors, status=400)

    elif request.method == 'DELETE':
        test.delete()
