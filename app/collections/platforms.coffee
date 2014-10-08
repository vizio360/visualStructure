Platform = require "models/platform"

class Platforms extends Backbone.Collection
  url: "/api/resource/platforms"
  model: Platform

module.exports = new Platforms
