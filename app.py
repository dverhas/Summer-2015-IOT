
# A very simple Bottle Hello World app for you to get started with...
from bottle import default_app, route, template
import requests
import get_weather 
import time
from datetime import datetime, timedelta
import json
import stream

date_format = '%Y-%m-%d %I:%M %p'
spark_date_format = '%Y-%m-%dT%H:%M:%S.%fZ'

devices  = {}
max_date = {} # the most recent data from the device
elapsed  = {} # the number of minutes since the last device read

def to_date(string):
    return datetime.strptime(string,date_format)

def eastern_date():
  return datetime.now() + timedelta(hours=-4)


def calculate_elapsed(string):
    return -( to_date(string) -  eastern_date())

@route('/')
def hello_world():
    my_names = ["Dave", "John", "Sally", "Liz", "Aaron"]
    return template("sample", names=my_names)

@route('/chart')
def chart():
    r = requests.get('https://data.sparkfun.com/output/wpbq2p0N1rig8WJZRWpO.json')
    data = r.json()
    return template("chart", data=data)



@route('/project')
def projectmap():
    data = stream.data()
    
    date_rate_offset= datetime.now() + timedelta(hours=-5)

    for record in data:
        user = record['user']

        if user[:4] == 'test': 
              continue

        new_time = datetime.strptime(record['timestamp'],spark_date_format) + timedelta(hours=-4)

        if not devices.has_key(user):
            devices[user] = {'rate':0, 'total_records':0, 'last_hour':0, 'lon':0, 'lat':0}


        #rolling hour record rate
        if new_time > date_rate_offset:
              devices[user]['rate'] = devices[user]['rate'] + 1

        #total number of data records
        devices[user]['total_records'] = devices[user]['total_records'] + 1

        # get most recent process date
        if not max_date.has_key(user):
            max_date[user] = new_time.strftime(date_format)
            devices[user]['lon'] = record['longitude']
            devices[user]['lat'] = record['latitude']

        if datetime.strptime(max_date[user], date_format) < new_time :
            max_date[user] = new_time.strftime(date_format)
            devices[user]['lon'] = record['longitude']
            devices[user]['lat'] = record['latitude']

    #get the elapsed minues since the max_date
    for device in max_date.iterkeys():
        elapsed[device] = calculate_elapsed(max_date[device])

    return template("project", max_date=max_date, elapsed=elapsed, devices=devices)

@route('/map')
def map():
    r = requests.get('http://api.openweathermap.org/data/2.5/find?lat=41.2398&lon=-81.4408&cnt=25')
    data = r.json()
    return template("map", data=data)

@route('/lab5')
def lab5():
    r = requests.get('https://data.sparkfun.com/output/G2qzL2WqraSR7opxjGNL.json')
    data = r.json()
    return template("lab5", data=data)

@route('/lab6')
def lab6():
    list = get_weather.get_weather_list()
    states = []
    reds = []
    greens = []
    blues = []
    for item in list:
        states.append(item)
        reds.append(list[item]['humidity']*2)
        greens.append(0)
        blues.append(int(list[item]['temp']-273)*5)
    return template("lab6", states = states, reds = reds, greens = greens, blues = blues)



application = default_app()

