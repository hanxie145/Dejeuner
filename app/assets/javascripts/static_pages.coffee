# alert 
alertFadeOut = -> 
  $(".alert").fadeOut 6000

sidebarToggle = -> 
  $('.sidebar-collapse').click (e) -> 
    e.preventDefault()
    $('#sidebar').toggleClass '.menu-min'

# get the number of days in the month. Used in the x-axis of the graph
daysInTheMonthCalc = (month) ->
  year = new Date().getFullYear()
  monthStart = new Date(year, month, 1);
  monthEnd = new Date(year, month + 1, 1);
  monthLength = (monthEnd - monthStart) / (1000 * 60 * 60 * 24)

# for the line chart on the dashboard page
staticPagesGraphs = -> 
  if $('#sales-charts').length
    d1 = $('#sales-charts').data('graph')
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
        min: 1
        max: daysInTheMonthCalc(12)
        tickLength: 0

      yaxis:
        ticks: 10
        min: 0
        max: 100
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

# function for the sms credit refill page. To take the number of credits the user enters in and calculate how much it costs. Then append the data to the stripe payments button and the total cost input textfield 
smsCreditRefill = -> 
  $('#sms-credits-desired').on 'input', -> 
    # get user input on how many sms credits they want
    num_sms_credits = $(this).val()

    # calculate the price in cents
    price_per_sms = 3.5
    total_price = num_sms_credits * price_per_sms

    # display price in dollars 
    price =  "$" + (total_price / 100).toString()
    console.log price
    $('#sms-credits-price').val(price) 

    # change the params of the button to GET with params equalling how many credits the user wants. Uhm horrible practices lol...?
    $('.sms_credit_button').attr 'href', "/charges/new?num_sms_credits=#{total_price}&type=sms_credit_refill"

# DatePicker and Timepicker on the send message page
sendMessageTimePicker = -> 
  if $('#timepicker1').length 

    # time picker js
    $('#timepicker1').timepicker
      minuteStep: 15,
      showMeridian: true,

    # be lazy and replace old font-awesome syntax with new one, since I can't figure out where it actually happens in the old 
    $('.bootstrap-timepicker-widget i').removeClass 'icon-chevron-up'
    $('.bootstrap-timepicker-widget i').addClass 'fa fa-chevron-up'

  if $('#generate-sms-timepicker1').length 

    # time picker js
    $('#generate-sms-timepicker1').timepicker
      minuteStep: 15,
      showMeridian: true,
      defaultTime: '5:00 PM'

    # be lazy and replace old font-awesome syntax with new one, since I can't figure out where it actually happens in the old 
    $('.bootstrap-timepicker-widget i').removeClass 'icon-chevron-up'
    $('.bootstrap-timepicker-widget i').addClass 'fa fa-chevron-up'

  if $('#generate-sms-timepicker2').length 

    # time picker js
    $('#generate-sms-timepicker2').timepicker
      minuteStep: 15,
      showMeridian: true,
      defaultTime: '8:00 PM'
    $('.bootstrap-timepicker-widget i').removeClass 'icon-chevron-up'
    $('.bootstrap-timepicker-widget i').addClass 'fa fa-chevron-up'

  if $('.date-picker').length 
    $('.date-picker').datepicker {autoclose:true}

# js for the help page's accordion 
helpAccordion = -> 
  $('.accordion').on 'hide', (e) -> 
    $(e.target).prev().children(0).addClass('collapsed')
  $('.accordion').on 'show', (e) -> 
    $(e.target).prev().children(0).removeClass('collapsed')

# for the landing how to use slide
landingHowToUseJs = -> 
  $(".landing-next-slide").click (e) ->
    unless $('.active-how-to-use-slide').data('slide') is 3
      $(".active-how-to-use-slide").fadeOut 400, -> 
        slideNum = $(this).data('slide') 
        $(".landing-device-example-#{slideNum}").fadeOut 400, -> 
          if slideNum is 1
            $(".device").removeClass('device--browser')
            $(".flat-ios-device-container").removeClass('device--browser')
        $(".landing-how-to-use-slide-#{slideNum}").removeClass 'active-how-to-use-slide'
        $(".landing-device-example-#{slideNum + 1}").fadeIn()
        $(".landing-how-to-use-slide-#{slideNum + 1}").fadeIn 400, -> 
          $(this).addClass 'active-how-to-use-slide'

  $(".landing-prev-slide").click (e) ->
    unless $('.active-how-to-use-slide').data('slide') is 1
      $(".active-how-to-use-slide").fadeOut 400, -> 
        slideNum = $(this).data('slide') 
        console.log slideNum
        $(".landing-device-example-#{slideNum}").fadeOut 400, -> 
          if slideNum is 2
            $(".device").removeClass('device--ipad').addClass('device--browser')
            $(".flat-ios-device-container").removeClass('device--ipad').addClass('device--browser')
        $(".landing-how-to-use-slide-#{slideNum}").removeClass 'active-how-to-use-slide'
        $(".landing-device-example-#{slideNum - 1}").fadeIn()
        $(".landing-how-to-use-slide-#{slideNum - 1}").fadeIn 400, -> 
          $(this).addClass 'active-how-to-use-slide'

  $('.btn-to-tablet-or-phone').click (e) -> 
    e.preventDefault()
    if $(".device").hasClass('device--ipad') 
      $(".device").removeClass 'device--ipad'
      $('.flat-ios-device-container').removeClass 'device--ipad'
      $('.icon-to-tablet').removeClass('fa-mobile').addClass 'fa-tablet'
      $('.message-to-tablet').text 'See check in on tablet'
    else 
      $('.device').addClass 'device--ipad'
      $('.flat-ios-device-container').addClass 'device--ipad'
      $('.icon-to-tablet').removeClass('fa-tablet').addClass 'fa-mobile'
      $('.message-to-tablet').text 'See check in on mobile'


$(document).ready -> 
  # alertFadeOut()
  sidebarToggle()
  staticPagesGraphs()
  smsCreditRefill()
  sendMessageTimePicker()
  helpAccordion()
  landingHowToUseJs()

$(document).on "page:change", -> 
  # alertFadeOut()
  sidebarToggle()
  staticPagesGraphs()
  smsCreditRefill()
  sendMessageTimePicker()
  helpAccordion()
  landingHowToUseJs()