Mimosas
=======

What is it?
-----------

Mimosas is my observer/subject application starter. 

Actually that's just a clever recursive acronym. Mimosas is mostly just a fun 
way to explore the [Observer pattern][observer] ([Gof][gof]) using classical
inheritance and [CoffeeScript][cs].

Usage
-----

The compiled `mimosas.js` file is available in the `dist` directory at the root 
of the project. Just copy it into your `libs` directory and then check out the 
documentation to get started. You don't need to download or install any other
libraries, but you do need [CoffeeScript][cs]..

Documentation
-------------

This project uses the [literate programming style][literate], so all the
documentation for it is available in the `src` directory. It can be read from
top to bottom, as if you were reading a technical book. The best place to start
is [mimosas.coffee.md](src/mimosas.coffee.md).

Installation
------------

If you want to compile the project you need to have [node][node] and [npm][npm]
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
[main]: src/mimosas.coffee.md
[cs]: http://coffeescript.org