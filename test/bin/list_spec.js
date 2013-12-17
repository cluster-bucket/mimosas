(function() {
  var __slice = [].slice;

  (function(root, factory) {
    if (typeof define === 'function' && define.amd) {
      return define(['list'], factory);
    } else if (typeof exports === 'object') {
      return module.exports = factory(require('../../src/list.coffee'));
    } else {
      if (root.MimosasSpec == null) {
        root.MimosasSpec = {};
      }
      return root.MimosasSpec.List = factory(root.Mimosas.List);
    }
  })(this, function(List) {
    describe('List', function() {
      var appendTestItems, getTestItem, list;
      list = void 0;
      getTestItem = function(pointer) {
        return {
          __POINTER__: pointer,
          getType: function() {
            return pointer;
          }
        };
      };
      appendTestItems = function() {
        var item, pointer, pointers, _i, _len, _results;
        pointers = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        _results = [];
        for (_i = 0, _len = pointers.length; _i < _len; _i++) {
          pointer = pointers[_i];
          item = getTestItem(pointer);
          _results.push(list.append(item));
        }
        return _results;
      };
      beforeEach(function() {
        return list = new List();
      });
      afterEach(function() {
        return list = void 0;
      });
      it('should exist', function(test) {
        return expect(List).toBeDefined();
      });
      it('should have a zero count on init', function(test) {
        return expect(list.count()).toEqual(0);
      });
      it('should throw when appending an item without a pointer', function(test) {
        var throwMe;
        throwMe = function() {
          return list.append({});
        };
        return expect(throwMe).toThrow();
      });
      it('should append an item', function(test) {
        var item;
        item = getTestItem('foo');
        list.append(item);
        return expect(list.count()).toEqual(1);
      });
      it('should get an item by its index', function(test) {
        var item;
        appendTestItems('foo');
        item = list.getByIndex(0);
        return expect(item.__POINTER__).toBe('foo');
      });
      it('should throw when getting an item by an index that doesn\'t exist', function(test) {
        var throwMe;
        throwMe = function() {
          return list.getByIndex(0);
        };
        return expect(throwMe).toThrow();
      });
      it('should throw when getting an item by a negative index', function(test) {
        var throwMe;
        throwMe = function() {
          return list.getByIndex(-1);
        };
        return expect(throwMe).toThrow();
      });
      it('should get an item by its pointer', function(test) {
        var item;
        appendTestItems('foo', 'bar');
        item = list.get('bar');
        return expect(item.__POINTER__).toBe('bar');
      });
      it('should get the first item in the list', function(test) {
        var item;
        appendTestItems('foo', 'bar');
        item = list.first();
        return expect(item.__POINTER__).toBe('foo');
      });
      it('should get the last item in the list', function(test) {
        var item;
        appendTestItems('foo', 'bar');
        item = list.last();
        return expect(item.__POINTER__).toBe('bar');
      });
      it('should throw when removing an item that doesn\'t exist', function(test) {
        var throwMe;
        throwMe = function() {
          return list.remove('baz');
        };
        return expect(throwMe).toThrow();
      });
      it('should remove an item from the list', function(test) {
        appendTestItems('foo', 'bar');
        expect(list.count()).toEqual(2);
        list.remove('bar');
        return expect(list.count()).toEqual(1);
      });
      it('should remove the last item in the list', function(test) {
        var item;
        appendTestItems('foo', 'bar');
        expect(list.count()).toEqual(2);
        list.removeLast();
        expect(list.count()).toEqual(1);
        item = list.first();
        return expect(item.__POINTER__).toBe('foo');
      });
      it('should remove the first item in the list', function(test) {
        var item;
        appendTestItems('foo', 'bar');
        expect(list.count()).toEqual(2);
        list.removeFirst();
        expect(list.count()).toEqual(1);
        item = list.first();
        return expect(item.__POINTER__).toBe('bar');
      });
      return it('should remove all items from the list', function(test) {
        appendTestItems('foo', 'bar');
        expect(list.count()).toEqual(2);
        list.removeAll();
        return expect(list.count()).toEqual(0);
      });
    });
  });

}).call(this);
