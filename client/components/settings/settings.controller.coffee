'use strict'

angular.module 'selfAdjustingAlarmApp'

.controller 'SettingsCtrl', ($rootScope, $scope, googleLogin, googleCalendar, googlePlus) ->
  $scope.defaultAlarmTime = '8:00AM'
  $scope.alarmFlexibility = 120
  $scope.morningPrepTime = 60
  $scope.normalCommuteTime = 18
  $scope.account =
    connected: false


  tomorrow = moment()
    .add(1, 'day')
    .hours(0)
    .minutes(0)
    .seconds(0)
    .format()

  $scope.connectToGoogleCalendarAccount = ->
    googleLogin.login()

  $scope.$on 'googlePlus:loaded', ->
    googlePlus.getCurrentUser().then (user) ->
      $scope.account.connected = true
      $scope.account.user = user
      $scope.account.name = user.displayName
      $scope.account.email = user.emails[0].value

      googleCalendar.listEvents({
        calendarId: $scope.account.email,
        timeMin: tomorrow,
        singleEvents: true,
        orderBy: 'startTime',
        maxResults: 20
      }).then (data) ->
        $rootScope.$broadcast 'googleCalendar:nextEvent', data[0]


  window._googleApiLoaded = ->
    gapi.auth.init ->
      $rootScope.$broadcast 'google:ready', {}

  googleScript = document.createElement('script')
  googleScript.setAttribute('type','text/javascript')
  googleScript.setAttribute('src', 'https://apis.google.com/js/client.js?onload=_googleApiLoaded')
  document.getElementsByTagName('head')[0].appendChild(googleScript)


  $scope.$on 'google:ready', ->
    # if authtoken is in database
    # pull up all the relevant info

    # db = new PouchDB('AlarmClockUser')

    # b.put({_id: 'mittens', auth: gapi.auth.getToken()})

    # db.get('mittens').then(function (doc) {
    #   console.log(doc);
    #   googleLogin.login()
    # });

