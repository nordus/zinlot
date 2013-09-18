window.switchToTab = (tabName) ->
  $('#campaign-trigger a[href="#' + tabName + '"]').tab('show')

Zin.config ($routeProvider) ->
  $routeProvider.when '/create',
    template: JST.create()
  .otherwise
    redirectTo: '/create'
    
Zin.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"
  
Zin.factory 'Campaign', ($resource) ->
  $resource '/campaigns/:id',
    id: "@id"
  ,
    update:
      method: 'PUT'

Zin.filter 'dealerLotName', (Global) ->
  (id) ->
    dealerLot = _.findWhere Global.allDealerLots, {id: id}
    dealerLot && dealerLot.name
  
      
Zin.controller 'CampaignCtrl', ($scope, Campaign, Global, $filter) ->

  $scope.newCampaignWithDefaults = -> new Campaign
    trigger: 'SERVICE_NOTIFICATIONS'
    email_time: "2001-01-01T06:30:00-07:00"
    service_notifications: []
    mileage_interval: 3000

  $scope.allServiceNotifications = Global.allServiceNotifications
  $scope.allDealerLots = Global.allDealerLots

  $scope.campaigns = Campaign.query()
  $scope.campaign = $scope.newCampaignWithDefaults()

  $scope.emailTimeFormatted = ->
    "2001-01-01T#{$scope.hour}:#{$scope.minute}:00#{$scope.time_zone}"

  $scope.addOrUpdate = ->
    if $scope.campaign.id
      $scope.campaign.$update()
    else
      $scope.campaign.$save (savedCampaign, headers) ->
        $scope.campaigns.push savedCampaign
      
    $scope.resetCampaign()

    
  $scope.delete = ($index) ->
    campaign = $scope.campaigns[$index]

    if confirm("Are you sure you want to delete '#{campaign.name}'?")
      campaign.$delete()
      $scope.campaigns.splice($index, 1)

      
  $scope.edit = ($index) ->
    $scope.campaign = $scope.campaigns[$index]
    $scope.currentlyEditing = $scope.campaign.id 


  $scope.resetCampaign = ->
    $scope.currentlyEditing = undefined
    $scope.campaign = $scope.newCampaignWithDefaults()

    
  $scope.checkedServiceNotificationsInclude = (serviceNotification) ->
    $scope.campaign.service_notifications.indexOf(serviceNotification) isnt -1

    
  $scope.toggleServiceNotification = (serviceNotification) ->
    if $scope.checkedServiceNotificationsInclude(serviceNotification)
      $scope.campaign.service_notifications.splice($scope.campaign.service_notifications.indexOf(serviceNotification), 1)
    else
      $scope.campaign.service_notifications.push serviceNotification

    
  $scope.$watch 'campaign', ->
    if trigger = $scope.campaign.trigger
      switchToTab(trigger.toLowerCase())
    
    if email_time = $scope.campaign.email_time
      $scope.hour = $filter('date')(email_time, 'HH')
      $scope.minute = $filter('date')(email_time, 'mm')
      $scope.time_zone = $filter('date')(email_time, 'Z')
    
    if dealer_lot_id = $scope.campaign.dealer_lot_id
      $scope.dealer_lot = _.findWhere(Global.allDealerLots, {id: dealer_lot_id})
    else
      $scope.dealer_lot = _.findWhere(Global.allDealerLots, {name: '_ALL_'})

      
  $scope.$watch 'emailTimeFormatted()', ->
    $scope.campaign.email_time = $scope.emailTimeFormatted()

    
  $scope.$watch 'dealer_lot', ->
    $scope.campaign.dealer_lot_id = $scope.dealer_lot.id
    
    
  $('#campaign-trigger a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
    selectedTrigger = $(e.target).attr('href').replace('#', '').toUpperCase()
    
    if $scope.campaign.trigger isnt selectedTrigger
      $scope.$apply ->
        $scope.campaign.trigger = selectedTrigger
    