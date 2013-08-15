# for tabs and shiz 
feedbackTab = -> 
  $('.feedback-tab').click (e) -> 
    e.preventDefault()
    $('.campaigns').fadeOut()
    $('.reviews').fadeIn()

    $(this).addClass('active')
    $('.campaign-tab').removeClass('active')

campaignTab = (e) -> 
  $('.campaign-tab').click (e) -> 
    e.preventDefault()
    $('.campaigns').fadeIn()
    $('.reviews').fadeOut()

    $(this).addClass('active')
    $('.feedback-tab').removeClass('active')
  
$(document).ready -> 
  feedbackTab()
  campaignTab()

$(document).on 'page:change', -> 
  feedbackTab()
  campaignTab