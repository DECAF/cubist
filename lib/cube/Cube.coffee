Stage             = require '../stage/Stage'
ContentController = require './ContentController'
CubistOptions     = require './../config/CubistOptions'

class Cube
  _contentController : null
  _stage             : null

  constructor : (el, options) ->
    @_stage = new Stage el, options.get(CubistOptions.CSS_CLASS_STAGE), options.get(CubistOptions.CSS_CLASS_CUBE)
    cubeEl = @_stage.getCubeEl()
    pages = @_stage.getPages options.get(CubistOptions.PAGE_SELECTOR)

    @_contentController = new ContentController cubeEl
    @_contentController.setPages pages

  show : (index) ->
    unless index < 0 or index > @getPageCount() - 1
      @_showPage index, index % 2 is 0

  _showPage : (index, isEven) ->
    action = if isEven then 'showFrontPage' else 'showBackPage'
    @_contentController[action] index

  getPageCount : ->
    @_contentController.size()


module.exports = Cube