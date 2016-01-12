!function(){/*
 * iNaturalist javascript library
 * Copyright (c) iNaturalist, 2007-2008
 * 
 * @date: 2008-01-01
 * @author: n8agrin
 * @author: kueda
 *
 * Much love to jQuery for the inspiration behind this class' layout.
 */
var iNaturalist=window.iNaturalist=new function(){this.registerNameSpace=function(ns){for(var nsParts=ns.split("."),root=window,i=0;i<nsParts.length;i++)"undefined"==typeof root[nsParts[i]]&&(root[nsParts[i]]=new Object),root=root[nsParts[i]]},this.restfulDelete=function(deleteURL,options,target){if("undefined"==typeof options.plural)var plural=!1;else{var plural=options.plural;options.plural=null}var ajaxOptions=$.extend({},options,{type:"POST",data:$.extend({_method:"delete",authenticity_token:$("meta[name=csrf-token]").attr("content")},options.data),url:deleteURL});if(confirmStr=plural?"Are you sure you want to delete these?":"Are you sure you want to delete this?",!confirm(confirmStr))return!1;if("undefined"!=typeof target){$(target).hide();var deleteStatus=$('<span class="loading status">Deleting...</span>');$(target).after(deleteStatus)}$.ajax(ajaxOptions)},this.modalShow=function(o){iNaturalist.modalCenter(o.w),o.w.show()},this.modalCenter=function(elt){elt.height("auto");var height=.9*$(window).height();elt.height()<height&&(height=elt.height()),(height=elt.height())?elt.height("auto"):elt.height(height);var top=$(window).scrollTop()+$(window).height()/2-elt.height()/2-20;elt.css("top",top+"px")}};iNaturalist.version=.1,iNaturalist.form_authenticity_token=null}();