---
---

$ ->
  clientId = '615275084309-tk0m0kf81f623ijo1lppe6or2oaishsm.apps.googleusercontent.com'
  apiKey = 'AIzaSyBdKqfaeMdg951aKscthFGaL_Ikdr5okJc'
  userEmail = 'd4j83rh23o1v1i4p4tpoa1f6g4@group.calendar.google.com'
  userTimeZone = 'Chicago'
  maxRows = 10
  calName = 'Prairie Fire Glass'
  scopes = 'https://www.googleapis.com/auth/calendar'

  handleClientLoad()


#--------------------- Add a 0 to numbers

padNum = (num) ->
  if num <= 9
    return '0' + num
  num

#--------------------- end
#--------------------- From 24h to Am/Pm

AmPm = (num) ->
  if num <= 12
    return 'am ' + num
  'pm ' + padNum(num - 12)

#--------------------- end
#--------------------- num Month to String

monthString = (num) ->
  if num == '01'
    return 'JAN'
  else if num == '02'
    return 'FEB'
  else if num == '03'
    return 'MAR'
  else if num == '04'
    return 'APR'
  else if num == '05'
    return 'MAJ'
  else if num == '06'
    return 'JUN'
  else if num == '07'
    return 'JUL'
  else if num == '08'
    return 'AUG'
  else if num == '09'
    return 'SEP'
  else if num == '10'
    return 'OCT'
  else if num == '11'
    return 'NOV'
  else if num == '12'
    return 'DEC'
  return

#--------------------- end
#--------------------- from num to day of week

dayString = (num) ->
  if num == '1'
    return 'mon'
  else if num == '2'
    return 'tue'
  else if num == '3'
    return 'wed'
  else if num == '4'
    return 'thu'
  else if num == '5'
    return 'fri'
  else if num == '6'
    return 'sat'
  else if num == '0'
    return 'sun'
  return

#--------------------- end
#--------------------- client CALL

handleClientLoad = ->
  gapi.client.setApiKey apiKey
  checkAuth()
  return

#--------------------- end
#--------------------- check Auth

checkAuth = ->
  gapi.auth.authorize {
    client_id: clientId
    scope: scopes
    immediate: true
  }, handleAuthResult
  return

#--------------------- end
#--------------------- handle result and make CALL

handleAuthResult = (authResult) ->
  if authResult
    makeApiCall()
  return

#--------------------- end
#--------------------- API CALL itself

makeApiCall = ->
  console.log "foo"
  today = new Date
  #today date
  gapi.client.load 'calendar', 'v3', ->
    request = gapi.client.calendar.events.list(
      'calendarId': userEmail
      'timeZone': userTimeZone
      'singleEvents': true
      'timeMin': today.toISOString()
      'maxResults': maxRows
      'orderBy': 'startTime')
    request.execute (resp) ->
      `var str`
      i = 0
      while i < resp.items.length
        li = document.createElement('li')
        item = resp.items[i]
        classes = []
        allDay = if item.start.date then true else false
        startDT = if allDay then item.start.date else item.start.dateTime
        dateTime = startDT.split('T')
        #split date from time
        date = dateTime[0].split('-')
        #split yyyy mm dd
        startYear = date[0]
        startMonth = monthString(date[1])
        startDay = date[2]
        startDateISO = new Date(startMonth + ' ' + startDay + ', ' + startYear + ' 00:00:00')
        startDayWeek = dayString(startDateISO.getDay())
        if allDay == true
          #change this to match your needs
          str = [
            startDayWeek
            ' '
            startMonth
            ' '
            startDay
            ' '
            startYear
            item.summary
            '<br><br>'
          ]
        else
          time = dateTime[1].split(':')
          #split hh ss etc...
          startHour = AmPm(time[0])
          startMin = time[1]
          str = [
            startDayWeek
            ' '
            startMonth
            ' '
            startDay
            ' '
            startYear
            ' - '
            startHour
            ':'
            startMin
            item.summary
            '<br><br>'
          ]
        li.innerHTML = str.join('')
        li.setAttribute 'class', classes.join(' ')
        document.getElementById('events').appendChild li
        i++
      document.getElementById('updated').innerHTML = 'updated ' + today
      document.getElementById('calendar').innerHTML = calName
      return
    return
  return
