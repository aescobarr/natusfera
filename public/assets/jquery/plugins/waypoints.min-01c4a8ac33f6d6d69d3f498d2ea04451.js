/*
jQuery Waypoints - v1.1.7
Copyright (c) 2011-2012 Caleb Troughton
Dual licensed under the MIT license and GPL license.
https://github.com/imakewebthings/jquery-waypoints/blob/master/MIT-license.txt
https://github.com/imakewebthings/jquery-waypoints/blob/master/GPL-license.txt
*/
!function($,k,m,i){var e=$(i),g="waypoint.reached",b=function(o,n){o.element.trigger(g,n),o.options.triggerOnce&&o.element[k]("destroy")},h=function(p,o){if(!o)return-1;for(var n=o.waypoints.length-1;n>=0&&o.waypoints[n].element[0]!==p[0];)n-=1;return n},f=[],l=function(n){$.extend(this,{element:$(n),oldScroll:0,waypoints:[],didScroll:!1,didResize:!1,doScroll:$.proxy(function(){var q=this.element.scrollTop(),p=q>this.oldScroll,s=this,r=$.grep(this.waypoints,function(u){return p?u.offset>s.oldScroll&&u.offset<=q:u.offset<=s.oldScroll&&u.offset>q}),o=r.length;this.oldScroll&&q||$[m]("refresh"),this.oldScroll=q,o&&(p||r.reverse(),$.each(r,function(u,t){(t.options.continuous||u===o-1)&&b(t,[p?"down":"up"])}))},this)}),$(n).bind("scroll.waypoints",$.proxy(function(){this.didScroll||(this.didScroll=!0,i.setTimeout($.proxy(function(){this.doScroll(),this.didScroll=!1},this),$[m].settings.scrollThrottle))},this)).bind("resize.waypoints",$.proxy(function(){this.didResize||(this.didResize=!0,i.setTimeout($.proxy(function(){$[m]("refresh"),this.didResize=!1},this),$[m].settings.resizeThrottle))},this)),e.load($.proxy(function(){this.doScroll()},this))},j=function(n){var o=null;return $.each(f,function(p,q){return q.element[0]===n?(o=q,!1):void 0}),o},c={init:function(o,n){return this.each(function(){var q,u=$.fn[k].defaults.context,t=$(this);n&&n.context&&(u=n.context),$.isWindow(u)||(u=t.closest(u)[0]),q=j(u),q||(q=new l(u),f.push(q));var p=h(t,q),s=0>p?$.fn[k].defaults:q.waypoints[p].options,r=$.extend({},s,n);r.offset="bottom-in-view"===r.offset?function(){var v=$.isWindow(u)?$[m]("viewportHeight"):$(u).height();return v-$(this).outerHeight()}:r.offset,0>p?q.waypoints.push({element:t,offset:null,options:r}):q.waypoints[p].options=r,o&&t.bind(g,o),n&&n.handler&&t.bind(g,n.handler)}),$[m]("refresh"),this},remove:function(){return this.each(function(o,p){var n=$(p);$.each(f,function(r,s){var q=h(n,s);q>=0&&(s.waypoints.splice(q,1),s.waypoints.length||(s.element.unbind("scroll.waypoints resize.waypoints"),f.splice(r,1)))})})},destroy:function(){return this.unbind(g)[k]("remove")}},a={refresh:function(){$.each(f,function(r,s){var q=$.isWindow(s.element[0]),n=q?0:s.element.offset().top,p=q?$[m]("viewportHeight"):s.element.height(),o=q?0:s.element.scrollTop();$.each(s.waypoints,function(u,x){if(x){var t=x.options.offset,w=x.offset;if("function"==typeof x.options.offset)t=x.options.offset.apply(x.element);else if("string"==typeof x.options.offset){var v=parseFloat(x.options.offset);t=x.options.offset.indexOf("%")?Math.ceil(p*(v/100)):v}x.offset=x.element.offset().top-n+o-t,x.options.onlyOnScroll||(null!==w&&s.oldScroll>w&&s.oldScroll<=x.offset?b(x,["up"]):null!==w&&s.oldScroll<w&&s.oldScroll>=x.offset?b(x,["down"]):!w&&s.element.scrollTop()>x.offset&&b(x,["down"]))}}),s.waypoints.sort(function(u,t){return u.offset-t.offset})})},viewportHeight:function(){return i.innerHeight?i.innerHeight:e.height()},aggregate:function(){var n=$();return $.each(f,function(o,p){$.each(p.waypoints,function(q,r){n=n.add(r.element)})}),n}};$.fn[k]=function(n){return c[n]?c[n].apply(this,Array.prototype.slice.call(arguments,1)):"function"!=typeof n&&n?"object"==typeof n?c.init.apply(this,[null,n]):($.error("Method "+n+" does not exist on jQuery "+k),void 0):c.init.apply(this,arguments)},$.fn[k].defaults={continuous:!0,offset:0,triggerOnce:!1,context:i},$[m]=function(n){return a[n]?a[n].apply(this):a.aggregate()},$[m].settings={resizeThrottle:200,scrollThrottle:100},e.load(function(){$[m]("refresh")})}(jQuery,"waypoint","waypoints",window);