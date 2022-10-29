from rest_framework import serializers

from django.contrib.auth.models import User
from run_script.models import *

# Serializers define the API representation.
class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['url', 'username', 'email', 'is_staff']

class ScrappersSerializer(serializers.ModelSerializer):
    class Meta:
        model = Scrappers
        fields = ['id', 'name', 'site', 'path', 'in_execution', 'enable', 'current_pid', 'errors', 'last_execution']

class FbrefLinksSerializer(serializers.ModelSerializer):
    class Meta:
        model = FbrefLinks
        fields = ['id', 'link', 'league', 'season']

class ScrappersActiveLinksSerializer(serializers.ModelSerializer):
    class Meta:
        model = Scrapper_Active_Links
        fields = ['id', 'scrapper_id', 'link', 'league', 'season']

class ExcludeTeamLinksSerializer(serializers.ModelSerializer):
    class Meta:
        model = Exclude_Team_Links
        fields = ['id', 'scrapper_id', 'link']

class ExcludePlayerLinksSerializer(serializers.ModelSerializer):
    class Meta:
        model = Exclude_Team_Links
        fields = ['id', 'scrapper_id', 'link']

class TestsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tests
        fields = ['id', 'name', 'path', 'file', 'last_execution']
