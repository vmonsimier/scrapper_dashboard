from rest_framework import viewsets

from django.contrib.auth.models import User
from run_script.models import *

from ..serializers.serializers import *

# ViewSets define the view behavior.
class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class ScrappersViewSet(viewsets.ModelViewSet):
    queryset = Scrappers.objects.all()
    serializer_class = ScrappersSerializer

class FbrefLinksViewSet(viewsets.ModelViewSet):
    queryset = FbrefLinks.objects.all()
    serializer_class = FbrefLinksSerializer

class ScrappersActiveLinksViewSet(viewsets.ModelViewSet):
    queryset = Scrapper_Active_Links.objects.all()
    serializer_class = ScrappersActiveLinksSerializer

class ExludeTeamLinksViewSet(viewsets.ModelViewSet):
    queryset = Exclude_Team_Links.objects.all()
    serializer_class = ExcludeTeamLinksSerializer

class ExcludePlayerLinksViewSet(viewsets.ModelViewSet):
    queryset = Exclude_Player_Links.objects.all()
    serializer_class = ExcludePlayerLinksSerializer

class TestsViewSet(viewsets.ModelViewSet):
    queryset = Tests.objects.all()
    serializer_class = TestsSerializer
    
