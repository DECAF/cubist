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

    options = new CubeOptions options
    @_cube = CubeFactory.getCube @el, options
    @_cube.show options.get(CubeOptions.START_INDEX)
    @_cube.show options.get(CubeOptions.START_INDEX) + 1

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
