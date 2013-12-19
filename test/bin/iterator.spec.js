// Generated by CoffeeScript 1.6.3
(function() {
  var __slice = [].slice;

  (function(root, factory) {
    var Iterator, List;
    if (typeof define === 'function' && define.amd) {
      return define(['../../bin/iterator', '../../bin/list'], factory);
    } else if (typeof exports === 'object') {
      Iterator = require('../../src/iterator.coffee');
      List = require('../../src/list.coffee');
      return module.exports = factory(Iterator, List);
    } else {
      Iterator = root.Mimosas.Iterator;
      List = root.Mimosas.List;
      return factory(Iterator, List);
    }
  })(this, function(Iterator, List) {
    return describe('Iterator', function() {
      var makeIterator;
      makeIterator = function() {
        var item, items, iterator, list, _i, _len;
        items = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        list = new List();
        iterator = new Iterator(list);
        for (_i = 0, _len = items.length; _i < _len; _i++) {
          item = items[_i];
          list.append({
            __POINTER__: item
          });
        }
        return {
          iterator: iterator,
          list: list
        };
      };
      it('should exist', function() {
        return expect(Iterator != null).to.be["true"];
      });
      it('should be done when list is empty', function() {
        var iterator, list, _ref;
        _ref = makeIterator(), iterator = _ref.iterator, list = _ref.list;
        return expect(iterator.isDone()).to.be["true"];
      });
      it('should throw when next is called on an empty list', function() {
        var iterator, list, throwMe, _ref;
        _ref = makeIterator(), iterator = _ref.iterator, list = _ref.list;
        iterator.next();
        throwMe = function() {
          return iterator.currentItem();
        };
        return expect(throwMe).to["throw"]();
      });
      it('should not be done when created with a list that has one item', function() {
        var iterator, list, _ref;
        _ref = makeIterator('foo'), iterator = _ref.iterator, list = _ref.list;
        return expect(iterator.isDone()).to.be["false"];
      });
      it('should be done after calling next on a list that has one item', function() {
        var iterator, list, _ref;
        _ref = makeIterator('foo'), iterator = _ref.iterator, list = _ref.list;
        iterator.next();
        return expect(iterator.isDone()).to.be["true"];
      });
      it('should get the correct item after calling next', function() {
        var item, iterator, list, _ref;
        _ref = makeIterator('foo', 'bar'), iterator = _ref.iterator, list = _ref.list;
        iterator.next();
        item = iterator.currentItem();
        return expect(item.__POINTER__).to.equal('bar');
      });
      it('should be done after removing all items from list', function() {
        var iterator, list, _ref;
        _ref = makeIterator('foo', 'bar'), iterator = _ref.iterator, list = _ref.list;
        list.removeAll();
        return expect(iterator.isDone()).to.be["true"];
      });
      it('should go back to the first item', function() {
        var item, iterator, list, _ref;
        _ref = makeIterator('foo', 'bar'), iterator = _ref.iterator, list = _ref.list;
        iterator.next().first();
        item = iterator.currentItem();
        return expect(item.__POINTER__).to.equal('foo');
      });
      return it('should throw when getting an item that is out of bounds', function() {
        var iterator, list, throwMe, _ref;
        _ref = makeIterator('foo'), iterator = _ref.iterator, list = _ref.list;
        iterator.next();
        iterator.next();
        throwMe = function() {
          return iterator.currentItem();
        };
        return expect(throwMe).to["throw"];
      });
    });
  });

}).call(this);