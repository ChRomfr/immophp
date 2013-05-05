/*
  mDOMupdate
  Version: 1.0 r1
  
  Copyright (c) 2010 Meta100 LLC.
  http://www.meta100.com/
  
  Licensed under the MIT license 
  http://www.opensource.org/licenses/mit-license.php 
*/

(function ($) {

  if ($.mDOMupdate === undefined) {

    var timer;

    $.mDOMupdate = true;
    $.mDOMupdateTrigger = function () {

      if ($.mDOMupdate) {

        clearTimeout(timer);

        timer = setTimeout(function() {

          $.mDOMupdate = false;
          $(document).trigger('DOMUpdated');
          $.mDOMupdate = true;
        }, 50);
      }
    };
  
    $.fn.origDomManip = $.fn.domManip;
    $.fn.domManip = function (args, table, callback) {
  
      $.mDOMupdateTrigger();
      return $(this).origDomManip(args, table, callback);
    };

    $.fn.origHtml = $.fn.html;
  	$.fn.html = function (value) {

  		if (value !== undefined) $.mDOMupdateTrigger();
      return $(this).origHtml(value);
    };

    $.fn.origRemove = $.fn.remove;
  	$.fn.remove = function (elem, types, handler, pos) {

  		$.mDOMupdateTrigger();
      return $(this).origRemove(elem, types, handler, pos);
    };

    $.fn.origEmpty = $.fn.empty;
  	$.fn.empty = function () {

  		$.mDOMupdateTrigger();
      return $(this).origEmpty();
    };
  }
})(jQuery);