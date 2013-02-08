'use strict';

FeatureCheck = require './util/FeatureCheck'
helper       = require './util/helper'
CubeOptions  = require './cube/CubeOptions'
CubeFactory  = require './cube/CubeFactory'
CubeRenderer = require './cube/CubeRenderer'

class Cubist
  @defaults :
    faceSelector       : 'section'
    cubeContainerClass : 'cubist-cube'
    cssClassReady      : 'cubist-ready'
    start              : 0

  el       : null
  _cube    : null

  constructor : (@el, options = {}) ->
    throw new Error 'el has to be a dom element.' if typeof @el.getElementsByClassName isnt 'function'

    options = new CubeOptions options
    @_cube = CubeFactory.getCube @el, options
    @_cube.show options.get(CubeOptions.START_INDEX)

    helper.addClass @el, options.get(CubeOptions.CSS_CLASS_READY)

  next  : ->

  prev  : ->

  start : ->

  end   : ->

  jumpTo  : (index) ->

  size  : ->
    @_cube.getPageCount()


FeatureCheck.check()
    
window.Cubist = Cubist
if typeof window.define is "function" && window.define.amd
  window.define "cubist", [], ->
    window.cubist
