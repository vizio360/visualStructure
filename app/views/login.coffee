template = require 'templates/login'
UserSingleton = require 'models/user'

class Login extends Backbone.View

  signinDialogDelay: 500

  events:
    "submit": "signin"

  render: () ->
    @$el.html template
    @el

  activate: ->
    @$el.removeClass "hidden"

  deactivate: ->
    @$el.addClass "hidden"

  showSigninDialog: ->
    @signinDialogTimeout = setTimeout =>
      @$('#signinDialog').modal('show')
    , @signinDialogDelay

  hideSigninDialog: ->
    clearTimeout @signinDialogTimeout
    @$('#signinDialog').modal('hide')

  showErrorMessage: (msg) ->
    @$("form").addClass("has-error")
    @$("#errorMessage").text(msg)
    @$("#errorMessage").removeClass("hidden")

  hideErrorMessage: ->
    @$("form").removeClass("has-error")
    @$("#errorMessage").text("")
    @$("#errorMessage").addClass("hidden")

  signin: (evt) ->
    evt.preventDefault()
    @hideErrorMessage()
    UserSingleton.set
      username: @$(".login-email input").val(),
      password: @$(".login-password input").val()
    if not UserSingleton.isValid()
      @showErrorMessage UserSingleton.validationError
    else
      @showSigninDialog()
      UserSingleton.authenticate (status) => @authResult(status)

  authResult: (result) ->
    @hideSigninDialog()
    if result is "success"
      @hideErrorMessage()
      @trigger "success"
    else
      @showErrorMessage "Wrong username and/or password"

module.exports = Login
