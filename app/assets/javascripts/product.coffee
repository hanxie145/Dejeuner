# For the virtual telephone pad on checkins
checkInNumbers = -> 
  $('.check-in-virtual-number').click -> 
    prevNum = $('.check-in-number').val()
    newNum = prevNum + $(this).text()
    $('.check-in-number').val newNum

  # for removing a number
  $('.check-in-remove').click -> 
    $('.check-in-number').val ""

$(document).ready ->
  checkInNumbers()

$(document).on "page:change", -> 
  checkInNumbers()