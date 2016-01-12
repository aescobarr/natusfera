/*
 * jQuery Iframe Transport Plugin 1.5
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2011, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */
!function(factory){"use strict";"function"==typeof define&&define.amd?define(["jquery"],factory):factory(window.jQuery)}(function($){"use strict";var counter=0;$.ajaxTransport("iframe",function(options){if(options.async&&("POST"===options.type||"GET"===options.type)){var form,iframe;return{send:function(_,completeCallback){form=$('<form style="display:none;"></form>'),form.attr("accept-charset",options.formAcceptCharset),iframe=$('<iframe src="javascript:false;" name="iframe-transport-'+(counter+=1)+'"></iframe>').bind("load",function(){var fileInputClones,paramNames=$.isArray(options.paramName)?options.paramName:[options.paramName];iframe.unbind("load").bind("load",function(){var response;try{if(response=iframe.contents(),!response.length||!response[0].firstChild)throw new Error}catch(e){response=void 0}completeCallback(200,"success",{iframe:response}),$('<iframe src="javascript:false;"></iframe>').appendTo(form),form.remove()}),form.prop("target",iframe.prop("name")).prop("action",options.url).prop("method",options.type),options.formData&&$.each(options.formData,function(index,field){$('<input type="hidden"/>').prop("name",field.name).val(field.value).appendTo(form)}),options.fileInput&&options.fileInput.length&&"POST"===options.type&&(fileInputClones=options.fileInput.clone(),options.fileInput.after(function(index){return fileInputClones[index]}),options.paramName&&options.fileInput.each(function(index){$(this).prop("name",paramNames[index]||options.paramName)}),form.append(options.fileInput).prop("enctype","multipart/form-data").prop("encoding","multipart/form-data")),form.submit(),fileInputClones&&fileInputClones.length&&options.fileInput.each(function(index,input){var clone=$(fileInputClones[index]);$(input).prop("name",clone.prop("name")),clone.replaceWith(input)})}),form.append(iframe).appendTo(document.body)},abort:function(){iframe&&iframe.unbind("load").prop("src","javascript".concat(":false;")),form&&form.remove()}}}}),$.ajaxSetup({converters:{"iframe text":function(iframe){return $(iframe[0].body).text()},"iframe json":function(iframe){return $.parseJSON($(iframe[0].body).text())},"iframe html":function(iframe){return $(iframe[0].body).html()},"iframe script":function(iframe){return $.globalEval($(iframe[0].body).text())}}})});