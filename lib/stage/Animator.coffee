Rotation         = require './Rotation'
VendorTranslator = require '../util/VendorCssTranslator'

class Animator
  _stage                   : null
  _$cube                   : null
  _rotation                : null
  _stageDefaultPerspective : null
  onBeforeSideReveal       : null

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
    partialDuration = duration / 2
    
    partialSteps = duration / times
    
    firstHalf = @_rotation.getRotationFn(times / 2)
    secondHalf = @_rotation.getRotationFn(times / 2)

    
    console.log "duration for rotation: #{duration}ms"
    console.log "first, rotating to #{firstHalf} and then to #{secondHalf}"

    @_setStagePerspective yes
    @_$cube.transition
      transform : @_getRotationTransformation(firstHalf, 0) + " scale3d(0.7,0.7,1)"
    , partialDuration, Animator.ROTATE_EASING_START, =>
        console.log "now going second half", secondHalf
        @_$cube.transition
          transform : @_getRotationTransformation(secondHalf, 0) + " scale3d(1,1,1)"
        , partialDuration, Animator.ROTATE_EASING_END, =>
            @_setStagePerspective no

    # will rotate <times> times
    # duration per turn is <duration/times>
    # will call callback when a single rotation is half way through
    
    stepsCounted = 0
    ###eventInterval = window.setInterval =>
      console.log "on page revealed"
      stepsCounted += 1
      clearInterval(eventInterval) if stepsCounted is times
    , partialSteps ###
  
  _getRotationTransformation : (rotateFn, depth)->
    "#{rotateFn} translateZ(#{depth}px)"

  _setStagePerspective : (isRotating)->
    if isRotating
      perspective = @_$cube.width() * 1.2
    else
      perspective = @_stageDefaultPerspective

    VendorTranslator.setStyle @_stage, 'perspective', perspective

  transit : () ->

Animator.ROTATE_EASING_START = 'easeInQuad'
Animator.ROTATE_EASING_END   = 'easeOutQuad'

module.exports = Animator