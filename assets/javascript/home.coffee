---
---

$ ->
  getUpcomingEvents()

getUpcomingEvents = ->
  $el = $('[data-behavior~=calendar-events]')

  if $el.length
    requestCalendarEvents $el

requestCalendarEvents = ($el) ->
  mykey = 'AIzaSyC1B0WHEVcWYeJqwYLYlD6qkyJm0Zerz3g'
  calendarid = 'd4j83rh23o1v1i4p4tpoa1f6g4@group.calendar.google.com'
  timeMin = new Date().toISOString()
  timeMax = new Date(+new Date + 12096e5).toISOString()

  $.ajax
    type: 'GET'
    url: encodeURI('https://www.googleapis.com/calendar/v3/calendars/' + calendarid + '/events?key=' + mykey + '&orderBy=startTime' + '&singleEvents=true' + '&timeMin=' + timeMin+ '&timeMax=' + timeMax)
    dataType: 'json'
    success: (response) ->
      if response.items.length
        $el.closest('[data-role~=calendar-events-container]').show()
        $.each response.items, (i, item) ->
          $el.append '<p class="event"><strong>' + item.summary + '</strong><br>' + strftime('%A, %b %e', new Date(item.start.dateTime)) + ' — ' + strftime('%A, %b %e, %Y', new Date(item.end.dateTime)) + '<br>' + strftime('%l:%M%P', new Date(item.start.dateTime)) + ' — ' + strftime('%l:%M%P', new Date(item.end.dateTime)) + '</p>'
      else
        $('[data-role~=no-events]').show()
      return
    error: (response) ->
      return


