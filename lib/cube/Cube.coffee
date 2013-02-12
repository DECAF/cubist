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

  show : (index) ->
    @_stage.rotateTo index

module.exports = Cube