class Index
  _current : 0

  setIndex : (@_current) ->
                        
  getIndex : ->
    @_current

  getDistance : (to) ->
    to - @_current
    
module.exports = Index