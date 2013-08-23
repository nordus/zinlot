@Zin = @Zin or {}
Zin.Form = ((fn) ->
  _origEmailEditor = false
  _origEmailInput = false
  _origEmailValue = ""
  _emailInputId = 1
  _addEmailTip = "Add email"
  initEmailEditor: ->
    _origEmailEditor = $("#emailsInput")

    if _origEmailEditor.length
      _origEmailEditor.addClass "hidden hide"
      _origEmailInput = $("#user_notification_emails")
      _origEmailValue = $("#user_notification_emails").val().replace(/^\s+|\s+$/g, "")
      @createEmailEditor()
      @calculateEmails()

  handleKeyUp: (event) ->
    ele = event.target
    keycode = event.keyCode
    @exeKeyUp ele, keycode

  exeKeyUp: (ele, keycode) ->
    emailValue = $(ele).val().replace(/^\s+|\s+$/g, "")

    #  32 is keycode for space bar
    #  188 is keycode for comma
    if emailValue isnt "" and (keycode is 32 or keycode is 188)
      @createNewEmail emailValue, ele
      $(ele).val ""
    @calculateEmails()

  handleBlur: (event) ->
    ele = event.target
    emailValue = $(ele).val().replace(/^\s+|\s+$/g, "")
    @exeKeyUp ele, 188  if emailValue and ele is @getLastEmailInput()
    @deleteEmail ele  if not emailValue and ele isnt @getLastEmailInput()

  createEmailEditor: ->
    window._emailEditor = $("<div></div>").attr(id: "emailEditor")
    if _origEmailValue
      emailValues = _origEmailValue.split(",")
      i = 0

      while i < emailValues.length
        @createNewEmail emailValues[i]  if emailValues[i]
        i++
    @createNewEmail()
    $(_emailEditor).insertAfter _origEmailEditor

  createNewEmail: (emailValue, ele) ->
    newEmailDiv = $("<div></div>").addClass("input-group").attr(id: "emailInput" + _emailInputId)
    newEmailInput = $("<input>").attr(
      type: "text"
      name: "email" + _emailInputId
      id: "email" + _emailInputId
      title: _addEmailTip
    ).addClass("form-control").keyup((event) ->
      Zin.Form.handleKeyUp event
    ).blur((event) ->
      Zin.Form.handleBlur event
    )
    newEmailDiv.append newEmailInput
    if emailValue
      newEmailInput.val emailValue
      @createDelete newEmailDiv, newEmailInput, _emailInputId
    else
#      newEmailInput.formtips()
      newEmailInput.attr
        placeholder: _addEmailTip

    # ensure original email values are displayed in
    # the order they are listed
    unless ele
      $(_emailEditor).append newEmailDiv
    else
      $(newEmailDiv).insertBefore $(ele).parent()
    _emailInputId++
    @calculateEmails()

  createDelete: (newEmailDiv, newEmailInput, _emailInputId) ->
    _emailInputId = $(newEmailInput).attr("id").charAt(3)  unless _emailInputId
    deleteBttnWrapper = $("<span></span>").addClass('input-group-btn')
    deleteBttn = $("<btn></btn>").attr(id: "delete" + _emailInputId).addClass("btn btn-default").click(->
      Zin.Form.deleteEmail this
    )
    deleteBttnHtml = "<i class='glyphicon glyphicon-remove-sign'></i>"
    deleteBttn.html deleteBttnHtml
    $(deleteBttnWrapper).append deleteBttn
    $(newEmailDiv).append deleteBttnWrapper

  divToDelete: false
  deleteEmail: (deleteBttn) ->
    @divToDelete = $(deleteBttn).parent()
    $(@divToDelete).addClass "exeDelete"
    window.setTimeout "Zin.Form.exeDeleteEmail()", 500

  exeDeleteEmail: ->
    $(Zin.Form.divToDelete).remove()
    Zin.Form.calculateEmails()

  getLastEmailInput: ->
    i = _emailInputs.length - 1
    _emailInputs[i]

  calculateEmails: ->
    window._emailInputs = $("#emailEditor input")
    emailValue = undefined
    i = undefined
    emailValuesStr = ""
    i = 0
    while i < _emailInputs.length
      emailValue = $(_emailInputs[i]).val().replace(/^\s+|\s+$|\,/g, "")
      emailValuesStr += emailValue + ","  if emailValue and emailValue isnt _addEmailTip
      i++
    $(_origEmailInput).val emailValuesStr.replace(/^\s+|\s+$/g, "")
)(Zin.Form or {})


$(document).ready ->
  Zin.Form.initEmailEditor()