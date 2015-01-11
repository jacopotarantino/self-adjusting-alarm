'use strict'

angular.module 'selfAdjustingAlarmApp'
.controller 'CurrentTimeCtrl', ($scope, $interval) ->
  $scope.currentTime = moment().format('MMMM Do YYYY, h:mm:ss a')

  $interval ->
    $scope.currentTime = moment().format('MMMM Do YYYY, h:mm:ss a')
  , 1000
