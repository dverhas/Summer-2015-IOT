# A very simple Bottle Hello World app for you to get started with...
import requests
import get_weather 
import time
from datetime import datetime, timedelta
import json
import stream

download_format = '%Y-%m-%d %H:%M:%S.%f'
spark_date_format = '%Y-%m-%dT%H:%M:%S.%fZ'



def projectmap():

    stream.save_extract_date()
    r = requests.get('https://data.sparkfun.com/output/aGOE6rY5mxcxX1GNnOKq.json')
    target = open('full_class.json','w')
    target.write(r.text)


projectmap()
