'use strict';

helper = require './util/helper'
CubeRenderer = require './cube/CubeRenderer'

class Cubist
  @defaults :
    faceSelector       : 'section'
    cubeContainerClass : 'cubist-cube'
    start              : 0

  el       : null
  _options : null
  _cube    : null

  constructor : (@el, options = {}) ->
    throw new Error 'el has to be a dom element.' if typeof @el.getElementsByClassName isnt 'function'
    
    renderer = new CubeRenderer @el
    
    @_options = helper.extend {}, Cubist.defaults, options
    @_cube    = renderer.getCube @_options.faceSelector, @_options.cubeContainerClass
    @_cube.show @_options.start
    
  next  : ->

  prev  : ->

  start : ->

  end   : ->

  goto  : (index) ->

  size  : ->
    @_cube.getFaceCount()


window.Cubist = Cubist
if typeof window.define is "function" && window.define.amd
  window.define "cubist", [], ->
    window.cubist
