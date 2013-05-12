Getting started
===============

You can use Mimosas in Node, AMD and with browser globals, depending on your 
environment. This is accomplished with the [returnExports UMD pattern][umdjs]. 
There aren't any dependencies, so this is the simplified version.

    ((root, factory) ->

If you're using node you can just `require` the file as you would any other, 
e.g. `var mimosas = require('libs/mimosas');`. Mimosas determines if you're using
node by checking for the presence of `exports`.

      if typeof exports is 'object'
        module.exports = factory()

If you're using AMD you can add Mimosas as a dependeny to your module with the 
standard define: `define(['libs/mimosas'], function (mimosas) {});`.

To determine if you're using AMD, Mimosas checks the define function on the 
window object. The window object must be used because the compiled version of
Mimosas gets wrapped with an anonymous function, which prevents the script from
accessing the global scope through `this`.

      else if typeof window.define is 'function' and window.define.amd
        window.define factory

If you're not using node or AMD, `mimosas` will be available as a global.

      else
        root.mimosas = factory()

    ) this, () ->

API
---

Mimosas exposes two objects: Observer and Subject. If you've used the variable
name `mimosas`, you can access these objects with `mimosas.Observer` and 
`mimosas.Subject`.

      {Observer, Subject}

### mimosas.Observer

    class Observer
      changed: (theChangedSubject) ->

The Observer is pretty lame honestly. It's an abstract class that's just here
to make sure that *your* observers have the `changed` method. Without that
method, nothing would work. Boo.

Your class is a "Concrete Observer" and you make it by extending the Observer 
object, like this: `class SongList extends mimosas.Observer`.

Whenever the `changed` method is called, the Subject that was changed will be
passed in as a parameter. You'll need to use the changed subject to find out 
what happened so that you can sync up your Observer with the new "state" of the 
Subject. 

### mimosas.Subject



[umdjs]: https://github.com/umdjs/umd
