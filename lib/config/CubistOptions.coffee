helper = require '../util/helper'

class CubistOptions
  _options : null

  constructor : (options) ->
    @_options = helper.extend {}, CubistOptions.defaults, options

  get : (key) ->
    if @_options[key] is undefined then null else  @_options[key]
    
CubistOptions.PAGE_SELECTOR         = "pageSelector"
CubistOptions.CSS_CLASS_STAGE       = "cssClassStage"
CubistOptions.CSS_CLASS_CUBE        = "cssClassContainer"
CubistOptions.CSS_CLASS_READY       = "cssClassReady"
CubistOptions.CSS_CLASS_NO_3D       = "cssClassNo3d"
CubistOptions.START_INDEX           = "startIndex"
CubistOptions.IS_ROTATED_VERTICALLY = "isRotatedVertically"



CubistOptions.defaults = {}
CubistOptions.defaults[CubistOptions.PAGE_SELECTOR]        = '.page'
CubistOptions.defaults[CubistOptions.CSS_CLASS_STAGE]      = 'cubist-stage'
CubistOptions.defaults[CubistOptions.CSS_CLASS_CUBE]       = 'cubist-cube'
CubistOptions.defaults[CubistOptions.CSS_CLASS_READY]      = 'cubist-ready'
CubistOptions.defaults[CubistOptions.CSS_CLASS_NO_3D]      = 'cubist-no-3d'
CubistOptions.defaults[CubistOptions.START_INDEX]          = 0
CubistOptions.defaults[CubistOptions.IS_ROTATED_VERTICALLY] = no

module.exports = CubistOptions