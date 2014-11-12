describe "Drawing System", ->

  DrawingSystem = require "lib/ces/systems/drawing"
  EntityFactory = require("lib/ces/entityFactory").Singleton
  drawing = null
  canvas = null
  fabricCanvas = null

  beforeEach ->
    drawing = new DrawingSystem
    canvas = $('<canvas id="canvasTest"></canvas>')
    fabricCanvas = new fabric.StaticCanvas canvas.attr('id')
    $(document.body).append(canvas);

  afterEach ->
    EntityFactory.deleteAll()
    canvas.remove()

  it "can be instantiated", ->
    expect(drawing).toBeDefined()

  it "can be initialised with a canvas element", ->
    expect(-> drawing.setup fabricCanvas).not.toThrow()

  it "draws all the drawable items on canvas", ->
    for entity in fixturesEntities
      e = EntityFactory.createEntity(entity.id)
      e.addComponent entity.components
    drawing.setup fabricCanvas
    spyOn(drawing, "createItem").and.callThrough()
    drawing.execute()
    expect(drawing.createItem.calls.count()).toBe 2

  it "draws all the connections between items on canvas", ->
    for entity in fixturesEntities
      e = EntityFactory.createEntity(entity.id)
      e.addComponent entity.components
    drawing.setup fabricCanvas
    spyOn(drawing, "createConnection").and.callThrough()
    drawing.execute()
    expect(drawing.createConnection.calls.count()).toBe 1

  it "adds item to the canvas only once when created", ->
    for entity in fixturesEntities
      e = EntityFactory.createEntity(entity.id)
      e.addComponent entity.components
    drawing.setup fabricCanvas
    spyOn(fabricCanvas, "add").and.callThrough()
    drawing.execute()
    drawing.execute()
    expect(fabricCanvas.add.calls.count()).toBe fixturesEntities.length


