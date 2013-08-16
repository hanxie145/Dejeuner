# for tabs and shiz 
feedbackTab = -> 
  $('.feedback-tab').click (e) -> 
    e.preventDefault()
    $('.campaigns').fadeOut()
    $('.campaigns-history').fadeOut()
    $('.reviews').fadeIn()

    prev = $('.active')
    $(this).addClass('active')
    prev.removeClass('active')

campaignTab = (e) -> 
  $('.campaign-tab').click (e) -> 
    e.preventDefault()
    $('.reviews').fadeOut()
    $('.campaigns-history').fadeOut()
    $('.campaigns').fadeIn()

    prev = $('.active')
    $(this).addClass('active')
    prev.removeClass('active')

pastCampaignsTab = (e) -> 
  $('.campaigns-history-tab').click (e) ->
    e.preventDefault()
    $('.campaigns').fadeOut()
    $('.reviews').fadeOut()
    $('.campaigns-history').fadeIn()

    prev = $('.active')
    $(this).addClass('active')
    prev.removeClass('active')
  
$(document).ready -> 
  feedbackTab()
  campaignTab()
  pastCampaignsTab()

$(document).on "page:change", -> 
  feedbackTab()
  campaignTab()
  pastCampaignsTab()