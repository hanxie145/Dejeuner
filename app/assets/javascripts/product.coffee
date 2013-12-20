# For the virtual telephone pad on checkins
checkInNumbers = -> 
  $('.check-in-virtual-number').click -> 
    prevNum = $('.check-in-number').val()
    newNum = prevNum + $(this).text()
    $('.check-in-number').val newNum

  # for removing a number
  $('.check-in-remove').click -> 
    $('.check-in-number').val ""

# for subscriber index page. Filter the subscribers by last week, last month etc. 
subscriberFilter = -> 
  # for the button to toggle on and off for all subscribers
  $('.all-subscribers-switch').click (e) -> 
    val = $(this).val()
    if val is 'off'
      $(this).val 'on'
      timeframe = $('#timeframe-select').val()
      Turbolinks.visit("?timeframe=#{timeframe}")      
    else
      $(this).val 'off'

  $('#timeframe-select').change (e) -> 
    val = $(this).val()
    # switch the page via turbolinks, as to show contacts for another contact_list
    Turbolinks.visit("?timeframe=#{val}")

# for the piechart on the main page 
productDrawPieChart = -> 
  drawPieChart = (placeholder, data, position) ->
    $.plot placeholder, data,
      series:
        pie:
          show: true
          tilt: 0.8
          highlight:
            opacity: 0.25

          stroke:
            color: "#fff"
            width: 2

          startAngle: 2

      legend:
        show: true
        position: position or "ne"
        labelBoxBorderColor: null
        margin: [-30, 15]

      grid:
        hoverable: true
        clickable: true

  if $('#piechart-placeholder').length
    $(".easy-pie-chart.percentage").each ->
      $box = $(this).closest(".infobox")
      barColor = $(this).data("color") or ((if not $box.hasClass("infobox-dark") then $box.css("color") else "rgba(255,255,255,0.95)"))
      trackColor = (if barColor is "rgba(255,255,255,0.95)" then "rgba(255,255,255,0.25)" else "#E2E2E2")
      size = parseInt($(this).data("size")) or 50
      $(this).easyPieChart
        barColor: barColor
        trackColor: trackColor
        scaleColor: false
        lineCap: "butt"
        lineWidth: parseInt(size / 10)
        animate: (if /msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase()) then false else 1000)
        size: size

    placeholder = $("#piechart-placeholder").css(
      width: "90%"
      "min-height": "150px"
    )
    data = [
      label: "have not checked in for a week"
      data: 38.7
      color: "#68BC31"
    ,
      label: "have not checked in for two weeks"
      data: 24.5
      color: "#2091CF"
    ,
      label: "have not checked in for a month"
      data: 8.2
      color: "#AF4E96"
    ,
      label: "have checked in this week"
      data: 18.6
      color: "#DA5430"
    ]
    console.log $('#piechart-placeholder').data('graph')
    drawPieChart placeholder, data

    ###
    we saved the drawing function and the data to redraw with different position later when switching to RTL mode dynamically
    so that's not needed actually.
    ###
    placeholder.data "chart", data
    placeholder.data "draw", drawPieChart
    $tooltip = $("<div class='tooltip top in'><div class='tooltip-inner'></div></div>").hide().appendTo("body")
    previousPoint = null
    placeholder.on "plothover", (event, pos, item) ->
      if item
        unless previousPoint is item.seriesIndex
          previousPoint = item.seriesIndex
          tip = item.series["label"] + " : " + item.series["percent"] + "%"
          $tooltip.show().children(0).text tip
        $tooltip.css
          top: pos.pageY + 10
          left: pos.pageX + 10

      else
        $tooltip.hide()
        previousPoint = null


$(document).ready ->
  checkInNumbers()
  subscriberFilter()
  productDrawPieChart()

$(document).on "page:change", -> 
  checkInNumbers()
  subscriberFilter()
  productDrawPieChart()