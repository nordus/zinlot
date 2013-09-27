Zin.controller 'CampaignCreateCtrl', ($scope, Global, Campaign, AllCampaigns) ->
  $scope.newCampaign = -> new Campaign
    email_time:           new Date((new Date((new Date()).setHours(6))).setMinutes(30))
    mileage_interval_pct: 0.9
    service_issues:       []
    trigger:              'MILEAGE_INTERVAL'

  $scope.campaign = $scope.newCampaign()
  $scope.campaigns = AllCampaigns
  $scope.dealerLots = Global.dealerLots
  $scope.serviceIssues = Global.serviceIssues

  $scope.dealerLotName = (id) ->
    dealerLot = _.find @dealerLots, id: id
    dealerLot && dealerLot.name

  $scope.confirmDelete = (index) ->
    campaign = @campaigns[index]
    if confirm("Are you sure you want to delete #{campaign.name}")
      campaign.$delete =>
        @campaigns.splice(index, 1)

  $scope.invalid = ->
    ! @campaign.name || ! @campaign.trigger || ! @campaign.dealer_lot_id || ! @campaign[@campaign.trigger.toLowerCase()] || typeof @campaign[@campaign.trigger.toLowerCase()] == 'object' && ! @campaign[@campaign.trigger.toLowerCase()].length

  $scope.saveCampaign = ->
    isNew = ! @campaign.id
    @campaign.$save (savedCampaign) =>
      if isNew
        @campaigns.push savedCampaign

      @campaign = @newCampaign()


  $scope.siIndex = (si) ->
    @campaign.service_issues.indexOf(si)

  $scope.toggleServiceIssue = (si) ->
    if @siIndex(si) isnt -1
      @campaign.service_issues.splice @siIndex(si), 1
    else
      @campaign.service_issues.push si

  $scope.$watch 'campaign.trigger', ->
    console.log '.. campaign trigger changed to: ', $scope.campaign.trigger
    $("a[data-target='#" + $scope.campaign.trigger + "']").tab 'show'

  $('#trigger-tabs').on 'shown.bs.tab', (e) ->
    selectedTrigger = $(e.target).data('target').slice(1)
    if $scope.campaign.trigger isnt selectedTrigger
      $scope.$apply ->
        $scope.campaign.trigger = selectedTrigger
