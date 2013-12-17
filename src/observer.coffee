((root, factory) ->
  if typeof define is 'function' and define.amd
    define factory
  else if typeof exports is 'object'
    module.exports = factory()
  else
    root.Mimosas = {} unless root.Mimosas?
    root.Mimosas.Observer = factory()
) @, () ->
    class Observer
      changed: (theChangedSubject) ->