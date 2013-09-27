#= require jquery

#= require_tree ./templates

#= require angular
#= require angular-resource
#= require angular-route
#= require ui-bootstrap-0.6.0.js
#= require ui-bootstrap-tpls-0.6.0.js
#= require_self
#= require filters
#= require global
#= require_tree ./controllers

#= require gauge
#= require lodash
#= require jquery_ujs
#= require map_icon
#= require tabletop
#= require highcharts
#= require chartkick
#= require users
#= require reports
#= require dashboard
#= require campaigns
#= require twitter/bootstrap

angular.module('RestfulResourceModule', ['ngResource'])
  .factory 'RestfulResource', ($resource) ->
    (url, params, methods) ->
      defaults =
        update:
          method: 'put'
        create:
          method: 'post'

      methods = angular.extend(defaults, methods)

      resource = $resource(url, params, methods)

      resource.prototype.$save = (cb) ->
        if @id
          return @$update(cb)
        else
          return @$create(cb)

      return resource

@Zin = angular.module('zin', ['RestfulResourceModule', 'ngRoute', 'ui.bootstrap'])


Zin.config ["$httpProvider", ($httpProvider) ->
  # Inject the CSRF token
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = document.getElementsByName("csrf-token")[0].content
  # By default, angular sends "application/json, text/plain, */*" which rails
  # sees and focuses on the */* and sends html :-(
  $httpProvider.defaults.headers.common['Accept'] = "application/json"
]

Zin.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"
