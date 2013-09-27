Zin.controller 'CampaignAnalyticsCtrl', ($scope, $http) ->
  $http.get('/dummy_data/analytics.json').success (response) ->
    $scope.analytics = response