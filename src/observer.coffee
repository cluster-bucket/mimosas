((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['./guid'], factory
  else if typeof exports is 'object'
    Guid = require('./guid')
    module.exports = factory(Guid)
  else
    root.Mimosas = {} unless root.Mimosas?
    Guid = root.Mimosas.Guid
    root.Mimosas.Observer = factory(Guid)
) @, (Guid) ->
  
    class Observer
      constructor: () ->
        @__POINTER__ = Guid.generate()
      changed: (theChangedSubject) ->