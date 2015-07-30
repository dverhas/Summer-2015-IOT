<!DOCTYPE html>
<html>
  <head>
    <style>
      table, td {
        border:1px solid black;
      }
      element {align: center;}
    </style>

    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.google.com/jsapi?autoload={'modules':[{'name':'visualization','version':'1.1','packages':['corechart']}]}"></script>
    <script type="text/javascript">

    // Set a callback to run when the Google Visualization API is loaded.
    google.setOnLoadCallback(drawChart);

    // Callback that creates and populates a data table,
    // instantiates the pie chart, passes in the data and
    // draws it.
    function drawChart() {

      // Create the data table.
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Device');
      data.addColumn('number', 'Records');
      data.addColumn('number', 'Target');
%for user in sorted(max_date.iterkeys()) :
    data.addRow( ['{{user}}', {{devices[user]['rate']}}, 12]);
%end

      // Set chart options
      var options = {
        'title':'Rolling Hour Sample Rate',
        'width': 1000,
        'height':1000,
        hAxis:{
          title:'Data Rate'
        },
        vAxis:{
          title:'Device'
        },
        orientation:'vertical',
        seriesType:"bars",
        series:{1:{type:"line"}}
      };

      // Instantiate and draw our chart, passing in some options.
      var chart = new google.visualization.ComboChart(
        document.getElementById('chart_div')
      );
      chart.draw(data, options);

                                                                                  }
    </script>

  </head>

  <body>
<h1>Summer 2015 IOT Device Monitor</h1>
<br>
<table>
<tr>
  <th>Device</th>
  <th>Locate</th>
  <th>Last Data</th>
  <th>Since Last Data</th>
  <th># Of Data Records</th>
  <th>Last Hour Data Rate</th>
</tr>
%for user in sorted(max_date.iterkeys()) :
    <tr>
    <td>{{user}}</td>
    <td>
      <a target=_blank href='https://www.google.com/maps/dir/{{devices[user]['lat']}},{{devices[user]['lon']}}'>
      {{devices[user]['lat']}}, {{devices[user]['lon']}}
      </a>
      
    </td>
    <td>{{max_date[user]}}</td>
    <td>{{elapsed[user]}}</td>
    <td>{{devices[user]['total_records']}}</td>
    <td
%if devices[user]['rate'] == 0:
    style="background:pink;"
%end
>{{devices[user]['rate']}}</td>
    </tr>
%end
</table>

  <div id="chart_div" style="width:400; height:300"></div>
  </body>
</html>



