---
---

$ ->
  getUpcomingEvents()

getUpcomingEvents = ->
  $el = $('[data-behavior~=calendar-events]')

  if $el.length
    $el.addClass "loading"
    requestCalendarEvents $el

requestCalendarEvents = ($el) ->
  console.log $el
  mykey = 'AIzaSyC1B0WHEVcWYeJqwYLYlD6qkyJm0Zerz3g'
  calendarid = 'd4j83rh23o1v1i4p4tpoa1f6g4@group.calendar.google.com'
  requestTime = (new Date()).toISOString()

  $.ajax
    type: 'GET'
    url: encodeURI('https://www.googleapis.com/calendar/v3/calendars/' + calendarid + '/events?key=' + mykey + '&orderBy=startTime' + '&singleEvents=true' + '&timeMin=' + requestTime)
    dataType: 'json'
    success: (response) ->
      console.log response['items']
      $el.removeClass "loading"
      $.each response.items, (i, item) ->
        $el.append '<p class="event"><strong>' + item.summary + '</strong><br>' + strftime('%A, %b %e', new Date(item.start.dateTime)) + ' — ' + strftime('%A, %b %e, %Y', new Date(item.end.dateTime)) + '<br>' + strftime('%l:%M%P', new Date(item.start.dateTime)) + ' — ' + strftime('%l:%M%P', new Date(item.end.dateTime)) + '<span class="event__description">' + item.description + '<br>' + '<a href="' + item.htmlLink + '" class="cta-button cta-button--add-event">+ Add to your Google Calendar</a></span></p>'
      return
    error: (response) ->
      console.log 'doh'
      return


