do ($ = @jQuery or @Zepto) ->
  propertyMap = [
    [ '-webkit-transition', '-webkit-transition', '-webkit-transform', 'webkitTransitionEnd' ],
    [ 'MozTransition',      '-moz-transition',    '-moz-transform',    'transitionend' ],
    [ 'OTransition',        '-o-transition',      '-o-transform',      'oTransitionEnd' ],
    [ '-ms-transition',     '-ms-transition',     '-ms-transform',     'msTransitionEnd' ],
    [ 'transition',         'transition',         'transform',         'transitionEnd' ]
  ]

  vendor = do ->
    v   = {}
    div = document.createElement('div')
    for p in propertyMap
      if div.style[p[0]]?
        v.transition    = p[1]
        v.transform     = p[2]
        v.transitionEnd = p[3]
        break
    return v

  getMoveX = ($el1, $el2) ->
    unless $el1.data('originX')
      $el1.data('originX', $el1.offset().left)
    return $el2.offset().left - $el1.data('originX')

  getMoveY = ($el1, $el2) ->
    unless $el1.data('originY')
      $el1.data('originY', $el1.offset().top)
    return $el2.offset().top - $el1.data('originY')

  swap = (el1, el2, opt) ->
    el1
      .data('isMoving', 'true')
      .css(vendor.transform, "translate3d(#{getMoveX(el1, el2)}px, #{getMoveY(el1, el2)}px, 0)")
      .css(vendor.transition, "#{vendor.transform} #{opt.duration}ms #{opt.timing}")
      .one(vendor.transitionEnd, ->
        $(this).data('isMoving', 'false')
        opt.callback() if el2.data('isMoving') is 'false'
      )



  $.fn.swapper = (dest, options) ->
    $src  = @first()
    $dest = $(dest).first()

    return @ if ($src.data('isMoving') is 'true') or ($dest.data('isMoving') is 'true')

    settings = $.extend
      duration: 500
      timing:   'ease-in-out'
      callback: ->
    , options

    swap($src,  $dest, settings)
    swap($dest, $src,  settings)

    return @
