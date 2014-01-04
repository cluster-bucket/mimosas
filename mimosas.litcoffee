Mimosas
=======

What is it?
-----------

Mimosas is my observer/subject application starter. AKA TrueMVC (TM).

Actually that's just a clever recursive acronym. Mimosas is mostly just
a fun way to explore the [Observer pattern][observer] ([Gof][gof])
using classical inheritance (which I enjoy) and [CoffeeScript][cs]. I
use this collection of patterns, in this way, almost every day.
Especially with MVC, wherein I do believe that it is The One True MVC,
so help me god, forever and ever amen (Corrections welcome). ;-)

Documentation
-------------

This project uses the [literate programming style][literate], so all the
documentation is available in the source file (`mimosas.litcoffee`) or
here (README.md), which is an exact copy of the source file. It should
be read from top to bottom, front to back, as if you were reading a The 
Book of Armaments, especially chapter two, verses nine through twenty-one.

Overview
--------

As was previously foretold, I use Mimosas as the Model/Collection/View
layer in a few of the applications I work on regularly. The Models and
Collections are Subjects and the Views are Observers. Whenever a Model
or Collection gets modified it notifies all the views and they all
update accordingly. Hooray. There are lots of other uses for this
pattern, but alas, I shall leave that as an exercise of the readers'
depraved imagination.

I also get a lot of mileage out of the Iterator and Aggregator. I know
the Iterator is a little old-school but it's nice to use and it's drop
dead simple. The Aggregator is just a simple way to parse objects into
an Iterator with the correct format.

Lastly, the List is invaluable. It's probably not that efficient, there
are probably many better ways to do it. However, it's incredibly easy
to understand and maintain and so I keep using it. Maybe now that it's
documented and tested I'll start tweaking to make it nice and fast.

Usage/Getting Started
---------------------

