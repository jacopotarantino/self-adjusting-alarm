'use strict'

angular.module 'selfAdjustingAlarmApp'
.controller 'NextAlarmCtrl', ($scope) ->
  $scope.nextEvent = {}

  defaultAlarmTime = moment()
    .add(1, 'day')
    .hours(8)
    .minutes(0)
    .seconds(0)

  alarmTime = defaultAlarmTime


  $scope.nextAlarmTime = ->
    alarmTime.format('MMMM Do YYYY, h:mm:ss a')


  adjustNextAlarmTime = ->
    nextEventTime = moment($scope.nextEvent.start.dateTime)

    current = moment nextEventTime.format()
    earliestPossibleTime = moment defaultAlarmTime.format()

    prepTime = 60
    commuteTime = 18
    flexibility = 120

    earliestPossibleTime.subtract(flexibility, 'minutes')

    current.subtract(prepTime, 'minutes')
    current.subtract(commuteTime, 'minutes')

    console.log 'adjusted alarm time: ', current.format()
    console.log 'default alarm time: ', alarmTime.format()
    console.log 'earliest alarm time: ', earliestPossibleTime.format()

    current = moment.min(current, alarmTime)
    alarmTime = moment.max(current, earliestPossibleTime)

    console.log 'chosen alarm time: ', alarmTime.format()


  $scope.$on 'googleCalendar:nextEvent', (event, data) ->
    console.log data
    $scope.accountConnected = true
    $scope.nextEvent = data
    adjustNextAlarmTime()

