((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['./guid'], factory
    return
  else if typeof exports is 'object'
    Guid = require('./guid')
    module.exports = factory(Guid)
    return
  else
    root.Mimosas = {} unless root.Mimosas?
    Guid = root.Mimosas.Guid
    root.Mimosas.ViewObserver = factory(Guid)
    return
) @, (Guid) ->
  
  class ViewObserver
    constructor: () ->
      @__POINTER__ = Guid.generate()

    changed: (theChangedSubject) ->
      
  ViewObserver