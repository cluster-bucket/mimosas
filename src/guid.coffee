# * [How to create a GUID / UUID in Javascript?](http://stackoverflow.com/a/105074)
# * [Generate GUID-like GUIDs w/ CoffeeScript](https://gist.github.com/matthewhudson/5760422)
class Guid
  @generate: () ->
    S4 = () ->
      (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1)
    "#{S4()}#{S4()}-#{S4()}-#{S4()}-#{S4()}-#{S4()}#{S4()}#{S4()}"

exports.Guid = Guid
