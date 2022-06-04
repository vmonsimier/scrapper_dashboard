from selenium import webdriver
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.firefox.firefox_binary import FirefoxBinary
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.common.exceptions import NoSuchElementException, TimeoutException, StaleElementReferenceException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from datetime import datetime, timezone
import subprocess
import requests
import lxml
import psycopg2
import socket
import re
import os
import asyncio
import json
import sys
import time

from django.core.management.base import BaseCommand, CommandError
from run_script.models import *

class Command(BaseCommand):
    def handle(self, *args, **options):
        try:
            chrome_options = webdriver.ChromeOptions()
            chrome_options.set_capability('browserless:token', '125ec3cd-626f-47ea-acfb-fa16e071bc3a')
            chrome_options.add_argument("--no-sandbox")
            chrome_options.add_argument("--headless")

            driver = webdriver.Remote(
                command_executor="https://chrome.browserless.io/webdriver",
                desired_capabilities=chrome_options.to_capabilities(),
            )

            driver.get('https://www.lequipe.fr/')
            print(driver.page_source)
            driver.quit()

            driver.close()
        except Exception as e:
            print('Error: ' + str(e))
