/* IE7/IE8.js - copyright 2004-2008, Dean Edwards */
!function(){IE7.loaded&&(CLASSES=/\sie7_class\d+/g,IE7.CSS.extend({elements:{},handlers:[],reset:function(){this.removeEventHandlers();var a=this.elements;for(var b in a)a[b].runtimeStyle.cssText="";this.elements={};var a=IE7.Rule.elements;for(var b in a)with(a[b])className=className.replace(CLASSES,"");IE7.Rule.elements={}},reload:function(){this.rules=[],this.getInlineStyles(),this.screen.load(),this.print&&this.print.load(),this.refresh(),this.trash()},addRecalc:function(b,c,d,e){this.base(b,c,function(a){d(a),IE7.CSS.elements[a.uniqueID]=a},e)},recalc:function(){this.reset(),this.base()},addEventHandler:function(a,b,c){a.attachEvent(b,c),this.handlers.push(arguments)},removeEventHandlers:function(){for(var a;a=this.handlers.pop();)a[0].detachEvent(a[1],a[2])},getInlineStyles:function(){for(var b,a=document.getElementsByTagName("style"),c=a.length-1;b=a[c];c--)if(!b.disabled&&!b.ie7){var d=b.cssText||b.innerHTML;this.styles.push(d),b.cssText=d}},trash:function(){var b,c,a=document.styleSheets;for(c=0;c<a.length;c++)b=a[c],b.ie7||b.cssText||(b.cssText=b.cssText);this.base()},getText:function(a){return a.cssText||this.base(a)}}),IE7.CSS.addEventHandler(window,"onunload",function(){IE7.CSS.removeEventHandlers()}),IE7.Rule.elements={},IE7.Rule.prototype.extend({add:function(a){this.base(a),IE7.Rule.elements[a.uniqueID]=a}}),IE7.PseudoElement&&(IE7.PseudoElement.hash={},IE7.PseudoElement.prototype.extend({create:function(a){var b=this.selector+":"+a.uniqueID;IE7.PseudoElement.hash[b]||(IE7.PseudoElement.hash[b]=!0,this.base(a))}})),IE7.HTML.extend({elements:{},addRecalc:function(b,c){this.base(b,function(a){this.elements[a.uniqueID]||(c(a),this.elements[a.uniqueID]=a)})}}),document.recalc=function(a){IE7.CSS.screen&&(a&&IE7.CSS.reload(),IE7.recalc())})}();