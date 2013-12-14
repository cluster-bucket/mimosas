Mimosas
=======

What is it?
-----------

Mimosas is my observer/subject application starter. 

Actually that's just a clever recursive acronym. Mimosas is mostly just
a fun way to explore the [Observer pattern][observer] ([Gof][gof]) 
using classical inheritance and [CoffeeScript][cs]. I use this
collection of patterns, in this way, almost every day.

Documentation
-------------

This project uses the [literate programming style][literate], so all the
documentation is available in the source file (`mimosas.litcoffee`) or
here (README.md), which is an exact copy of the source file. It should 
be read from top to bottom, as if you were reading a technical book.

Usage/Getting Started
---------------------


### Using Mimosas without CoffeeScript

The compiled `mimosas.js` file is available in root directory of the 
project. I understand that not everybody digs the CoffeeScript thing so
Mimosas provides the extend method documented below. Basically, 
whenever there's talk about extending something use this pattern with
your constructor functions:

```javascript
var MyClass = (function(classToExtend) {
  Mimosas.extends(MyClass, classToExtend);
  function MyClass() {}
  // ..prototypes
})(ClassToExtend);
```

API Reference
-------------

Mimosas exposes two objects: Observer and Subject. If you've used the variable
name `mimosas`, you can access these objects with `mimosas.Observer` and 
`mimosas.Subject`.

    Mimosas = {}

    it = {}
    it['Mimosas should exist'] = (test) ->
      test.equal Mimosas?, true
      test.done()

### Mimosas.Observer

    Mimosas.Observer = class Observer
      changed: (theChangedSubject) ->

The Observer is an abstract class that's just here to make sure that
your Concrete Observers have the `changed` method. Whenever it changes, 
its `changed` method gets called and the Subject that was changed will 
be passed in as a parameter. You'll need to use the changed subject to 
find out what happened so that you can sync up your Observer with the 
new "state" of the Subject. You make Concrete Observers by extending 
the Observer like this:

```
class ConcreteObserver extends Mimosas.Observer
  update: (theChangedSubject) ->
    console.log "Updated"
```

    it['Mimosas.Observer should exist'] = (test) ->
      test.equal Mimosas.Observer?, true
      test.done()

    it['Mimosas.Observer should have a changed event'] = (test) ->
      observer = new Mimosas.Observer()
      test.equal observer.changed?, true
      test.done()

### Mimosas.List

    Mimosas.List = class List
      constructor: () ->
        # A list of pointers
        @items = []
        # Objects passed in by pointer
        @objects = {}

      # Returns the number of objects in the list
      count: () ->
        @items.length

      # Returns the object at the given length
      get: (index) ->
        @objects[@items[index]]

      # Returns the first object in the list
      first: () ->
        @objects[@items[0]]

      # Returns the last object in the list
      last: () ->
        @objects[@items[@items.length - 1]]

      # Adds the argument to the list, making it the last item
      append: (item) ->
        pointer = item.__POINTER__
        @items.push pointer
        @objects[pointer] = item

      # Removes the given element from the list.
      remove: (item) ->
        pointer = item.__POINTER__
        delete @objects[pointer]
        index = pointer in @items
        @items.splice index, 1

      # Removes the last element from the list
      removeLast: () ->
        @remove @last

      # Removes the first element from the list
      removeFirst: () ->
        @remove @first

      # Removes all elements from the list
      removeAll: () ->
        @items = []
        @objects = {}

    it['Mimosas.List should exist'] = (test) ->
      test.equal Mimosas.List?, true
      test.done()

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
    Mimosas.Iterator = class ConcreteIterator extends Iterator
      constructor: (@list) ->
        @current = 0
      first: () ->
        @current = 0
      next: () ->
        @current += 1
      isDone: () ->
        @current >= @list.count()
      currentItem: () ->
        throw new Error "IteratorOutOfBounds" if @isDone()
        @list.get @current

    it['Mimosas.Iterator should exist'] = (test) ->
      test.equal Mimosas.Iterator?, true
      test.done()

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

    it['Mimosas.Aggregate should exist'] = (test) ->
      test.equal Mimosas.Aggregate?, true
      test.done()

### Mimosas.Subject

The Subject is what makes things tick. It keeps a running list of all
its Observers in a List and it can have as many Observers as needed.

You can attach Observers to the Subject via the `attach` method and if
you want to stop notifying an Observer you can simply pass the whole
Observer into the `detach` method.`

Whenever something important happens in your Subject, you'll want to 
call notify. That will call the `changed` method on all of the Observers
that are attached, letting each know that something has been changed.

    Mimosas.Subject = class Subject

      counter = 0
      observers = new Mimosas.List()

      attach: (obj) ->
        obj.__POINTER__ = @counter
        observers.append obj
        counter += 1

      detach: (observer) ->
        observers.remove observer

      notify: () ->
        i = new Mimosas.Iterator observers
        while not i.isDone()
          i.currentItem().changed @
          i.next()

    it['Mimosas.Subject should exist'] = (test) ->
      test.equal Mimosas.Subject?, true
      test.done()

Your Concrete Subject just keeps track of whatever it thinks is
important in the Concrete Observer. You can create create on by
extending the Subject.

```coffeescript
class ConcreteSubject extends Mimosas.Subject
```

### Mimosas.extends

    Mimosas['extends'] = `__extends`

    it['Mimosas.extends should exist'] = (test) ->
      test.equal Mimosas.extends?, true
      test.done()

Including Mimosas in your project
---------------------------------

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
        if process?.argv?[2] is 'test'
          module.exports = it
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

Several [Grunt][grunt] tasks are available on the command line. To run 
the tasks execute `grunt [taskname]` from the terminal. `[taskname]` 
is an optional task to run. Here's a list of the important commands:

* `grunt`: Compile the project and examples
* `grunt server`: Compile the project, examples, and start a server

Contributors
------------

* [Dustin Boston][dblogit]

License
-------

Please see the [LICENSE](../LICENSE) file.

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