First off, you'll want to get Mimosas into your project somehow. The
compiled `mimosas.js` file is available in root directory. You'll want
to get it and copy it somewhere in your project. Let's say you put it
in your `libs` directory (it's not a Bower component yet).

Now you can `require` it in Node or use RequireJS in the browser.
If you don't have either of those, it's availble as `window.Mimosas`.
See the [Including Mimosas](#including-mimosas) section for more detail.

Next, you'll want to extend `Mimosas.Observer` and `Mimosas.Subject`
objects to your hearts content. If you're using CoffeeScript it's very
easy. For example:

```coffeescript
class SongModel extends Mimosas.ModelSubject
class NewSongView extends Mimosas.ViewLeaf
```

If you're using plain JavaScript, that's cool. You have to do a little
more work though. Mimosas provides the extend method to help you out.
Basically, whenever there's talk about extending something use this
pattern with your constructor functions:

```javascript
var MyClass = (function(classToExtend) {
  Mimosas.Util.Extends(MyClass, classToExtend);
  function MyClass() {}
  // ..prototypes
})(ClassToExtend);
```

So our example above would look like:

```javascript
var SongModel = (function(classToExtend) {
  Mimosas.Util.Extends(SongModel, classToExtend);
  function SongModel() {}
  // ..prototypes
})(Mimosas.ModelSubject);

var SongView = (function(classToExtend) {
  Mimosas.Util.Extends(NewSongView, classToExtend);
  function SongView() {}
  // ..prototypes
})(Mimosas.ViewLeaf);
```

API Reference
-------------

Mimosas exposes four main classes:

* ModelSubject
* ViewComposite
* ViewLeaf
* ControllerStrategy

Additionaly, there are a number of utilities:

* Util.Guid
* Util.Extends

### Architecture

![UML Diagram](http://www.yuml.me/2294b967)

Something about architecture should go here.

    Mimosas = {}

### Mimosas.List

    Mimosas.List = class List
      constructor: () ->
        @pointers = []
        @items = {}

      count: () ->
        @pointers.length

      get: (pointer) ->
        @items[pointer]

      getByIndex: (index) ->
        throw new Error 'ArrayOutOfBoundsException' if index >= @count()
        throw new Error 'ArrayOutOfBoundsException' if index < 0
        @items[@pointers[index]]

      first: () ->
        @items[@pointers[0]]

      last: () ->
        @items[@pointers[@pointers.length - 1]]

      append: (item) ->
        throw new Error 'NullPointerException' unless item.__POINTER__?
        pointer = item.__POINTER__
        @pointers.push pointer
        @items[pointer] = item

      remove: (pointer) ->
        throw new Error 'ArgumentException' unless pointer?
        throw new Error 'ListItemUndefined' unless @items[pointer]?

        index = -1
        for item, i in @pointers
          if item is pointer
            index = i
            break

        throw new Error 'ListItemUndefined' if index is -1

        delete @items[pointer]
        @pointers.splice index, 1

      removeLast: () ->
        item = @last()
        @remove item.__POINTER__

      removeFirst: () ->
        item = @first()
        @remove item.__POINTER__

      removeAll: () ->
        @pointers = []
        @items = {}

### Mimosas.Iterator

    # Defines an interface for accessing/traversing elements.
    class Iterator
      first: () ->
      next: () ->
      isDone: () ->
      currentItem: () ->

    # * Implements the Iterator interface
    # * Keeps track of the current position in the traversal
    #   of the aggregate
    Mimosas.Iterator = class Iterator
      constructor: (@list) ->
        @current = 0
      first: () ->
        @current = 0
        @
      next: () ->
        @current += 1
        @
      isDone: () ->
        @current >= @list.count()
      currentItem: () ->
        throw new Error "IteratorOutOfBounds" if @isDone()
        @list.getByIndex @current

### Mimosas.ModelSubject

The Subject is what makes things tick. It keeps a running list of all
its Observers in a List and it can have as many Observers as needed.

You can attach Observers to the Subject via the `attach` method and if
you want to stop notifying an Observer you can simply pass the whole
Observer into the `detach` method.`

Whenever something important happens in your Subject, you'll want to 
call notify. That will call the `changed` method on all of the Observers
that are attached, letting each know that something has been changed.

    Mimosas.ModelSubject = class ModelSubject

      constructor: () ->
        @observers = new List()

      attach: (obj) ->
        @observers.append obj

      detach: (observer) ->
        @observers.remove observer

      notify: () ->
        i = new Iterator @observers
        while not i.isDone()
          i.currentItem().changed @
          i.next()

Your Concrete Subject just keeps track of whatever it thinks is
important in the Concrete Observer. You can create create on by
extending the Subject.

```coffeescript
class ConcreteSubject extends Mimosas.Subject
```

### Mimosas.ControllerContext

    Mimosas.ControllerContext = class ControllerContext

      constructor: (@strategy) ->
        throw new Error 'ArgumentException' unless @strategy?

      trigger: (method, e) ->
        if @strategy[method]?
          @strategy[method].call @strategy, e

      setModel: (model) ->
        @strategy.setModel model

      getModel: () ->
        @strategy.getModel()

      setView: (@view) ->
        @strategy.setView @view

### Mimosas.ControllerStrategy

    Mimosas.ControllerStrategy = class ControllerStrategy
      constructor: () ->
      setModel: (@model) ->
      getModel: () -> @model
      setView: (@view) ->
      getView: () -> @view

### Mimosas.ViewObserver

The Observer is an abstract class that's just here to make sure that
your Concrete Observers have the `changed` method. Whenever it changes, 
its `changed` method gets called and the Subject that was changed will 
be passed in as a parameter. You'll need to use the changed subject to 
find out what happened so that you can sync up your Observer with the 
new "state" of the Subject. You make Concrete Observers by extending 
the Observer like this:

```coffeescript
class ConcreteObserver extends Mimosas.Observer
  update: (theChangedSubject) ->
    console.log "Updated"
```

    Mimosas.ViewObserver = class ViewObserver
      constructor: () ->
        @__POINTER__ = Guid.generate()

      changed: (theChangedSubject) ->

### Mimosas.ViewComponent

    Mimosas.ViewComponent = class ViewComponent extends ViewObserver
      constructor: (selector) ->
        super
        throw new ReferenceError 'selector' unless selector
        @element = @getElementFromSelector selector
        throw new ReferenceError '@element' unless @element
        @controller = new ControllerContext new ControllerStrategy()

      # Opt for simplicity over efficiency and compatibility
      getElementFromSelector: (selector) ->
        # After the element is set all calls will be scoped to it
        scope = @element or document
        nodes = scope.querySelectorAll selector
        return nodes[0] if nodes.length > 0
        return

      setModel: (@model) ->
        @model.attach @
        @controller.setModel @model

      getModel: () ->
        @model

      setController: (controller) ->
        @controller = new ControllerContext controller
        @controller.setView @
        @controller.setModel(@model) if @model?

      addEvent: (type, selector, method) ->
        handler = @triggerEvent.bind @, method, selector
        @element.addEventListener type, handler, false

      triggerEvent: (method, selector, e) ->
        return unless @elementMatchesSelector e.target, selector
        @controller.trigger method, e

      closest: (element, selector) ->
        return element if element is @element
        return element if @elementMatchesSelector element, selector
        parent = element.parentNode
        @closest parent, selector

      elementMatchesSelector: (element, selector) ->
        matches = false
        for prefix in ['webkit', 'moz', 'ms']
          name = "#{prefix}MatchesSelector"
          continue unless element[name]
          matches = element[name] selector
          break
        matches

      getElement: () ->
        @element

      display: () ->

### Mimosas.ViewComposite

    Mimosas.ViewComposite = class ViewComposite extends ViewComponent
      constructor: () ->
        super
        @list = new List()

      add: (component) ->
        @list.append component

      remove: (pointer) ->
        @list.remove pointer

### Mimosas.ViewLeaf

    Mimosas.ViewLeaf = class ViewLeaf extends ViewComponent

### Mimosas.Aggregate

    # Defines an interface for creating an Iterator object
    class Aggregate
      createIterator: () ->

    # Implements the Iterator creation interface to return an
    # instance of the proper ConcreteIterator
    Mimosas.Aggregate = class ConcreteAggregate extends Aggregate
      createIterator: (items) ->
        list = new List()
        for key, val of items
          val.__POINTER__ = key
          list.append val
        new Mimosas.Iterator list

### Mimosas.Util

    Mimosas.Util = {}

### Mimosas.Util.Guid

* [How to create a GUID / UUID in Javascript?](http://stackoverflow.com/a/105074)
* [Generate GUID-like GUIDs w/ CoffeeScript](https://gist.github.com/matthewhudson/5760422)

    Mimosas.Util.Guid = class Guid
      @generate: () ->
        S4 = () ->
          (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1)
        "#{S4()}#{S4()}-#{S4()}-#{S4()}-#{S4()}-#{S4()}#{S4()}#{S4()}"

### Mimosas.extends

    Mimosas.Util.Extends = `__extends`

Including Mimosas
-----------------

You can use Mimosas in Node, AMD and with browser globals, depending on your 
environment. This is accomplished with the [returnExports UMD pattern][umdjs]. 
There aren't any dependencies, so this is the simplified version.

If you're using node you can just `require` the file as you would any other, 
e.g. `var mimosas = require('libs/mimosas');`. Mimosas determines if you're using
node by checking for the presence of `exports`.

If you're using AMD you can add Mimosas as a dependeny to your module with the 
standard define: `define(['libs/mimosas'], function (mimosas) {});`.

To determine if you're using AMD, Mimosas checks the define function on the 
window object. The window object must be used because the compiled version of
Mimosas gets wrapped with an anonymous function, which prevents the script from
accessing the global scope through `this`.

If you're not using node or AMD, `Mimosas` will be available as a global.

    ((root, factory) ->
      if typeof exports is 'object'
        module.exports = factory()
      else if typeof window.define is 'function' and window.define.amd
        window.define factory
      else
        root.Mimosas = factory()
    ) this, () ->
      Mimosas

Installation
------------

If you want to compile the project you need to have [node][node] and 
[npm][npm] installed. If you've got that taken care of, you can run 
`npm install` from this directory to update all the required 
dependencies. 

To update a specific NPM package run `npm install <name> --save-dev`. 
This will install the latest version of the package and update the 
`package.json` file with the new version number.

Development
-----------

Several CoffeeScript (cake) tasks are available on the command line. 
To run the tasks execute `cake [taskname]` from the terminal.
Here's a list of the important commands:

* `cake build`: Compile the project and start a watch (also `npm start`)
* `cake readme`: Copy the project to the README in a GitHub-friendly way
* `cake test`: Run the unit tests (also `npm test`)

Contributors
------------

* [Dustin Boston][dblogit]

License
-------

Please see the LICENSE file in the root of the project.

[literate]: http://en.wikipedia.org/wiki/Literate_programming
[observer]: http://en.wikipedia.org/wiki/Observer_pattern)
[gof]: http://en.wikipedia.org/wiki/Design_Patterns_(book)
[node]: http://nodejs.org/
[npm]: https://npmjs.org/
[grunt]: http://gruntjs.com/
[dblogit]: http://dblogit.com
[docco]: http://jashkenas.github.io/docco/
[main]: src/mimosas.coffee.md
[cs]: http://coffeescript.org
[umdjs]: https://github.com/umdjs/umd
