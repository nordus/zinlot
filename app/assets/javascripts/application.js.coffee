#= require jquery

#= require angular
#= require angular-resource
#= require_self
#= require filters

#= require lodash
#= require jquery_ujs
#= require map_icon
#= require tabletop
#= require highcharts
#= require chartkick
#= require users
#= require twitter/bootstrap

@Zin ?= angular.module('zin', ['ngResource'])

Zin.config ["$httpProvider", ($httpProvider) ->
  # Inject the CSRF token
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = document.getElementsByName("csrf-token")[0].content
  # By default, angular sends "application/json, text/plain, */*" which rails
  # sees and focuses on the */* and sends html :-(
  $httpProvider.defaults.headers.common['Accept'] = "application/json"
]

new Pusher('f513119581ede36ac6c4').subscribe('guard-pusher').bind 'guard', ->
  location.reload()
