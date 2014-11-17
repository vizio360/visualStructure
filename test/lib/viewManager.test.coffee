describe "View Manager", ->

  ViewManager = require "lib/viewManager"
  viewManager = null

  class MyView extends Backbone.View
    id: "myView"
  class MyView2 extends Backbone.View
    id: "myView2"
  myView = null
  myView2 = null

  beforeEach ->
    viewManager = new ViewManager
    myView = new MyView
    myView2 = new MyView2

  it "can be instantiated", ->
    expect(viewManager).toBeDefined()
    expect(viewManager).toEqual(jasmine.any(ViewManager))

  it "can add a view to manage", ->
    el = $('<div id="root"/>')
    viewManager.setElement el
    viewManager.add myView
    expect(el.children('div .hidden').length).toBe(1)
    expect(myView.el).toBe(viewManager.views[myView.id][0])
    expect(myView.$el).toBe(viewManager.views[myView.id])

  it "can add multiple views to manage", ->
    el = $('<div id="root"/>')
    viewManager.setElement el
    viewManager.add myView
    viewManager.add myView2
    expect(el.children('div .hidden').length).toBe(2)

  it "can activate a view", ->
    el = $('<div id="root"/>')
    viewManager.setElement el
    viewManager.add myView
    viewManager.activate myView
    expect(el.children('div .hidden').length).toBe(0)
    expect(el.children('div:not(.hidden)').length).toBe(1)

  it "can activate one and only one view at the time when multiple views present", ->
    el = $('<div id="root"/>')
    viewManager.setElement el
    viewManager.add myView
    viewManager.add myView2
    viewManager.activate myView
    viewManager.activate myView2
    expect(el.children('div .hidden').length).toBe(1)
    expect(el.children('div:not(.hidden)').length).toBe(1)

  it "raises an exception if trying to add the same view more than one time", ->
    el = $('<div id="root"/>')
    viewManager.setElement el
    viewManager.add myView
    expect(-> viewManager.add(myView)).toThrow()

  it "raises an exception if trying to activate a view that's not been added", ->
    el = $('<div id="root"/>')
    viewManager.setElement el
    expect(-> viewManager.activate(myView)).toThrow()

  it "removes the view from the view manager", ->
    el = $('<div id="root"/>')
    viewManager.setElement el
    viewManager.add myView
    viewManager.activate myView
    viewManager.remove myView
    expect(el.children('div').length).toBe(0)

  it "raises an exception if trying to remove a view that was never added", ->
    el = $('<div id="root"/>')
    viewManager.setElement el
    expect(-> viewManager.remove(myView)).toThrow()

