VENDORS = ['webkit', 'Moz', 'ms', 'O']
getFeature = (feature) ->
  feature.charAt(0).toUpperCase() + feature.slice(1)
  
VendorCssTranslator =
  setStyle : (el, feature, style) ->
    vendorFeature = getFeature feature
    el.style[feature] = style
    for vendor in VENDORS
      el.style[vendor + vendorFeature] = style

  getCurrentStyle : (el, feature) ->
    currentStyle = if typeof getComputedStyle is 'function' then getComputedStyle(el, false) else el.currentStyle
    vendorFeature = getFeature feature

    return currentStyle[feature] if currentStyle[feature] isnt undefined
    for vendor in VENDORS
      styleName = vendor + vendorFeature
      return currentStyle[styleName] if currentStyle[styleName] isnt undefined

module.exports = VendorCssTranslator