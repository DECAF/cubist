Stage             = require '../stage/Stage'
ContentController = require './ContentController'
CubistOptions     = require './../config/CubistOptions'

class Cube
  _contentController : null
  _stage             : null

  constructor : (el, options) ->
    @_stage = new Stage el, options
    @_stage.addPages options.get(CubistOptions.PAGE_SELECTOR)
    cubeEl = @_stage.getCubeEl()
    #sides = @_stage.getSides()
    #pages = 

    @_contentController = new ContentController cubeEl
    #@_contentController.setPages pages

  show : (index) ->
    @_contentController.showPage index
    @_stage.rotateTo index

  getPageCount : ->
    @_contentController.size()

module.exports = Cube