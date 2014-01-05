class ControllerStrategy
  constructor: () ->
  setModel: (@model) ->
  getModel: () -> @model
  setView: (@view) ->
  getView: () -> @view

exports.ControllerStrategy = ControllerStrategy
