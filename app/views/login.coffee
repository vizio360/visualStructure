template = require 'templates/login'
user = require 'models/user'

Login = Backbone.View.extend

  events:
    "submit": "signin"

  initialize: (options) ->

  render: () ->
    @$el.html template
    @el

  activate: ->
    @$el.removeClass "hide"

  deactivate: ->
    @$el.addClass "hide"

  
  showSigninDialog: ->
    @signinDialogDelay = setTimeout =>
      @$('#signinDialog').modal('show')
    , 500

  hideSigninDialog: ->
    clearTimeout @signinDialogDelay
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
    userModel = new user
                      username: @$(".login-email input").val(),
                      password: @$(".login-password input").val()
    if not userModel.isValid()
      @showErrorMessage userModel.validationError
    else
      @showSigninDialog()
      userModel.authenticate (status) => @authResult(status)

  authResult: (result) ->
    @hideSigninDialog()
    if result is "success"
      @hideErrorMessage()
      @trigger "success" 
    else
      @showErrorMessage "Wrong username and/or password"

module.exports = Login