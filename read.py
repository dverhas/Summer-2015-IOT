# A very simple Bottle Hello World app for you to get started with...
import requests
import get_weather 
import time
from datetime import datetime, timedelta
import json

date_format = '%Y-%m-%d %I:%M %p'
spark_date_format = '%Y-%m-%dT%H:%M:%S.%fZ'



def projectmap():
    target = open('full_class.json','r')
    content = target.read();
    r = requests.get('https://data.sparkfun.com/output/wpbq2p0N1rig8WJZRWpO.json?page=1')
    content = json.loads(content)
    content.append(r.json())
    print content[0]


projectmap()
