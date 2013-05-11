Mimosas
=======

What is it?
-----------

Mimosas is my observer/subject application starter


Documentation
-------------

The project aims to be as self-documenting as possible. To wit, it uses the
[literate programming style](http://en.wikipedia.org/wiki/Literate_programming)
throughout. The TLDR is that there is a great deal of documentation in each file
which can be read from top to bottom, as if you were reading a technical book.
A product of this approach is that a formal `docs/` isn't really necessary.

The app entry point is the [bootstrap](example/bootstrap.litcoffee) 
file. It's a great place to start and has pointers to the important stuff.

Installation
------------

This project uses [node.js](http://nodejs.org/) and [npm](https://npmjs.org/) to
build and compile the code, so you'll need to install those first. Once that's
taken care of you can run `npm install` from this directory to install all the
required dependencies.

Development
-----------

Several [Grunt](http://gruntjs.com/) tasks will be available on the command line 
once you have the required packages installed. To run the tasks execute `grunt` 
from the terminal with one of the following tasks (e.g. `grunt coffee`):

To update a specific NPM package run `npm install <name> --save-dev`. This will
install the latest version of the package and update the `package.json` file with
the new version number.

Contributors
------------

* Dustin Boston <dustin@dblogit.com>

License
-------

Please see the file called LICENSE.

Changelog
---------
