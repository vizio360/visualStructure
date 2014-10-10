expect = chai.expect
should = chai.should()

describe 'Platform model', ->

  Platform = null

  beforeEach ->
    Platform = require('models/platform')

  it 'is defined', ->
    should.exist Platform

  it 'is a model', ->
    platform = new Platform
    expect(platform).to.be.a.model()
