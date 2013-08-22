# alert 
alertFadeOut = -> 
  $(".alert").fadeOut 4000

$(document).ready -> alertFadeOut()
$(document).on "page:change", -> alertFadeOut()