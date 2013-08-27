Zin.factory 'User', ($resource) ->
  $resource '/users/:id',
    id: "@id"
  ,
    update:
      method: 'PUT'

Zin.controller 'UserCtrl', ($scope, User) ->
  $scope.users = User.query {}, ->
    $scope.current_user = $scope.users[0] || {}
    $scope.phoneNumbers = ->
      $scope.current_user.notification_phone_nbrs && $scope.current_user.notification_phone_nbrs.split(',') || []
    $scope.emails = ->
      $scope.current_user.notification_emails && $scope.current_user.notification_emails.split(',') || []

  $scope.addPhoneNumber = (addPhoneNumberForm) ->
    if addPhoneNumberForm.$valid
      if @current_user.notification_phone_nbrs
        @current_user.notification_phone_nbrs += ",#{@newPhoneNumber}"
      else
        @current_user.notification_phone_nbrs = @newPhoneNumber
      @current_user.$update()
      @newPhoneNumber = ''

  $scope.removePhoneNumber = (index) ->
    phoneNumbers = @phoneNumbers()
    phoneNumbers.splice(index, 1)
    @current_user.notification_phone_nbrs = phoneNumbers.toString()
    @current_user.$update()

  $scope.addEmail = (addEmailForm) ->
    if addEmailForm.$valid
      if @current_user.notification_emails
        @current_user.notification_emails += ",#{@newEmail}"
      else
        @current_user.notification_emails = @newEmail
      @current_user.$update()
      @newEmail = ''

  $scope.removeEmail = (index) ->
    emails = @emails()
    emails.splice(index, 1)
    @current_user.notification_emails = emails.toString()
    @current_user.$update()

