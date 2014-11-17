describe 'Platform model', ->

  Platform = null

  beforeEach ->
    jasmine.addMatchers(customMatchers)
    Platform = require('models/platform')

  it 'is defined', ->
    expect(Platform).toBeDefined()

  it 'is a model', ->
    platform = new Platform
    expect(platform).toBeAModel()
