template = require 'templates/graph'
DrawingSystem = require 'lib/ces/systems/drawing'

class Graph extends Backbone.View

  framesPerSecond: 10

  render: ->
    @$el.html template
    @fabricCanvas = new fabric.StaticCanvas "fabricCanvas"
    @setupSystems()
    @el

  createDrawingSystem: ->
    drawing = new DrawingSystem
    drawing.setup @fabricCanvas
    drawing

  setupSystems: ->
    fabric.Object.prototype.originX = fabric.Object.prototype.originY = 'center'
    @systems ?= []
    @systems.push @createDrawingSystem()

  start: ->
    @stop() if @refresh?
    @refresh = setInterval =>
      @update()
    , 1000/@framesPerSecond

  stop: ->
    clearInterval @refresh if @refresh?
    @refresh = null

  update: ->
    for system in @systems
      system.execute()
    @fabricCanvas.renderAll()

module.exports = Graph
