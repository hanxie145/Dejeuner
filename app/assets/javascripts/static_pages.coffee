# alert 
alertFadeOut = -> 
  $(".alert").fadeOut 6000

sidebarToggle = -> 
  $('.sidebar-collapse').click (e) -> 
    e.preventDefault()
    $('#sidebar').toggleClass '.menu-min'

# for the line chart on the dashboard page
staticPagesGraphs = -> 
  d1 = [[1,10], [2, 150], [3, 237], [4, 288], [5, 388], [6, 678], [7, 1000]]

  if $('#sales-charts').length
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

# function for the sms credit refill page. To take the number of credits the user enters in and calculate how much it costs. Then append the data to the stripe payments button and the total cost input textfield 
smsCreditRefill = -> 
  $('#sms-credits-desired').on 'input', -> 
    # get user input on how many sms credits they want
    num_sms_credits = $(this).val()

    # calculate the price in cents
    price_per_sms = 1.5
    total_price = num_sms_credits * price_per_sms

    # display price in dollars 
    price =  "$" + (total_price / 100).toString()
    console.log price
    $('#sms-credits-price').val(price) 

    # change the params of the button to GET with params equalling how many credits the user wants. Uhm horrible practices lol...?
    $('.sms_credit_button').attr 'href', "/charges/new?num_sms_credits=#{total_price}&type=sms_credit_refill"

# Timepicker on the send message page
sendMessageTimePicker = -> 
  if $('#timepicker1').length 

    # time picker js
    $('#timepicker1').timepicker
      minuteStep: 1,
      showSeconds: true,
      showMeridian: true

    # be lazy and replace old font-awesome syntax with new one, since I can't figure out where it actually happens in the old 
    $('.bootstrap-timepicker-widget i').removeClass 'icon-chevron-up'
    $('.bootstrap-timepicker-widget i').addClass 'fa fa-chevron-up'

$(document).ready -> 
  alertFadeOut()
  sidebarToggle()
  staticPagesGraphs()
  smsCreditRefill()
  sendMessageTimePicker()

$(document).on "page:change", -> 
  alertFadeOut()
  sidebarToggle()
  staticPagesGraphs()
  smsCreditRefill()
  sendMessageTimePicker()