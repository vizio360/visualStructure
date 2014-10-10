before ->
  chai.Assertion.addMethod 'collection', (type) ->
    new chai.Assertion(@_obj).to.be.instanceof(Backbone.Collection)

  chai.Assertion.addMethod 'model', (type) ->
    new chai.Assertion(@_obj).to.be.instanceof(Backbone.Model)

  chai.Assertion.addMethod 'view', (type) ->
    new chai.Assertion(@_obj).to.be.instanceof(Backbone.View)

  chai.Assertion.addMethod 'Singleton', (type) ->
    new chai.Assertion(@_obj).to.be.deep.equal require(type)
