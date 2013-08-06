$(document).ready ->

  # for slide toggling number list
  $('#btn-minimize').click ->
    $('#table-minimize').slideToggle()

    myText = $(this).text().toString()

    # change btn text
    if myText is 'Minimize'
      $(this).text 'Expand'
    else 
      $(this).text 'Minimize'

  # general method for fading in and out stuff with tabs 
  fadeInOut = (mySlide, navColor) -> 
    $('.tab-shown').fadeOut 400, -> 
      $(mySlide).fadeIn 400
      $('.nav-fixed').css('border-color', navColor)
      shownPrev = $('.tab-shown')
      $(mySlide).addClass 'tab-shown'
      $(shownPrev).removeClass 'tab-shown'

  # clicking message button to show message section
  $('#scroll-message').click (e) -> 
    e.preventDefault()
    fadeInOut('.mass-message-slide', '#3498db')

  # expand contacts
  $('.scroll-contacts').click (e) ->
    e.preventDefault()

    fadeInOut('.contacts-slide', '#e74c3c')

    # expand table if display is none 
    if $('#table-minimize').css('display') is "none"
      $('#table-minimize').slideToggle()
      $('#btn-minimize').text('Minimize')

  # fadeIn individual message slide
  $('.btn-individual-message').click (e) ->
    e.preventDefault()

    fadeInOut('.individual-message-slide', '#9B59B6')
    $('#individual_message_text').focus()

    # get the name of the person to message 
    last_name = $(this).parent().parent().children()[0].innerText
    first_name = $(this).parent().parent().children()[1].innerText
    number = $(this).parent().parent().children()[2].innerText

    # replace name in header
    $('#individual-message-name').text("#{first_name} #{last_name}")

    # replace value pf number
    $('.individual-message-hidden-val').val(number)

  # expand import contacts 
  $('.btn-import').click (e) ->
    e.preventDefault()

    fadeInOut('.imports-slide', '#F1C40F')

  # for expanding nav buttons
  $('body').on 'mouseenter', '.btn-expand', (e) ->

    # attempting to get image back
    # console.log $(this).children(':first').src
    $(this).stop().animate { "width" : "70px"}, 50, "linear", ->
      $('img', this).css('display', 'none')
      $(this).append("<p style = 'display: inline;'>#{$(this).data "info"}</p>")

  # for unexpanding nav buttons
  $('body').on 'mouseleave', '.btn-expand', (e) ->
    $(this).stop().animate { "width" : "20px"}, 50, "linear", ->

      # get img again
        $('img', this).fadeIn()
        $('p', this).remove()