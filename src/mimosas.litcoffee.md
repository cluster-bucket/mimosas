Mimosas
=======

What is it?
-----------

Mimosas is my observer/subject application starter. 

Actually that's just a clever recursive acronym. Mimosas is mostly just a fun 
way to explore the [Observer pattern][observer] ([Gof][gof]).

Documentation
-------------

This project uses the [literate programming style][literate], so all the
documentation for it should be right here in the `src` directory. The whole 
thing can be read from top to bottom, as if you were reading a technical book.

Installation
------------

If you want to compile the propject you need to have [node][node] and [npm][npm]
installed. If you've got that taken care of, you can run `npm install` from this
directory to update all the required dependencies. 

To update a specific NPM package run `npm install <name> --save-dev`. This will
install the latest version of the package and update the `package.json` file with
the new version number.

Development
-----------

Several [Grunt][grunt] tasks are available on the command line. To run the tasks
execute `grunt [taskname]` from the terminal. `[taskname]` is an optional task 
to run. Here's a list of the important commands:

* `grunt`: Compile the project and examples
* `grunt server`: Compile the project, examples, and start a server

Contributors
------------

* [Dustin Boston][dblogit]

Usage
-----

The compiled `mimosas.js` file should be in `dist` directory in the root of the
project. It's got everything it needs to work. Just copy it into your `libs`
directory and you're good to go.

Mimosas defines a module that works in Node, AMD and browser globals, depending
on the environment. The [`returnExports` UMD pattern][umdjs] makes this work.
We don't have any dependencies, so this is the simplified version.

    ((root, factory) ->

If you're using node you can just `require` the file as you would any other. We
can determine if you're using node by checking for the presence of `exports`.

      if typeof exports is 'object'
        module.exports = factory()

If you're using AMD you can add Mimosas as dependeny to your module with the 
standard define, like this: 

`define(['libs/mimosas'], function (mimosas) {});`

To determine if you're using AMD we check for the define function on the window
object. We use `window.define` rather than `define` because the compiled version
gets wrapped within an anonymous function, so we don't have access to the global
scope through `this`.

      else if typeof window.define is 'function' and window.define.amd
        window.define factory

If you're not using node or AMD, `mimosas` will be available as a global.

      else
        root.mimosas = factory()

    ) this, () ->
      {Observer, Subject}



License
-------

Please see the [LICENSE](../LICENSE) file.

Changelog
---------


[literate]: http://en.wikipedia.org/wiki/Literate_programming
[observer]: http://en.wikipedia.org/wiki/Observer_pattern)
[gof]: http://en.wikipedia.org/wiki/Design_Patterns_(book)
[node]: http://nodejs.org/
[npm]: https://npmjs.org/
[grunt]: http://gruntjs.com/
[dblogit]: http://dblogit.com
[umdjs]: https://github.com/umdjs/umd