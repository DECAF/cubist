'use strict';

FeatureCheck = require './util/FeatureCheck'
helper       = require './util/helper'
CubeOptions  = require './config/CubistOptions'
CubeFactory  = require './cube/CubeFactory'

class Cubist
  el       : null
  _cube    : null

  constructor : (@el, options = {}) ->
    throw new Error 'el has to be a dom element.' if typeof @el.getElementsByClassName isnt 'function'
    
    if FeatureCheck.is3dCapable()
  
      options = new CubeOptions options
      @_cube = CubeFactory.getCube @el, options
      @goto options.get(CubeOptions.START_INDEX)
  
      helper.addClass @el, options.get(CubeOptions.CSS_CLASS_READY)
    else
      helper.addClass @el, options.get(CubeOptions.CSS_CLASS_NO_3D)
      
  next  : ->
    @_cube.next()
    
  previous  : ->
    @_cube.prev()
    
  first : ->
    @_cube.first()
    
  last   : ->
    @_cube.last()

  goto  : (index) ->
    @_cube.goto index
    
FeatureCheck.check()
    
window.Cubist = Cubist
if typeof window.define is "function" && window.define.amd
  window.define "cubist", [], ->
    window.cubist
