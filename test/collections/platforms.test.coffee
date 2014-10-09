expect = chai.expect
should = chai.should()


describe 'Platforms collection', ->

  chai.Assertion.addMethod 'collection', (type) ->
    new chai.Assertion(@_obj).to.be.instanceof(Backbone.Collection)

  platforms = null

  beforeEach ->
    platforms = require('collections/platforms')

  it 'is defined', ->
    should.exist platforms

  it 'is a collection', ->
    expect(platforms).to.be.a.collection()

  it 'is a singleton', ->
    expect(platforms).to.be.an "object"
    other = require('collections/platforms')
    platforms.should.deep.equal other
