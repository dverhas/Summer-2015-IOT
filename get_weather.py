import requests 

def get_state_zips():
    zips = {}
    for item in open("/home/davidverhas/web/capitals.dat","r").read().strip().split("\n"):
        x = item.split(",");
        zips[x[0]] = x[2]
    return zips

def get_state_weather(state, zips):
    req = requests.get("http://api.openweathermap.org/data/2.5/weather?zip="+zips[state]+",US")
    return req.json()

def get_weather_list():
    zips = get_state_zips()
    weather_list = {}
    for state in zips:
        weather = get_state_weather(state,zips)
        weather_list[state] = weather["main"]
    return weather_list

if __name__ == "__main__":
    zips = (get_state_zips())
    #print(get_state_weather("OH",zips))
    print(get_weather_list())
    print(len(get_weather_list().keys()))

