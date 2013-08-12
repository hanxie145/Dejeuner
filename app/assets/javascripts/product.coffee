# freakkking turbolinks
myFunct = -> 

  # animate quick links
  $('.dash-quick-link').on 'mouseenter', -> 
    $('img', this).stop().animate {"margin-left": "60px"}, 200, 'linear'
  $('.dash-quick-link').on 'mouseleave', -> 
    $('img', this).stop().animate {"margin-left": "0px"}, 200, 'linear'

  # bleh hacky
  $('.restaurant-quick-link').click (e) ->
    e.preventDefault()
    window.location.href = "/profile"

  $('.reviews-quick-link').click (e) -> 
    e.preventDefault()
    window.location.href = "/reviews"

  $('marketing-quick-link').click (e) -> 
    e.preventDefault()
    window.location.href = '/market'

$(document).ready ->
  myFunct()

$(document).on "page:change", -> 
  myFunct()