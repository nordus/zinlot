Zin.factory 'Campaign', (RestfulResource) ->
  RestfulResource '/campaigns/:id', id: '@id'


Zin.factory 'AllCampaigns', (Campaign) ->
  Campaign.query()


Zin.config ($routeProvider) ->
  $routeProvider
    .when('/create', {
      controller: 'CampaignCreateCtrl'
      template: JST['campaign_create']
    })
    .when('/run', {
      controller: 'CampaignRunCtrl'
      template: JST['campaign_run']
    })
    .when('/analytics', {
      controller: 'CampaignAnalyticsCtrl'
      template: JST['campaign_analytics']
    })
    .otherwise({redirectTo: '/create'})