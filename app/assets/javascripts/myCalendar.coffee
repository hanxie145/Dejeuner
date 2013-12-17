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
      select: (start, end, allDay) ->
        bootbox.prompt "New Event Title:", (title) ->
          if title isnt null
            calendar.fullCalendar "renderEvent",
              title: title
              start: start
              end: end
              allDay: allDay
            , true # make the event "stick"

        calendar.fullCalendar "unselect"

      eventClick: (calEvent, jsEvent, view) ->
        form = $("<form class='form-inline'><label>Change event name  </label></form>")
        form.append "<input class='middle' autocomplete=off type=text value='" + calEvent.title + "' /> "
        form.append "<button type='submit' class='btn btn-sm btn-success'><i class='icon-ok'></i> Save</button>"
        div = bootbox.dialog(
          message: form
          buttons:
            delete:
              label: "<i class='icon-trash'></i> Delete Event"
              className: "btn-sm btn-danger"
              callback: ->
                calendar.fullCalendar "removeEvents", (ev) ->
                  ev._id is calEvent._id

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
                title: data.message
                # interesting date's month is zero index, but why nothing else =.=
                start: new Date(d.getFullYear(), data.run_at.month - 1, data.run_at.day, data.run_at.hour, data.run_at.minute)
                allDay: false
              , true # make the event "stick
        console.log data

$(document).ready -> 
  calendarFunc()

$(document).on 'page:change', -> 
  calendarFunc()