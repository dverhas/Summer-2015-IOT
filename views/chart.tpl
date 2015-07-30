<html>
  <head>
    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">

    // Load the Visualization API and the piechart package.
    google.load('visualization', '1.0', {
      'packages':['corechart', 'line']
    });

    // Set a callback to run when the Google Visualization API is loaded.
    google.setOnLoadCallback(drawChart);

    // Callback that creates and populates a data table,
    // instantiates the pie chart, passes in the data and
    // draws it.
    function drawChart() {

      // Create the data table.
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Date');
      data.addColumn('number', 'Temp F');
%for item in data:
    data.addRow( ['{{item["timestamp"]}}',{{item["tempf"]}}]);
%end

      // Set chart options
      var options = {'title':'Temp in the behive',
        'width':1600,
        'height':600
      };

      // Instantiate and draw our chart, passing in some options.
      var chart = new google.visualization.LineChart(
        document.getElementById('chart_div')
      );
      chart.draw(data, options);

                                                                                  }
    </script>
  </head>

  <body>
    <div id="chart_div" style="width:400; height:300"></div>
<br>
<br>
<br>
<br>
<table>
<tr><th>Time</th><th>Temp F</th></tr>
%for item in data:
    <tr>
    <td>{{item["timestamp"]}}</td><td>{{item["tempf"]}}</td>
    </tr>
%end
</table>
  </body>
</html>
