# example dataset
data = {
  labels : ["January","February","March","April","May","June","July"],
  datasets : [
    {
      fillColor : "rgba(231, 76, 60,0.5)",
      strokeColor : "rgba(192, 57, 43,1.0)",
      pointColor : "#fff",
      pointStrokeColor : "rgba(44, 62, 80,1.0)",
      data : [50,30,28,60,78,100,150]
    }
  ]
}

# make the chart using chart.js
chartFunction = -> 
  ctx = $('#myChart').get(0).getContext('2d')
  myNewChart = new Chart ctx

  new Chart(ctx).Line(data, 
    scaleFontFamily: 'Raleway', 
    scaleFontSize: 20,
    bezierCurve : false
    )

$(document).ready ->
  chartFunction()

$(document).on 'page:change', -> 
  chartFunction()