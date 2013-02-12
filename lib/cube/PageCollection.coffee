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
    item = @_items[index]
    if item isnt undefined then @_items[index] else null
    
  isInRange : (index) ->
    @getItem(index) isnt null

  showItem: (index) ->
    if @isInRange index
      @getItem(@_current).hide()
      @_current = index
      @getItem(@_current).show()
    
  size : ->
    @_items.length

module.exports = PageCollection