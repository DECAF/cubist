helper = require '../util/helper'

class CubeOptions
  _options : null

  constructor : (options) ->
    @_options = helper.extend {}, CubeOptions.defaults, options

  get : (key) ->
    if @_options[key] is undefined then null else  @_options[key]
    
CubeOptions.PAGE_SELECTOR       = "pageSelector"
CubeOptions.CSS_CLASS_CONTAINER = "cssClassContainer"
CubeOptions.CSS_CLASS_READY     = "cssClassReady"
CubeOptions.START_INDEX         = "startIndex"


CubeOptions.defaults = {}
CubeOptions.defaults[CubeOptions.PAGE_SELECTOR ]       = 'section'
CubeOptions.defaults[CubeOptions.CSS_CLASS_CONTAINER ] = 'cubist-cube'
CubeOptions.defaults[CubeOptions.CSS_CLASS_READY ]     = 'cubist-ready'
CubeOptions.defaults[CubeOptions.START_INDEX ]         = 0

module.exports = CubeOptions