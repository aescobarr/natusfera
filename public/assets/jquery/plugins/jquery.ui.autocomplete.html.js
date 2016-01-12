/*
 * jQuery UI Autocomplete HTML Extension
 *
 * Copyright 2010, Scott González (http://scottgonzalez.com)
 * Dual licensed under the MIT or GPL Version 2 licenses.
 *
 * http://github.com/scottgonzalez/jquery-ui-extensions
 */
!function($){function filter(array,term){var matcher=new RegExp($.ui.autocomplete.escapeRegex(term),"i");return $.grep(array,function(value){return matcher.test($("<div>").html(value.label||value.value||value).text())})}var proto=$.ui.autocomplete.prototype,initSource=proto._initSource;$.extend(proto,{_initSource:function(){this.options.html&&$.isArray(this.options.source)?this.source=function(request,response){response(filter(this.options.source,request.term))}:initSource.call(this)},_renderItem:function(ul,item){return $("<li></li>").data("item.autocomplete",item).append($("<a></a>")[this.options.html?"html":"text"](item.label)).appendTo(ul)}})}(jQuery);