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
class SongModel extends Mimosas.Subject
class SongView extends Mimosas.Observer
```

If you're using plain JavaScript, that's cool. You have to do a little
more work though. Mimosas provides the extend method to help you out.
Basically, whenever there's talk about extending something use this
pattern with your constructor functions:

```javascript
var MyClass = (function(classToExtend) {
  Mimosas.extends(MyClass, classToExtend);
  function MyClass() {}
  // ..prototypes
})(ClassToExtend);
```

So our example above would look like:

```javascript
var SongModel = (function(classToExtend) {
  Mimosas.extends(SongModel, classToExtend);
  function SongModel() {}
  // ..prototypes
})(Mimosas.Subject);

var SongView = (function(classToExtend) {
  Mimosas.extends(SongView, classToExtend);
  function SongView() {}
  // ..prototypes
})(Mimosas.Observer);
```

API Reference
-------------

Mimosas exposes two objects: Observer and Subject. If you've used the variable
name `mimosas`, you can access these objects with `mimosas.Observer` and 
`mimosas.Subject`.
```coffeescript
  Mimosas = {}
```
### Mimosas.Observer
```coffeescript
  Mimosas.Observer = class Observer
     changed: (theChangedSubject) ->
```
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

### Mimosas.List
```coffeescript
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
     getByIndex: (index) ->
       throw new Error 'ArrayOutOfBoundsException' if index >= @count()
       throw new Error 'ArrayOutOfBoundsException' if index < 0
       @objects[@items[index]]

     # Returns the object with the given pointer
     get: (pointer) ->
       @objects[pointer]

     # Returns the first object in the list
     first: () ->
       @objects[@items[0]]

     # Returns the last object in the list
     last: () ->
       @objects[@items[@items.length - 1]]

     # Adds the argument to the list, making it the last item
     append: (item) ->
       throw new Error 'NullPointerException' unless item.__POINTER__?
       pointer = item.__POINTER__
       @items.push pointer
       @objects[pointer] = item

     # Removes the given element from the list.
     remove: (pointer) ->
       throw new Error 'ArgumentException' unless pointer?
       throw new Error 'ListItemUndefined' unless @objects[pointer]?

       index = -1
       for item, i in @items
         if item is pointer
           index = i
           break

       throw new Error 'ListItemUndefined' if index is -1

       delete @objects[pointer]
       @items.splice index, 1

     # Removes the last element from the list
     removeLast: () ->
       item = @last()
       @remove item.__POINTER__

     # Removes the first element from the list
     removeFirst: () ->
       item = @first()
       @remove item.__POINTER__

     # Removes all elements from the list
     removeAll: () ->
       @items = []
       @objects = {}
```
### Mimosas.Iterator
```coffeescript
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
```
### Mimosas.Aggregate
```coffeescript
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
```
### Mimosas.Subject

The Subject is what makes things tick. It keeps a running list of all
its Observers in a List and it can have as many Observers as needed.

You can attach Observers to the Subject via the `attach` method and if
you want to stop notifying an Observer you can simply pass the whole
Observer into the `detach` method.`

Whenever something important happens in your Subject, you'll want to 
call notify. That will call the `changed` method on all of the Observers
that are attached, letting each know that something has been changed.
```coffeescript
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
```
Your Concrete Subject just keeps track of whatever it thinks is
important in the Concrete Observer. You can create create on by
extending the Subject.

```coffeescript
class ConcreteSubject extends Mimosas.Subject
```

### Mimosas.extends
```coffeescript
  Mimosas['extends'] = `__extends`
```
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
```coffeescript
  ((root, factory) ->
     if typeof exports is 'object'
       module.exports = factory()
     else if typeof window.define is 'function' and window.define.amd
       window.define factory
     else
       root.Mimosas = factory()
   ) this, () ->
     Mimosas
```
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
