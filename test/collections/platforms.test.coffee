expect = chai.expect
should = chai.should()

describe 'Platforms collection', ->

  platforms = null
  expectedEndPointUrl = "/api/resource/platforms"

  beforeEach ->
    platforms = require('collections/platforms')

  it 'is defined', ->
    should.exist platforms

  it 'is a collection', ->
    expect(platforms).to.be.a.collection()

  it 'is a singleton', ->
    expect(platforms).to.be.a.Singleton('collections/platforms')

  it 'has a url set', ->
    platforms.url.should.equal expectedEndPointUrl

  it 'has a model defined', ->
    PlatformModel = require "models/platform"
    platforms.model.should.deep.equal PlatformModel
