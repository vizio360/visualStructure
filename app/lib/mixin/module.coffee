moduleKeywords = ['extended', 'included']

class Module
  extend: (obj) ->
    for key, value of obj when key not in moduleKeywords
      @[key] = _.clone value

    obj.extended?.apply(@)
    this

module.exports = Module
