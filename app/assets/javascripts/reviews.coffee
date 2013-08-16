# for tabs and shiz 
feedbackTab = -> 
  $('.feedback-tab').click (e) -> 
    e.preventDefault()
    $('.campaigns').fadeOut 200, -> 
      $('.reviews').fadeIn()

    $(this).addClass('active')
    $('.campaign-tab').removeClass('active')

campaignTab = (e) -> 
  $('.campaign-tab').click (e) -> 
    e.preventDefault()
    $('.reviews').fadeOut 200, -> 
      $('.campaigns').fadeIn()

    $(this).addClass('active')
    $('.feedback-tab').removeClass('active')
  
$(document).ready -> 
  feedbackTab()
  campaignTab()

$(document).on "page:change", -> 
  feedbackTab()
  campaignTab