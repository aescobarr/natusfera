/*
 * jQuery Labelize Plugin (jQuery >= 1.2.2)
 *
 * This work is distributed under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 * Copyright 2008, Ben Vinegar [ ben ! benlog dot org ]
 *
 * Usage:
 *
 * $('.myLabel').labelize()
 *
 */
!function($){$.fn.labelize=function(hoverClass){function labelClickEvent(){$(this).unbind("click",labelClickEvent),$("input",this).click(),$(this).click(labelClickEvent)}var containers=$(this).filter(":has(input)");return $(containers).css("cursor","pointer").click(labelClickEvent),hoverClass&&containers.mouseover(function(){$(this).addClass(hoverClass)}).mouseout(function(){$(this).removeClass(hoverClass)}),$("input",this).mouseover(function(){$(containers).unbind("click",labelClickEvent)}).mouseout(function(){$(containers).click(labelClickEvent)}),this}}(jQuery);