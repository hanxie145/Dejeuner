# for tabs and shiz 
messageTab = -> 
  $('.message-tab').click (e) -> 
    e.preventDefault()
    $('.market-history').fadeOut 200, -> 
      $('.market-message').fadeIn()

    $(this).addClass('active')
    $('.history-tab').removeClass('active')

historyTab = (e) -> 
  $('.history-tab').click (e) -> 
    e.preventDefault()
    $('.market-message').fadeOut 200, -> 
      $('.market-history').fadeIn()

    $(this).addClass('active')
    $('.message-tab').removeClass('active')
  
$(document).ready -> 
  messageTab()
  historyTab()

$(document).on 'page:change', -> 
  messageTab()
  historyTab()
