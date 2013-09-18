Zin.factory 'Report', ($resource) ->
  $resource '/reports/:id',
    id: "@id"
  ,
    update:
      method: 'PUT'

Zin.controller 'ReportCtrl', ($scope, Report) ->
  $scope.addEmail = (addEmailForm) ->
    if @emailsInput
      @emailsInput += ",#{@newEmail}"
    else
      @emailsInput = @newEmail
      