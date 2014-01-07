Mimosas
=======

What is it?
-----------

*Mimosas implements MVC's original Smalltalk-80 architectural system.* At least
that's the goal. Mostly, Mimosas is a fun way to explore MVC's roots. As such,
it focuses on the spirit of the original Smalltalk-80 implementation. This is
an honest attempt to be truly MVC, not a modern variant. Mimosas can't be an
exact clone of Smalltalk MVC, but it should capture the spirit of it, and maybe
even make it more accessible.

Documentation
-------------

API documentation is included in HTML format in the docs/ directory. Things
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

Getting Started
---------------

You can use Mimosas in the browser with AMD and globals, or on the server using
Node. This is accomplished with the [returnExports UMD pattern][umdjs]. The
controller/view event handling needs to be refactored to work without the DOM
on the server side.

* *Node*: `var Mimosas = require('libs/mimosas');`
* *AMD*: `define(['libs/mimosas'], function (Mimosas) {});`
* *Globals*: `window.Mimosas`

Next, create your Models, Views, and Controllers by extending Mimosas core
classes. If you're using CoffeeScript it's very easy. For example:

```coffee
class Model extends Mimosas.ModelSubject
  # ..methods

class View extends Mimosas.ViewLeaf
  # ..methods

class Controller extends Mimosas.ControllerStrategy
  # ..methods
```

If you're using plain JavaScript you'll have to write a bit more code. Mimosas
provides the Class.extends method to help you out. Whenever there's talk about
"extending a class" use this pattern with your constructor functions:

```js
var MyClass = (function(classToExtend) {
  Mimosas.Class.extends(MyClass, classToExtend);
  function MyClass() {}
  // ..prototypes
})(ClassToExtend);
```

The example above would become:

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


[literate]: http://en.wikipedia.org/wiki/Literate_programming
[observer]: http://en.wikipedia.org/wiki/Observer_pattern
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
