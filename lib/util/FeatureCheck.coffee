CubistException = require './CubistException'

tests =
  jquery :
    message : "jquery is missing. \nPlease use cubist.all.js or include it in your HTML. Get it here http://jquery.com"
    test    : ->
      typeof window.jQuery is "function"

module.exports =
  check : ->
    for own aTest of tests
      throw new CubistException(tests[aTest].message) unless tests[aTest].test()

  # https://gist.github.com/lorenzopolidori/3794226, forked https://gist.github.com/grmlin/4944036    
  is3dCapable : ->
    el = document.createElement("p")
    transforms =
      webkitTransform : "-webkit-transform"
      OTransform      : "-o-transform"
      msTransform     : "-ms-transform"
      MozTransform    : "-moz-transform"
      transform       : "transform"


    # Add it to the body to get the computed style
    document.body.insertBefore el, null
    for t of transforms
      if el.style[t] isnt `undefined`
        el.style[t] = "translate3d(1px,1px,1px)"
        has3d = window.getComputedStyle(el).getPropertyValue(transforms[t])
    document.body.removeChild el
    has3d isnt undefined and has3d.length > 0 and has3d isnt "none"
          
      
    