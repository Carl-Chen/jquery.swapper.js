###
 jquery.swapper.js v0.1
 Copyright(c) 2012 mako2x. http://github.com/mako2x
 Dual licensed under the MIT and GPL licenses:
 http://www.opensource.org/licenses/mit-license.php
 http://www.gnu.org/licenses/gpl.html
###

do ($ = jQuery) ->
  propertyMap = [
    [ '-webkit-transition', '-webkit-transition', '-webkit-transform', 'webkitTransitionEnd' ],
    [ 'MozTransition',      '-moz-transition',    '-moz-transform',    'transitionend' ],
    [ 'OTransition',        '-o-transition',      '-o-transform',      'oTransitionEnd' ],
    [ '-ms-transition',     '-ms-transition',     '-ms-transform',     'msTransitionEnd' ],
    [ 'transition',         'transition',         'transform',         'transitionEnd' ]
  ]
  vendor = {}
  div = document.createElement('div')
  for p in propertyMap
    if div.style[p[0]]?
      vendor.transition    = p[1]
      vendor.transform     = p[2]
      vendor.transitionEnd = p[3]
      break

  isCallbackExecuted = false


  getMoveX = ($el1, $el2) ->
    unless $el1.data('originX')?
      $el1.data('originX', $el1.offset().left)
    return $el2.offset().left - $el1.data('originX')

  getMoveY = ($el1, $el2) ->
    unless $el1.data('originY')?
      $el1.data('originY', $el1.offset().top)
    return $el2.offset().top - $el1.data('originY')

  move = ($el, moveX, moveY, settings) ->
    $el
      .data('isMoving', true)
      .css(vendor.transform, "translate3d(#{moveX}px, #{moveY}px, 0)")
      .css(vendor.transition, "#{vendor.transform} #{settings.duration}ms #{settings.timing}")
      .one(vendor.transitionEnd, ->
        $el.data('isMoving', false)
        settings.callback() unless isCallbackExecuted
        isCallbackExecuted = !isCallbackExecuted
      )



  $.fn.swapper = (dest, options) ->
    $src = @first()
    $dest = $(dest).first()
    
    return @ if $src.data('isMoving') or $dest.data('isMoving')

    defaults =
      duration: 500
      timing: 'ease-out'
      callback: ->
    settings = $.extend(defaults, options)

    move($src, getMoveX($src, $dest), getMoveY($src, $dest), settings)
    move($dest, getMoveX($dest, $src), getMoveY($dest, $src), settings)

    return @
