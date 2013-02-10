Stage = require '../stage/Stage'
ContentController = require './ContentController'
CubistOptions = require './../config/CubistOptions'

class Cube
  _contentController : null
  _stage             : null

  constructor : (el, options) ->
    @_stage = new Stage el, options
    cubeEl = @_stage.getCubeEl()
    pages = @_stage.getPages options.get(CubistOptions.PAGE_SELECTOR)

    @_contentController = new ContentController cubeEl
    @_contentController.setPages pages

  show : (index) ->
    unless index < 0 or index > @getPageCount() - 1
      @_showPage index

  _showPage : (index, isEven) ->
    @_contentController.showPage index

  getPageCount : ->
    @_contentController.size()


module.exports = Cube