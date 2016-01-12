/**
 * jQuery.ScrollTo - Easy element scrolling using jQuery.
 * Copyright (c) 2007-2008 Ariel Flesler - aflesler(at)gmail(dot)com | http://flesler.blogspot.com
 * Dual licensed under MIT and GPL.
 * Date: 9/11/2008
 * @author Ariel Flesler
 * @version 1.4
 *
 * http://flesler.blogspot.com/2007/10/jqueryscrollto.html
 */
!function(h){function n(b){return"object"==typeof b?b:{top:b,left:b}}var m=h.scrollTo=function(b,c,g){h(window).scrollTo(b,c,g)};m.defaults={axis:"y",duration:1},m.window=function(){return h(window).scrollable()},h.fn.scrollable=function(){return this.map(function(){var b=this.parentWindow||this.defaultView,c="#document"==this.nodeName?b.frameElement||b:this,g=c.contentDocument||(c.contentWindow||c).document,i=c.setInterval;return"IFRAME"==c.nodeName||i&&h.browser.safari?g.body:i?g.documentElement:this})},h.fn.scrollTo=function(r,j,a){return"object"==typeof j&&(a=j,j=0),"function"==typeof a&&(a={onAfter:a}),a=h.extend({},m.defaults,a),j=j||a.speed||a.duration,a.queue=a.queue&&a.axis.length>1,a.queue&&(j/=2),a.offset=n(a.offset),a.over=n(a.over),this.scrollable().each(function(){function q(b){o.animate(e,j,a.easing,b&&function(){b.call(this,r,a)})}function u(b){var c="scroll"+b,g=k.ownerDocument;return p?Math.max(g.documentElement[c],g.body[c]):k[c]}var l,k=this,o=h(k),d=r,e={},p=o.is("html,body");switch(typeof d){case"number":case"string":if(/^([+-]=)?\d+(px)?$/.test(d)){d=n(d);break}d=h(d,this);case"object":(d.is||d.style)&&(l=(d=h(d)).offset())}h.each(a.axis.split(""),function(b,c){var g="x"==c?"Left":"Top",i=g.toLowerCase(),f="scroll"+g,s=k[f],t="x"==c?"Width":"Height",v=t.toLowerCase();l?(e[f]=l[i]+(p?0:s-o.offset()[i]),a.margin&&(e[f]-=parseInt(d.css("margin"+g))||0,e[f]-=parseInt(d.css("border"+g+"Width"))||0),e[f]+=a.offset[i]||0,a.over[i]&&(e[f]+=d[v]()*a.over[i])):e[f]=d[i],/^\d+$/.test(e[f])&&(e[f]=e[f]<=0?0:Math.min(e[f],u(t))),!b&&a.queue&&(s!=e[f]&&q(a.onAfterFirst),delete e[f])}),q(a.onAfter)}).end()}}(jQuery);