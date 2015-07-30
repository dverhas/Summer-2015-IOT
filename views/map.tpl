<html>
  <head>

  <script src="http://maps.googleapis.com/maps/api/js"></script>

  <script>
    function initialize() {
      var lonlat;
      var mapProp = {
        center:new google.maps.LatLng(41.2398,-81.4408),
        zoom:11,
        mapTypeId:google.maps.MapTypeId.ROADMAP
      };
      var map=new google.maps.Map(document.getElementById("googleMap"),mapProp);

%for item in data["list"]:
%      tempf = (item['main']['temp'] - 273.15)* 1.8000 + 32.00
%      greencolor = '00'
%      redcolor = '00'
%      bluecolor = '00'
%      if tempf > 85 :
%          redcolor = 'FF'
%      elif tempf > 65 :
%          redcolor = '55'
%          bluecolor = '55'
%      elif tempf >45 :
%          redcolor = '22'
%          bluecolor = '88'
%      elif tempf > 25 :
%          redcolor = '00'
%          bluecolor = 'CC'
%      end
    lonlat = new google.maps.LatLng({{item["coord"]["lat"]}},{{item["coord"]["lon"]}});
    marker = new google.maps.Circle({
      center:lonlat,
      radius:1400,
      strokeColor:"#0000FF",
      strokeOpacity:0.3,
      strokeWeight:2,
      fillColor:"#{{redcolor}}{{greencolor}}{{bluecolor}}",
      fillOpacity:0.05
    });
    marker.setMap(map);

    marker = new google.maps.Marker({
      position:lonlat,
      icon:'http://openweathermap.org/img/w/{{item["weather"][0]["icon"]}}.png'
    });
    marker.setMap(map);
%end
    }

    google.maps.event.addDomListener(window, 'load', initialize);
    </script>

  </head>

  <body>
source: http://api.openweathermap.org/data/2.5/find?lat=41.2398&lon=81.4408&cnt=25
    <div id="googleMap" style="width:800; height:600"></div>
<br>
<br>
<br>
<br>
<table>
<tr>
  <th>lon</th><th>F</th>
  <th>tempf</th>
  <th>weather icon</th>
</tr>
%for item in data["list"]:
    %tempf = (item['main']['temp'] - 273.15)* 1.8000 + 32.00
    <tr>
    <td>{{item["coord"]["lat"]}}</td><td>{{item["coord"]["lon"]}}</td><td>{{tempf}}</td>
    <td>{{item["weather"][0]["icon"]}}</td>
    </tr>
%end
</table>
  </body>
</html>
