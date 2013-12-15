calendarFunc = ->

  if $('#calendar').length

    # make the ajax call for the data about scheduled messages        
    myData = []
    $.ajax(
      url: "scheduled_messages.json"
    ).done (response) ->
      console.log response

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
        title: "All Day Event"
        start: new Date(y, m, 1)
        className: "label-important"
      ,
        title: "Long Event"
        start: new Date(y, m, d - 5)
        end: new Date(y, m, d - 2)
        className: "label-success"
      ,
        title: "Some Event"
        start: new Date(y, m, d - 3, 16, 0)
        allDay: false
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

$(document).ready -> 
  calendarFunc()

$(document).on 'page:change', -> 
  calendarFunc()