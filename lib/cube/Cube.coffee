Room        = require './Room'
CubeOptions = require './CubeOptions'

class Cube
  _el          : null
  _room        : null

  constructor : (@_el, options) ->
    @_room = new Room @_el
    @_room.create(options.get(CubeOptions.CSS_CLASS_CONTAINER))
    @_room.findPages(options.get(CubeOptions.PAGE_SELECTOR)) 
    
  show : (index) ->
    unless index < 0 or index > @getPageCount() - 1
      @_showPage index, index % 2 is 0

  _showPage: (index, isEven) ->
    action = if isEven then 'showFrontPage' else 'showBackPage' 
    @_room[action] index

  getPageCount : ->
    @_room.size()



module.exports = Cube