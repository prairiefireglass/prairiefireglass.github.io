---
---

$ ->
  getUpcomingEvents()

getUpcomingEvents = ->
  $el = $('[data-behavior~=calendar-events]')
  requestCalendarEvents $el if $el.length

getStartDate = (item) ->
  if item.start.date
    d = new Date(item.start.date)
    new Date(d.setDate(d.getDate() + 1))
  else if item.start.dateTime
    new Date(item.start.dateTime)

getEndDate = (item) ->
  if item.end.date
    new Date(item.end.date)
  else if item.end.dateTime
    new Date(item.end.dateTime)

createEvent = (item) ->
  startDate = getStartDate(item)
  endDate = getEndDate(item)
  $newEvent = $('<p/>',
    id: item.id
    class: 'event'
  )
  $newEvent.append('<strong>' + item.summary + '</strong>')
  $newEvent.append('<span class="event__dates">' + strftime('%A, %b %e', getStartDate(item)) + ' — ' + strftime('%A, %b %e, %Y', getEndDate(item)) + '</span>')
  $newEvent.append('<span class="event__times">' + strftime('%l:%M%P', new Date(item.start.dateTime)) + ' — ' + strftime('%l:%M%P', new Date(item.end.dateTime)) + '</span>') if item.start.dateTime and item.end.dateTime
  return $newEvent

requestCalendarEvents = ($el) ->
  mykey = 'AIzaSyC1B0WHEVcWYeJqwYLYlD6qkyJm0Zerz3g'
  calendarid = 'd4j83rh23o1v1i4p4tpoa1f6g4@group.calendar.google.com'
  today   = new Date()
  timeMin = today.toISOString()
  timeMax = new Date(today.setDate(today.getDate() + 30)).toISOString()

  $.ajax
    type: 'GET'
    url: encodeURI('https://www.googleapis.com/calendar/v3/calendars/' + calendarid + '/events?key=' + mykey + '&orderBy=startTime' + '&singleEvents=true' + '&timeMin=' + timeMin+ '&timeMax=' + timeMax)
    dataType: 'json'
    success: (response) ->
      if response.items.length
        $el.closest('[data-role~=calendar-events-container]').show()
        $.each response.items, (i, item) ->
          $el.append createEvent(item)
      else
        $('[data-role~=no-events]').show()
      return
    error: (response) ->
      return


