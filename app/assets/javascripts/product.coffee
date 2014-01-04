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
      Turbolinks.visit("?timeframe=#{timeframe}")      

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
    pie = $('#piechart-placeholder')
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
      data: pie.data('graph-last-week')
      color: "#68BC31"
    ,
      label: "have not checked in for two weeks"
      data: pie.data('graph-two-weeks')
      color: "#2091CF"
    ,
      label: "have not checked in for a month"
      data: pie.data('graph-last-month')
      color: "#AF4E96"
    ,
      label: "have checked in this week"
      data: pie.data('graph-this-week')
      color: "#DA5430"
    ]
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

# for the generate sms page
generateSmsJs = -> 
  $("#fuelux-wizard").ace_wizard().on "finished", (e) ->
    $("#generate-sms-form").submit()

  $("#modal-wizard .modal-header").ace_wizard()
  $("#modal-wizard .wizard-actions .btn[data-dismiss=modal]").removeAttr "disabled"    
  if $('#datepicker').length 
    $('#datepicker').datepicker()

# js for the market page 
marketPageJs = ->
  # if the later radio button is checked, then the schedule box should be visible
  if $('.message_now_or_later').length
    if $('input[name=message_now_or_later]:checked').val() is 'later'
      $('.schedule-time-box').fadeIn()
      $('.market-blast-message').text 'Schedule my message'

  $('.message_now_or_later').click (e) -> 
    if $(this).val() is 'later' 
      $('.schedule-time-box').fadeIn()
      $('.market-blast-message').text 'Schedule my message'
    else 
      $('.schedule-time-box').fadeOut()
      $('.market-blast-message').text 'Send my message'

# JS for joyride product demo on main page
joyrideJs = -> 
  if $('#joyRideTipContent').length
    $("#joyRideTipContent").joyride
      autoStart: true
      postStepCallback: (index, tip) ->
        $(this).joyride "set_li", false, 1  if index is 2

      modal: true
      expose: true

$(document).ready ->
  checkInNumbers()
  subscriberFilter()
  productDrawPieChart()
  generateSmsJs()
  marketPageJs()
  joyrideJs()

$(document).on "page:change", -> 
  checkInNumbers()
  subscriberFilter()
  productDrawPieChart()
  generateSmsJs()
  marketPageJs()
  joyrideJs()