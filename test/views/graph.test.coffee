describe "Graph View", ->

  graphClass = require "views/graph"
  graph = null

  beforeEach ->
    jasmine.clock().install()
    jasmine.addMatchers(customMatchers)
    graph = new graphClass
      el: $('<div/>')

  afterEach ->
    jasmine.clock().uninstall()
    graph.stop()

  it "can be instantiated", ->
    expect(graph).toBeDefined()

  it "is a View", ->
    expect(graph).toBeAView()

  it "has a canvas element", ->
    graph.render()
    expect(graph).toContainHtmlElement("canvas")

  it "calls the update method every frame once started", ->
    spyOn(graph, "update").and.callThrough()
    graph.render()
    graph.start()
    jasmine.clock().tick 20 * 1000 + 1
    expect(graph.update.calls.count()).toBe 20*graph.framesPerSecond

  it "doesn't call the update method once stopped", ->
    graph.render()
    graph.start()
    jasmine.clock().tick 20 * 1000 + 1
    spyOn(graph, "update").and.callThrough()
    graph.stop()
    jasmine.clock().tick 20 * 1000 + 1
    expect(graph.update.calls.count()).toBe 0

  it "updates all canvas objects when updating", ->
    graph.render()
    spyOn(graph.fabricCanvas, "renderAll").and.callThrough()
    graph.start()
    jasmine.clock().tick 1000/graph.framesPerSecond+1
    expect(graph.fabricCanvas.renderAll.calls.count()).toBe 1

  it "calls the execute method on all registered systems", ->
    spyOn(graph, "setupSystems").and.callThrough()
    graph.render()
    expect(graph.setupSystems).toHaveBeenCalled()
    for system in graph.systems
      spyOn(system, "execute").and.callThrough()
    graph.start()
    jasmine.clock().tick 1000/graph.framesPerSecond+1
    for system in graph.systems
      expect(system.execute).toHaveBeenCalled()

  it "stops before starting again if start is called multiple times", ->
    spyOn(graph, "stop").and.callThrough()
    graph.render()
    graph.start()
    expect(graph.stop).not.toHaveBeenCalled()
    graph.start()
    expect(graph.stop).toHaveBeenCalled()

