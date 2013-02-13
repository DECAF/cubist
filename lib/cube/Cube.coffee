Stage           = require '../stage/Stage'
Index           = require './Index'
CubistException = require '../util/CubistException'
CubistOptions   = require './../config/CubistOptions'

class Cube
  _stage : null
  _index : null

  constructor : (el, options) ->
    @_stage = new Stage el, options
    @_stage.addPages options.get(CubistOptions.PAGE_SELECTOR)
    @_index = new Index(@_stage.pageCount)

  goto : (index) ->
    throw new CubistException "index #{index} not possible" unless @_index.isValid index
    
    distance = @_index.getDistance index
    @_index.setIndex index
    @_stage.rotateCubeBy distance
   
  next : ->
    @goto @_index.getNextIndex()

  prev : ->
    @goto @_index.getPrevIndex()  
    
  last:  ->
    @goto @_index.getLastIndex()

  first: ->
    @goto @_index.getFirstIndex()



module.exports = Cube