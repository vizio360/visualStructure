describe 'Platforms collection', ->

  platforms = null
  expectedEndPointUrl = "/api/resource/platforms"

  beforeEach ->
    jasmine.addMatchers(customMatchers)
    platforms = require('collections/platforms')

  it 'is defined', ->
    expect(platforms).toBeDefined()

  it 'is a collection', ->
    expect(platforms).toBeACollection()

  it 'is a singleton', ->
    expect(platforms).toBeASingleton('collections/platforms')

  it 'has a url set', ->
    expect(platforms.url).toBe expectedEndPointUrl

  it 'has a model defined', ->
    PlatformModel = require "models/platform"
    expect(platforms.model).toEqual PlatformModel
