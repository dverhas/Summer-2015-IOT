import requests
import json
from datetime import datetime

download_format = '%Y-%m-%d %H:%M:%S.%f'

def last_extract_date():
    target = open('/home/davidverhas/web/date.txt','r')
    date = target.read()
    target.close()
    return date

def save_extract_date():
    date = datetime.now();
    target = open('date.txt','w')
    target.write(date.strftime(download_format))
    target.close()


def data():
   last_extract = last_extract_date() 
   save_extract_date()
   r = requests.get('https://data.sparkfun.com/output/aGOE6rY5mxcxX1GNnOKq.json?gt[timestamp]='+last_extract)
   new_data = r.json()
   target = open('/home/davidverhas/web/full_class.json','r')
   old_data = json.load(target)
   target.close()
   old_data = old_data + new_data
   target = open('/home/davidverhas/web/full_class.json','w')
   target.write(json.dumps(old_data))
   return old_data
