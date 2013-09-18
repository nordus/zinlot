lastWeekTestDriveCount = 10

Zin.controller 'DashCtrl', ($scope, Report) ->
  $scope.testDriveCount = 7
  $scope.lastWeekTestDriveCount = lastWeekTestDriveCount
  $scope.testDrivePercentageDelta = ->
    -(100 - $scope.testDriveCount/$scope.lastWeekTestDriveCount*100)
  
  window.setInterval ->
    $scope.$apply ->
      $scope.testDriveCount += 1
  , 9000
  
  $scope.$watch 'testDriveCount', ->
    if $scope.testDriveCount <= $scope.lastWeekTestDriveCount
      gauge.set $scope.testDriveCount
  
Zin.filter 'percentDelta', ->
  (percent) ->
    if +percent is 0
      "tied"
    else
      "#{percent.replace('-', '')}%"

$ ->      
  opts =
    lines: 12 # The number of lines to draw
    angle: 0.15 # The length of each line
    lineWidth: 0.1 # The line thickness
    pointer:
      length: 0.9 # The radius of the inner circle
      strokeWidth: 0.035 # The rotation offset
      color: "#000000" # Fill color
  
    limitMax: "false" # If true, the pointer will not go past the end of the gauge
    colorStart: "#90cdff" # Colors
    colorStop: "#90cdff" # just experiment with them
    strokeColor: "#E0E0E0" # to see which ones work best for you
    generateGradient: true
  
  if target = document.getElementById("foo") # your canvas element
    window.gauge = new Donut(target).setOptions(opts) # create sexy gauge!
    gauge.maxValue = lastWeekTestDriveCount # set max gauge value
    gauge.animationSpeed = 32 # set animation speed (32 is default value)
    gauge.set 7 # set actual value 
    #gauge.setTextField document.getElementById("preview-textfield")
  
  
  complianceGaugeOpts =
    lines: 12 # The number of lines to draw
    angle: 0.15 # The length of each line
    lineWidth: 0.1 # The line thickness
    pointer:
      length: 0.9 # The radius of the inner circle
      strokeWidth: 0.035 # The rotation offset
      color: "#000000" # Fill color
  
    limitMax: "false" # If true, the pointer will not go past the end of the gauge
    colorStart: "#9ade11" # Colors
    colorStop: "#9ade11" # just experiment with them
    strokeColor: "#E0E0E0" # to see which ones work best for you
    generateGradient: true
  
  if complianceTarget = document.getElementById("compliance-gauge") # your canvas element
    window.complianceGauge = new Donut(complianceTarget).setOptions(complianceGaugeOpts) # create sexy gauge!
    complianceGauge.maxValue = 500 # set max gauge value
    complianceGauge.animationSpeed = 32 # set animation speed (32 is default value)
    complianceGauge.set 481 # set actual value
      
      
  container = $("#container")
  if container.length
    $("#container").highcharts
      credits:
        enabled: false
      colors: ["#e96b57", "#ffc03e", "#e6db4b", "#64b74e"]  
      chart:
        backgroundColor: 'transparent'
        plotBackgroundColor: 'transparent'
        height: 300
        type: "bar"
  
      title:
        text: " "
  
      xAxis:
        categories: ["For Sale", "Rental", "Fleet"]
  
      yAxis:
        min: 0
        title:
          text: "Days in inventory"
  
      legend:
        backgroundColor: "#FFFFFF"
        borderColor: "#FBEED5"
        reversed: true
  
      plotOptions:
        series:
          stacking: "normal"
  
      series: [
        name: "60+"
        data: [13, 24, 34]
      ,
        name: "31-60"
        data: [51, 32, 43]
      ,
        name: "11-30"
        data: [21, 22, 33]
      ,
        name: "0-10"
        data: [31, 42, 43]
      ]