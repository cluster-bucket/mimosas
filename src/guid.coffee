((root, factory) ->
  if typeof define is 'function' and define.amd
    define factory
    return
  else if typeof exports is 'object'
    module.exports = factory()
    return
  else
    root.Mimosas = {} unless root.Mimosas?
    root.Mimosas.Guid = factory()
    return
) @, () ->

  # * [How to create a GUID / UUID in Javascript?](http://stackoverflow.com/a/105074)
  # * [Generate GUID-like GUIDs w/ CoffeeScript](https://gist.github.com/matthewhudson/5760422)
  class Guid
    @generate: () ->
      S4 = () ->
        (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1)
      "#{S4()}#{S4()}-#{S4()}-#{S4()}-#{S4()}-#{S4()}#{S4()}#{S4()}"

  Guid
