Rotation         = require './Rotation'
VendorTranslator = require '../util/VendorCssTranslator'

class Animator
  _stage                   : null
  _$cube                   : null
  _rotation                : null
  _stageDefaultPerspective : null


  constructor : (@_stage, cubeEl, isRotatedVertically) ->
    @_$cube = $ cubeEl
    @_rotation = new Rotation isRotatedVertically
    console.dir window.getComputedStyle(@_stage, null)
    @_stageDefaultPerspective = VendorTranslator.getCurrentStyle @_stage, 'perspective'
    @_stageDefaultPerspective = '9999px' if @_stageDefaultPerspective is 'none'
    
  positionRear : ($el, depth)->
    $el.css
      transform : @_getRotationTransformation @_rotation.getRearFaceRotationFn(), depth

  positionRight : ($el, depth)->
    $el.css
      transform : @_getRotationTransformation @_rotation.getRightFaceRotationFn(), depth

  positionBottom : ($el, depth)->
    $el.css
      transform : @_getRotationTransformation @_rotation.getBottomFaceRotationFn(), depth

  rotateCube : (times, depth) ->
    cssDuration = VendorTranslator.getCurrentStyle @_$cube[0], 'transition-duration'
    duration = if cssDuration.indexOf("ms") > -1 then parseFloat(cssDuration) else parseFloat(cssDuration) * 1000

    console.log "duration for rotation: #{duration}ms"
    @_setStagePerspective yes
    @_$cube.css
      transform : @_getRotationTransformation @_rotation.getRotationFn(times), depth
    window.setTimeout(=>
      @_setStagePerspective no
    , duration)

  _getRotationTransformation : (rotateFn, depth)->
    "#{rotateFn} translateZ(#{depth}px)"

  _setStagePerspective : (isRotating)->
    if isRotating
      perspective = @_$cube.width() * 1.2
    else
      perspective = @_stageDefaultPerspective

    VendorTranslator.setStyle @_stage, 'perspective', perspective

  transit : () ->

module.exports = Animator