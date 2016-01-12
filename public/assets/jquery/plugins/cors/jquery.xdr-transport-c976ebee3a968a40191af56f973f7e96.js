/*
 * jQuery XDomainRequest Transport Plugin 1.1.2
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2011, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 *
 * Based on Julian Aubourg's ajaxHooks xdr.js:
 * https://github.com/jaubourg/ajaxHooks/
 */
!function(factory){"use strict";"function"==typeof define&&define.amd?define(["jquery"],factory):factory(window.jQuery)}(function($){"use strict";window.XDomainRequest&&!$.support.cors&&$.ajaxTransport(function(s){if(s.crossDomain&&s.async){s.timeout&&(s.xdrTimeout=s.timeout,delete s.timeout);var xdr;return{send:function(headers,completeCallback){function callback(status,statusText,responses,responseHeaders){xdr.onload=xdr.onerror=xdr.ontimeout=$.noop,xdr=null,completeCallback(status,statusText,responses,responseHeaders)}xdr=new XDomainRequest,"DELETE"===s.type?(s.url=s.url+(/\?/.test(s.url)?"&":"?")+"_method=DELETE",s.type="POST"):"PUT"===s.type&&(s.url=s.url+(/\?/.test(s.url)?"&":"?")+"_method=PUT",s.type="POST"),xdr.open(s.type,s.url),xdr.onload=function(){callback(200,"OK",{text:xdr.responseText},"Content-Type: "+xdr.contentType)},xdr.onerror=function(){callback(404,"Not Found")},s.xdrTimeout&&(xdr.ontimeout=function(){callback(0,"timeout")},xdr.timeout=s.xdrTimeout),xdr.send(s.hasContent&&s.data||null)},abort:function(){xdr&&(xdr.onerror=$.noop(),xdr.abort())}}}})});