Mimosas
=======

What is it?
-----------

Mimosas implements MVC's original Smalltalk-80 architectural system. It is an
honest attempt to disconnect from all the fancy modern development paradigms and
reconnect with the basics of MVC. The aim is not to be a clone of Smalltalk MVC,
but to capture its spirit, build upon its foundations, and possibly make 
something useful in the process.

Documentation
-------------

Documentation is included in HTML format in the docs/ directory. Things
should do exactly what they say they will do and nothing more. In other words,
the documentation should be just as [DRY][dry] as the code, so there isn't a
lot of elaboration unless it is clearly necessary.

Installation
------------

Mimosas doesn't have any dependencies. The only file that is required for use
in your project is `mimosas.js`. There are two options for obtaining this file:

* [Download it directly][download]
* Clone the repository

Once you have the file, copy it into your project, then check out the Getting
Started section.

Overview
--------

As in Smalltalk, Mimosas divides an application into three parts, the model, 
view, and controller.

* Models use the [Observer pattern][observer] to notify views that data has changed
* Views use the [Composite pattern][composite] to create a heirarchy of UI elements
* Controllers use the [Strategy pattern][strategy] to handle events from views

In Smalltalk-80 views were always heirarchies, with one single "top view", and 
many child views. A single view could represent both single items, such as a 
checkbox, or more complex components, such as a list of selectable items.

In Mimosas, the top view and other views which can have children implement the 
ViewComposite class, which is the Composite in the Composite pattern. Views that
do not have children implement the ViewLeaf class, which is the Leaf in the 
Composite pattern. Both classes inherit from the ViewComponent (Component),
which in turn inherits from the ViewObserver (Observer).

Views and controllers are tightly coupled. They both maintain a reference to the
other. Mimosas minimizes this coupling by forcing views to communicate with
their respective controllers through the ControllerContext class, which is the 
Context part of the Strategy pattern and can be viewed as a sort of Facade in 
this scenario. This communication happens transparently.

Lastly, models can be strings, a single object, or a collection of objects.
Smalltalk didn't really care, as long as they inherited from a base object. In
Mimosas that object is the ModelSubject.

Getting Started
---------------

You can use Mimosas in the browser with AMD and globals, or on the server using
Node. This is accomplished with the [returnExports UMD pattern][umdjs]. The
controller/view event handling needs to be refactored to work without the DOM
on the server side.

```js
// Node
var Mimosas = require('libs/mimosas');

// Browser AMD
define(['libs/mimosas'], function (Mimosas) {});

// Browser Globals
window.Mimosas;
```

Next, create your Models, Views, and Controllers by extending Mimosas core
classes. If you're using plain JavaScript you'll need to manage inheritance using
the `Mimosas.Class.extends` method. Whenever there's talk about "extending a
class" use this pattern with your constructor functions:

```js
var MyClass = (function(classToExtend) {
  Mimosas.Class.extends(MyClass, classToExtend);
  function MyClass() {}
  // ..prototypes
})(ClassToExtend);
```

Here's a basic example:

```js
var Model = (function(classToExtend) {
  Mimosas.Class.extends(Model, classToExtend);
  function Model() {}
  // ..methods
})(Mimosas.ModelSubject);

var View = (function(classToExtend) {
  Mimosas.Class.extends(NewSongView, classToExtend);
  function View() {}
  // ..prototypes
})(Mimosas.ViewLeaf);

var Controller = (function(classToExtend) {
  Mimosas.Class.extends(NewSongController, classToExtend);
  function Controller() {}
  // ..prototypes
})(Mimosas.ControllerStrategy);
```

If you're using CoffeeScript it's a little easier. For example:

```coffee
class Model extends Mimosas.ModelSubject
  # ..methods

class View extends Mimosas.ViewLeaf
  # ..methods

class Controller extends Mimosas.ControllerStrategy
  # ..methods
```

Versioning
----------

Mimosas is maintained under the [Semantic Versioning guidelines][semver].
Releases will be numbered with the following format:

> Given a version number MAJOR.MINOR.PATCH, increment the:
>
> 1. MAJOR version when you make incompatible API changes,
> 2. MINOR version when you add functionality in a backwards-compatible manner, and
> 3. PATCH version when you make backwards-compatible bug fixes.

Development
-----------

If you want to work on Mimosas you need to have [node][node] and [npm][npm]
installed. Once you have got that taken care of, run `npm install` to update
all the required dependencies.

To update a specific NPM package run `npm install <name> --save-dev`.
This will install the latest version of the package and update the
`package.json` file with the new version number.

Once the node modules are installed run `bower install` in the root directory
to get the project-specific components. Each of the examples have their own
components, which should be installed the same way, as needed.

* Run `npm start` to build the project
* Run `npm test` to run the unit tests

Contributors
------------

* [Dustin Boston][dblogit]

License
-------

Mimosas is free software. See the LICENSE file for more information.


[observer]: http://en.wikipedia.org/wiki/Observer_pattern
[stragegy]: http://en.wikipedia.org/wiki/Strategy_pattern
[composite]: http://en.wikipedia.org/wiki/Composite_pattern
[gof]: http://en.wikipedia.org/wiki/Design_Patterns_%28book%29
[node]: http://nodejs.org/
[npm]: https://npmjs.org/
[grunt]: http://gruntjs.com/
[dblogit]: http://dblogit.com
[docco]: http://jashkenas.github.io/docco/
[main]: src/mimosas.coffee.md
[cs]: http://coffeescript.org
[umdjs]: https://github.com/umdjs/umd
[dry]: https://en.wikipedia.org/wiki/Don%27t_repeat_yourself
[download]: https://raw.github.com/dustinboston/mimosas/master/mimosas.js
[semver]: http://semver.org/
