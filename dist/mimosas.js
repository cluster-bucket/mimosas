(function() {
  var ConcreteIterator, Iterator, List, Observer, Subject,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  List = (function() {
    function List() {
      this.items = [];
      this.objects = {};
    }

    List.prototype.count = function() {
      return this.items.length;
    };

    List.prototype.get = function(index) {
      return this.objects[this.items[index]];
    };

    List.prototype.first = function() {
      return this.objects[this.items[0]];
    };

    List.prototype.last = function() {
      return this.objects[this.items[this.items.length - 1]];
    };

    List.prototype.append = function(item) {
      var pointer;

      pointer = item.__POINTER__;
      this.items.push(pointer);
      return this.objects[pointer] = item;
    };

    List.prototype.remove = function(item) {
      var index, pointer;

      pointer = item.__POINTER__;
      delete this.objects[pointer];
      index = __indexOf.call(this.items, pointer) >= 0;
      return this.items.splice(index, 1);
    };

    List.prototype.removeLast = function() {
      return this.remove(this.last);
    };

    List.prototype.removeFirst = function() {
      return this.remove(this.first);
    };

    List.prototype.removeAll = function() {
      this.items = [];
      return this.objects = {};
    };

    return List;

  })();

  Iterator = (function() {
    function Iterator() {}

    Iterator.prototype.first = function() {};

    Iterator.prototype.next = function() {};

    Iterator.prototype.isDone = function() {};

    Iterator.prototype.currentItem = function() {};

    return Iterator;

  })();

  ConcreteIterator = (function(_super) {
    __extends(ConcreteIterator, _super);

    function ConcreteIterator(list) {
      this.list = list;
      this.current = 0;
    }

    ConcreteIterator.prototype.first = function() {
      return this.current = 0;
    };

    ConcreteIterator.prototype.next = function() {
      return this.current += 1;
    };

    ConcreteIterator.prototype.isDone = function() {
      return this.current >= this.list.count();
    };

    ConcreteIterator.prototype.currentItem = function() {
      if (this.isDone()) {
        throw new Error("IteratorOutOfBounds");
      }
      return this.list.get(this.current);
    };

    return ConcreteIterator;

  })(Iterator);

  Subject = (function() {
    function Subject() {
      this.counter = 0;
      this.observers = new List();
    }

    Subject.prototype.attach = function(o) {
      o.__POINTER__ = this.counter;
      this.observers.append(o);
      return this.counter += 1;
    };

    Subject.prototype.detach = function(o) {
      return this.observers.remove(o);
    };

    Subject.prototype.notify = function() {
      var i, _results;

      i = new ConcreteIterator(this.observers);
      _results = [];
      while (!i.isDone()) {
        i.currentItem().changed(this);
        _results.push(i.next());
      }
      return _results;
    };

    return Subject;

  })();

  Observer = (function() {
    function Observer() {}

    Observer.prototype.changed = function(theChangedSubject) {};

    return Observer;

  })();

  define([], function() {
    return {
      Subject: Subject,
      Observer: Observer
    };
  });

}).call(this);
