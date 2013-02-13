class Index
  _current : 0
  _count   : 0

  constructor : (@_count) ->

  setIndex    : (@_current) ->

  getIndex    : ->
    @_current

  getNextIndex: ->
    next = @getIndex() + Index.INCREMENT
    next = Index.FIRST if next > @_count - 1 
    return next

  getPrevIndex: ->
    prev = @getIndex() - Index.INCREMENT
    prev = @getLastIndex() if prev < Index.FIRST
    return prev

  getLastIndex: ->
    @_count - 1
    
  getFirstIndex: ->
    Index.FIRST
    
  getDistance : (to) ->
    to - @_current
    
  isValid: (index) ->
    index >= Index.FIRST and index < @_count 

Index.FIRST = 0
Index.INCREMENT = 1

module.exports = Index