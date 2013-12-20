((root, factory) ->
  if typeof define is 'function' and define.amd
    define ['../../bin/subject'], factory
  else if typeof exports is 'object'
    List = require '../../src/subject.coffee'
    module.exports = factory List
  else
    Subject = root.Mimosas.Subject
    factory Subject
) @, (Subject) ->

  describe 'Subject', ->
    
    subject = undefined
    
    beforeEach ->
      subject = new Subject()
    
    afterEach ->
      subject = undefined
      
    mockObserver = (pointer, callback) ->
      __POINTER__: pointer, changed: callback or ->
      
    it 'should exist', ->
      expect(Subject).to.exist
      
    it 'should attach an item', ->
      expect(subject.observers.count()).to.equal 0
      subject.attach mockObserver 'foo'
      expect(subject.observers.count()).to.equal 1
      
    it 'should detatch an item', ->
      subject.attach mockObserver 'foo'
      expect(subject.observers.count()).to.equal 1
      subject.detach 'foo'
      expect(subject.observers.count()).to.equal 0
      
    it 'should notify observers', ->
      isChanged = false
      subject.attach mockObserver 'foo', () ->
        isChanged = true
      subject.notify()
      expect(isChanged).to.be.true