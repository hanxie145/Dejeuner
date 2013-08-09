data = {
  labels : ["January","February","March","April","May","June","July"],
  datasets : [
    {
      fillColor : "rgba(231, 76, 60,0.5)",
      strokeColor : "rgba(192, 57, 43,1.0)",
      pointColor : "#fff",
      pointStrokeColor : "rgba(44, 62, 80,1.0)",
      data : [28,48,40,19,96,27,100]
    }
  ]
}

$(document).ready ->
  ctx = $('#myChart').get(0).getContext('2d')
  myNewChart = new Chart ctx

  new Chart(ctx).Line(data, 
    scaleFontFamily: 'Raleway', 
    scaleFontSize: 20
    )