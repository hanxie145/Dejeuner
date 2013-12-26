calendarFunc = ->

  if $('#calendar').length

    # initialize the external events
    #    -----------------------------------------------------------------
    $("#external-events div.external-event").each ->
      
      # create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
      # it doesn't need to have a start or end
      eventObject = title: $.trim($(this).text()) # use the element's text as the event title
      
      # store the Event Object in the DOM element so we can get to it later
      $(this).data "eventObject", eventObject

    
    # initialize the calendar
    #    -----------------------------------------------------------------
    date = new Date()
    d = date.getDate()
    m = date.getMonth()
    y = date.getFullYear()
    calendar = $("#calendar").fullCalendar(
      buttonText:
        prev: "<i class=\"fa fa-chevron-left\"></i>"
        next: "<i class=\"fa fa-chevron-right\"></i>"

      header:
        left: "prev,next today"
        center: "title"
        right: "month,agendaWeek,agendaDay"

      events: [
      ]
      editable: true

      selectable: true
      selectHelper: true
      eventClick: (calEvent, jsEvent, view) ->
        form = $("<form class='form-inline'></form>")
        form.append "<blockquote><p>#{calEvent.title}</p></blockquote>" 
        form.append "<p class='lighter p-larger'>Will be sent on <b>#{calEvent.start}</b></p>"
        div = bootbox.dialog(
          message: form
          buttons:
            delete:
              label: "<i class='icon-trash'></i> Delete Message"
              className: "btn-sm btn-danger"
              callback: (cal_event) ->
                calendar.fullCalendar "removeEvents", (ev) ->
                  ev._id is calEvent._id
                # make ajax call to delete delayed job event
                $.ajax 
                  url: "scheduled_messages/#{calEvent.id}",
                  type: 'DELETE', 

            close:
              label: "<i class='icon-remove'></i> Close"
              className: "btn-sm"
        )
        form.on "submit", ->
          calEvent.title = form.find("input[type=text]").val()
          calendar.fullCalendar "updateEvent", calEvent
          div.modal "hide"
          false
    )
    # Make ajax call to get data about user's scheduled messages then display them on the calendar      
    $.ajax(
      url: "scheduled_messages.json"
    ).done (response) ->
      for data in response
        d = new Date()
        calendar.fullCalendar "renderEvent",
                id: data.id
                title: data.message
                # interesting date's month is zero index, but why nothing else =.=
                start: new Date(d.getFullYear(), data.run_at.month - 1, data.run_at.day, data.run_at.hour, data.run_at.minute)
                allDay: false
              , true # make the event "stick

$(document).ready -> 
  calendarFunc()

$(document).on 'page:change', -> 
  calendarFunc()