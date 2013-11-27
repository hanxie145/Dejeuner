# alert 
alertFadeOut = -> 
  $(".alert").fadeOut 4000

sidebarToggle = -> 
  $('.sidebar-collapse').click (e) -> 
    e.preventDefault()
    $('#sidebar').toggleClass '.menu-min'

# for the line chart on the dashboard page
staticPagesGraphs = -> 
  d1 = [[1,10], [2, 150], [3, 237], [4, 288], [5, 388], [6, 678], [7, 1000]]

  sales_charts = $("#sales-charts").css(
    width: "100%"
    height: "300px"
  )
  $.plot "#sales-charts", [
    label: "Subscribers"
    data: d1
  ],
    hoverable: true
    shadowSize: 0
    series:
      lines:
        show: true

      points:
        show: true

    xaxis:
      tickLength: 0

    yaxis:
      ticks: 10
      min: 0
      max: 1000
      tickDecimals: 3

    grid:
      backgroundColor:
        colors: ["#fff", "#fff"]

      borderWidth: 1
      borderColor: "#555"

  # for slim scroll or overflow-y
  $(".dialogs,.comments").slimScroll height: "300px"

  #Android's default browser somehow is confused when tapping on label which will lead to dragging the task
  #so disable dragging when clicking on label
  agent = navigator.userAgent.toLowerCase()
  if "ontouchstart" of document and /applewebkit/.test(agent) and /android/.test(agent)
    $("#tasks").on "touchstart", (e) ->
      li = $(e.target).closest("#tasks li")
      return  if li.length is 0
      label = li.find("label.inline").get(0)
      e.stopImmediatePropagation()  if label is e.target or $.contains(label, e.target)

$(document).ready -> 
  alertFadeOut()
  sidebarToggle()
  staticPagesGraphs()

$(document).on "page:change", -> 
  alertFadeOut()
  sidebarToggle()
  staticPagesGraphs()