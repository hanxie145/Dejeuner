# alert 
alertFadeOut = -> 
  $(".alert").fadeOut 3000

$(document).ready -> alertFadeOut()
$(document).on "page:change", -> alertFadeOut()