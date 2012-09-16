/*
 jquery.swapper.js v0.1
 Copyright(c) 2012 mako2x. http://github.com/mako2x
 Dual licensed under the MIT and GPL licenses:
 http://www.opensource.org/licenses/mit-license.php
 http://www.gnu.org/licenses/gpl.html
*/

(function($) {
  var div, getMoveX, getMoveY, isCallbackExecuted, move, p, propertyMap, vendor, _i, _len;
  propertyMap = [['-webkit-transition', '-webkit-transition', '-webkit-transform', 'webkitTransitionEnd'], ['MozTransition', '-moz-transition', '-moz-transform', 'transitionend'], ['OTransition', '-o-transition', '-o-transform', 'oTransitionEnd'], ['-ms-transition', '-ms-transition', '-ms-transform', 'msTransitionEnd'], ['transition', 'transition', 'transform', 'transitionEnd']];
  vendor = {};
  div = document.createElement('div');
  for (_i = 0, _len = propertyMap.length; _i < _len; _i++) {
    p = propertyMap[_i];
    if (div.style[p[0]] != null) {
      vendor.transition = p[1];
      vendor.transform = p[2];
      vendor.transitionEnd = p[3];
      break;
    }
  }
  isCallbackExecuted = false;
  getMoveX = function($el1, $el2) {
    if ($el1.data('originX') == null) {
      $el1.data('originX', $el1.offset().left);
    }
    return $el2.offset().left - $el1.data('originX');
  };
  getMoveY = function($el1, $el2) {
    if ($el1.data('originY') == null) {
      $el1.data('originY', $el1.offset().top);
    }
    return $el2.offset().top - $el1.data('originY');
  };
  move = function($el, moveX, moveY, settings) {
    return $el.data('isMoving', true).css(vendor.transform, "translate3d(" + moveX + "px, " + moveY + "px, 0)").css(vendor.transition, "" + vendor.transform + " " + settings.duration + "ms " + settings.timing).one(vendor.transitionEnd, function() {
      $el.data('isMoving', false);
      if (!isCallbackExecuted) {
        settings.callback();
      }
      return isCallbackExecuted = !isCallbackExecuted;
    });
  };
  return $.fn.swapper = function(dest, options) {
    var $dest, $src, defaults, settings;
    $src = this.first();
    $dest = $(dest).first();
    if ($src.data('isMoving') || $dest.data('isMoving')) {
      return this;
    }
    defaults = {
      duration: 500,
      timing: 'ease-out',
      callback: function() {}
    };
    settings = $.extend(defaults, options);
    move($src, getMoveX($src, $dest), getMoveY($src, $dest), settings);
    move($dest, getMoveX($dest, $src), getMoveY($dest, $src), settings);
    return this;
  };
})(jQuery);
