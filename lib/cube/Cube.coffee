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
    distance = @_contentController.getDistance index
    console?.log 'rotating ' + distance + ' times'
    @_contentController.showPage index
    @_stage.rotate distance

  getPageCount : ->
    @_contentController.size()


module.exports = Cube