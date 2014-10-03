Platform = require "models/platform"
Platforms = Backbone.Collection.extend
  url: "/api/resource/platforms" 
  model: Platform

module.exports = Platforms