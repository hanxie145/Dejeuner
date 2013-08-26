# for tabs and shiz 
messageTab = -> 
  $('.message-tab').click (e) -> 
    e.preventDefault()
    $('.market-history').fadeOut 200, -> 
      $('.market-message').fadeIn()

    $(this).addClass('active')
    $('.history-tab').removeClass('active')

historyTab = -> 
  $('.history-tab').click (e) -> 
    e.preventDefault()
    $('.market-message').fadeOut 200, -> 
      $('.market-history').fadeIn()

    $(this).addClass('active')
    $('.message-tab').removeClass('active')


# for character counter
characterCount = -> 
  $('.text-message-area').keyup -> 
    chars = $(this).val().length
    console.log chars
    if chars > 160 
      $('.chars-left').text("Character limit exceeded! Message will be cut off after 160 letters.")
    else 
      $('.chars-left').text("Characters: #{chars}/160")

  $('.text-message-area').keydown -> 
    chars = $(this).val().length
    console.log chars
    if chars > 160 
      $('.chars-left').text("Character limit exceeded! Message will be cut off after 160 letters.")
    else 
      $('.chars-left').text("Characters: #{chars}/160")

$(document).ready -> 
  messageTab()
  historyTab()
  characterCount()

$(document).on 'page:change', -> 
  messageTab()
  historyTab()
  characterCount()
