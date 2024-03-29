"""scrapper_dashboard URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import include, path
from rest_framework import routers

from .view_sets.view_sets import *

from run_script import views as script_views

# Routers provide an easy way of automatically determining the URL conf.
router = routers.DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'scrappers', ScrappersViewSet)
router.register(r'tests', TestsViewSet)
router.register(r'test_files', TestFilesViewSet)
router.register(r'fbref_links', FbrefLinksViewSet)
router.register(r'scrapper_active_links', ScrappersActiveLinksViewSet)
router.register(r'exclude_team_links', ExludeTeamLinksViewSet)
router.register(r'exclude_player_links', ExcludePlayerLinksViewSet)

urlpatterns = [
    path('', script_views.index),
    path('execute_scrapper', script_views.execute_scrapper),
    path('stop_scrapper', script_views.stop_scrapper),
    path('update_scrapper', script_views.update_scrapper),
    path('execute_test', script_views.execute_test),
    path('output_test', script_views.output_test),
    path('update_test', script_views.update_test),
    path('api/', include(router.urls)),
    path('api/auth/', include('rest_framework.urls')),
    path('admin/', admin.site.urls),
    path("accounts/", include("django.contrib.auth.urls"))
]
