'use strict'

angular.module 'selfAdjustingAlarmApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ui.router',
  'ui.bootstrap',
  'googleApi'
]

.config ($stateProvider, $urlRouterProvider, $locationProvider, googleLoginProvider) ->
  $urlRouterProvider
  .otherwise '/'

  $locationProvider.html5Mode true

  googleLoginProvider.configure {
    clientId: '59840384211-2rc3n4sulpp4duddpit5ofp378eckr0v.apps.googleusercontent.com',
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/calendar',
      'https://www.googleapis.com/auth/plus.login'
    ]
  }
