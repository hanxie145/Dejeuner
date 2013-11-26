# alert 
alertFadeOut = -> 
  $(".alert").fadeOut 4000

sidebarToggle = -> 
  $('.sidebar-collapse').click (e) -> 
    $('#sidebar').toggleClass 'menu-min'

$(document).ready -> 
  alertFadeOut()
  sidebarToggle()
$(document).on "page:change", -> 
  alertFadeOut()
  sidebarToggle()