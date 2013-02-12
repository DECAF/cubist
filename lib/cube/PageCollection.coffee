CubistException = require '../util/CubistException'

class PageCollection
  _items   : null
  _current : 0

  constructor : ->
    @_items = []

  addItem : (item) ->
    @_items.push item
    @_items.length - 1

  getItem: (index) ->
    if @_items[index] is undefined then null else @_items[index]
    
  isInRange : (index) ->
    @getItem(index) isnt null

  setIndex : (index) ->
    @_current = index if @isInRange index
    @_current

  getIndex : ->
    @_current
    
  getDistance: (from, to) ->
    throw new CubistException 'the distance requested does not exists.' if not @isInRange to
    to - from
    
  size : ->
    @_items.length

module.exports = PageCollection