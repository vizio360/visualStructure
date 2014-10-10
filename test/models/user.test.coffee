expect = chai.expect
should = chai.should()

describe 'User model', ->

  user = null
  expectedUserPasswordNotProvidedErrorMsg = "You need to provide both username and password"

  beforeEach ->
    user = require('models/user')

  it 'is defined', ->
    should.exist user

  it 'is a model', ->
    expect(user).to.be.a.model()

  it 'is a Singleton', ->
    expect(user).to.be.a.Singleton('models/user')

  it "doesn't validate if no user and/or password are provided", ->
    checkValidation = (user) ->
      user.isValid().should.be.false
      error = user.validationError
      expect(error).to.exist
      user.validationError.should.equal expectedUserPasswordNotProvidedErrorMsg

    cases = [
        user: "simone"
        password: ""
      ,
        user: ""
        password: "something"
      ,
        user: ""
        password: ""
      ,
        user: undefined
        password: "something"
    ]
    for c in cases
      user.set c
      checkValidation user
