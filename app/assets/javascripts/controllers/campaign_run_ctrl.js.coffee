Zin.controller 'CampaignRunCtrl', ($scope, Global, AllCampaigns, $filter) ->
  $scope.campaigns = AllCampaigns

  $scope.isInvalid = ->
    !@campaign || !@campaign.start_date || !@campaign.end_date

  $scope.saveCampaign = ->
    @campaign.is_running = true
    @campaign.$update()
    @campaign = undefined