/*
 * jQuery File Upload Plugin 5.19.3
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */
!function(factory){"use strict";"function"==typeof define&&define.amd?define(["jquery","jquery.ui.widget"],factory):factory(window.jQuery)}(function($){"use strict";$.support.xhrFileUpload=!(!window.XMLHttpRequestUpload||!window.FileReader),$.support.xhrFormDataFileUpload=!!window.FormData,$.widget("blueimp.fileupload",{options:{dropZone:$(document),pasteZone:$(document),fileInput:void 0,replaceFileInput:!0,paramName:void 0,singleFileUploads:!0,limitMultiFileUploads:void 0,sequentialUploads:!1,limitConcurrentUploads:void 0,forceIframeTransport:!1,redirect:void 0,redirectParamName:void 0,postMessage:void 0,multipart:!0,maxChunkSize:void 0,uploadedBytes:void 0,recalculateProgress:!0,progressInterval:100,bitrateInterval:500,formData:function(form){return form.serializeArray()},add:function(e,data){data.submit()},processData:!1,contentType:!1,cache:!1},_refreshOptionsList:["fileInput","dropZone","pasteZone","multipart","forceIframeTransport"],_BitrateTimer:function(){this.timestamp=+new Date,this.loaded=0,this.bitrate=0,this.getBitrate=function(now,loaded,interval){var timeDiff=now-this.timestamp;return(!this.bitrate||!interval||timeDiff>interval)&&(this.bitrate=8*(loaded-this.loaded)*(1e3/timeDiff),this.loaded=loaded,this.timestamp=now),this.bitrate}},_isXHRUpload:function(options){return!options.forceIframeTransport&&(!options.multipart&&$.support.xhrFileUpload||$.support.xhrFormDataFileUpload)},_getFormData:function(options){var formData;return"function"==typeof options.formData?options.formData(options.form):$.isArray(options.formData)?options.formData:options.formData?(formData=[],$.each(options.formData,function(name,value){formData.push({name:name,value:value})}),formData):[]},_getTotal:function(files){var total=0;return $.each(files,function(index,file){total+=file.size||1}),total},_onProgress:function(e,data){if(e.lengthComputable){var total,loaded,now=+new Date;if(data._time&&data.progressInterval&&now-data._time<data.progressInterval&&e.loaded!==e.total)return;data._time=now,total=data.total||this._getTotal(data.files),loaded=parseInt(e.loaded/e.total*(data.chunkSize||total),10)+(data.uploadedBytes||0),this._loaded+=loaded-(data.loaded||data.uploadedBytes||0),data.lengthComputable=!0,data.loaded=loaded,data.total=total,data.bitrate=data._bitrateTimer.getBitrate(now,loaded,data.bitrateInterval),this._trigger("progress",e,data),this._trigger("progressall",e,{lengthComputable:!0,loaded:this._loaded,total:this._total,bitrate:this._bitrateTimer.getBitrate(now,this._loaded,data.bitrateInterval)})}},_initProgressListener:function(options){var that=this,xhr=options.xhr?options.xhr():$.ajaxSettings.xhr();xhr.upload&&($(xhr.upload).bind("progress",function(e){var oe=e.originalEvent;e.lengthComputable=oe.lengthComputable,e.loaded=oe.loaded,e.total=oe.total,that._onProgress(e,options)}),options.xhr=function(){return xhr})},_initXHRData:function(options){var formData,file=options.files[0],multipart=options.multipart||!$.support.xhrFileUpload,paramName=options.paramName[0];options.headers=options.headers||{},options.contentRange&&(options.headers["Content-Range"]=options.contentRange),multipart?$.support.xhrFormDataFileUpload&&(options.postMessage?(formData=this._getFormData(options),options.blob?formData.push({name:paramName,value:options.blob}):$.each(options.files,function(index,file){formData.push({name:options.paramName[index]||paramName,value:file})})):(options.formData instanceof FormData?formData=options.formData:(formData=new FormData,$.each(this._getFormData(options),function(index,field){formData.append(field.name,field.value)})),options.blob?(options.headers["Content-Disposition"]='attachment; filename="'+encodeURI(file.name)+'"',options.headers["Content-Description"]=encodeURI(file.type),formData.append(paramName,options.blob,file.name)):$.each(options.files,function(index,file){file instanceof Blob&&formData.append(options.paramName[index]||paramName,file,file.name)})),options.data=formData):(options.headers["Content-Disposition"]='attachment; filename="'+encodeURI(file.name)+'"',options.contentType=file.type,options.data=options.blob||file),options.blob=null},_initIframeSettings:function(options){options.dataType="iframe "+(options.dataType||""),options.formData=this._getFormData(options),options.redirect&&$("<a></a>").prop("href",options.url).prop("host")!==location.host&&options.formData.push({name:options.redirectParamName||"redirect",value:options.redirect})},_initDataSettings:function(options){this._isXHRUpload(options)?(this._chunkedUpload(options,!0)||(options.data||this._initXHRData(options),this._initProgressListener(options)),options.postMessage&&(options.dataType="postmessage "+(options.dataType||""))):this._initIframeSettings(options,"iframe")},_getParamName:function(options){var fileInput=$(options.fileInput),paramName=options.paramName;return paramName?$.isArray(paramName)||(paramName=[paramName]):(paramName=[],fileInput.each(function(){for(var input=$(this),name=input.prop("name")||"files[]",i=(input.prop("files")||[1]).length;i;)paramName.push(name),i-=1}),paramName.length||(paramName=[fileInput.prop("name")||"files[]"])),paramName},_initFormSettings:function(options){options.form&&options.form.length||(options.form=$(options.fileInput.prop("form")),options.form.length||(options.form=$(this.options.fileInput.prop("form")))),options.paramName=this._getParamName(options),options.url||(options.url=options.form.prop("action")||location.href),options.type=(options.type||options.form.prop("method")||"").toUpperCase(),"POST"!==options.type&&"PUT"!==options.type&&(options.type="POST"),options.formAcceptCharset||(options.formAcceptCharset=options.form.attr("accept-charset"))},_getAJAXSettings:function(data){var options=$.extend({},this.options,data);return this._initFormSettings(options),this._initDataSettings(options),options},_enhancePromise:function(promise){return promise.success=promise.done,promise.error=promise.fail,promise.complete=promise.always,promise},_getXHRPromise:function(resolveOrReject,context,args){var dfd=$.Deferred(),promise=dfd.promise();return context=context||this.options.context||promise,resolveOrReject===!0?dfd.resolveWith(context,args):resolveOrReject===!1&&dfd.rejectWith(context,args),promise.abort=dfd.promise,this._enhancePromise(promise)},_getUploadedBytes:function(jqXHR){var range=jqXHR.getResponseHeader("Range"),parts=range&&range.split("-"),upperBytesPos=parts&&parts.length>1&&parseInt(parts[1],10);return upperBytesPos&&upperBytesPos+1},_chunkedUpload:function(options,testOnly){var jqXHR,upload,that=this,file=options.files[0],fs=file.size,ub=options.uploadedBytes=options.uploadedBytes||0,mcs=options.maxChunkSize||fs,slice=file.slice||file.webkitSlice||file.mozSlice,dfd=$.Deferred(),promise=dfd.promise();return this._isXHRUpload(options)&&slice&&(ub||fs>mcs)&&!options.data?testOnly?!0:ub>=fs?(file.error="Uploaded bytes exceed file size",this._getXHRPromise(!1,options.context,[null,"error",file.error])):(upload=function(){var o=$.extend({},options);o.blob=slice.call(file,ub,ub+mcs),o.chunkSize=o.blob.size,o.contentRange="bytes "+ub+"-"+(ub+o.chunkSize-1)+"/"+fs,that._initXHRData(o),that._initProgressListener(o),jqXHR=($.ajax(o)||that._getXHRPromise(!1,o.context)).done(function(result,textStatus,jqXHR){ub=that._getUploadedBytes(jqXHR)||ub+o.chunkSize,o.loaded||that._onProgress($.Event("progress",{lengthComputable:!0,loaded:ub-o.uploadedBytes,total:ub-o.uploadedBytes}),o),options.uploadedBytes=o.uploadedBytes=ub,fs>ub?upload():dfd.resolveWith(o.context,[result,textStatus,jqXHR])}).fail(function(jqXHR,textStatus,errorThrown){dfd.rejectWith(o.context,[jqXHR,textStatus,errorThrown])})},this._enhancePromise(promise),promise.abort=function(){return jqXHR.abort()},upload(),promise):!1},_beforeSend:function(e,data){0===this._active&&(this._trigger("start"),this._bitrateTimer=new this._BitrateTimer),this._active+=1,this._loaded+=data.uploadedBytes||0,this._total+=this._getTotal(data.files)},_onDone:function(result,textStatus,jqXHR,options){this._isXHRUpload(options)||this._onProgress($.Event("progress",{lengthComputable:!0,loaded:1,total:1}),options),options.result=result,options.textStatus=textStatus,options.jqXHR=jqXHR,this._trigger("done",null,options)},_onFail:function(jqXHR,textStatus,errorThrown,options){options.jqXHR=jqXHR,options.textStatus=textStatus,options.errorThrown=errorThrown,this._trigger("fail",null,options),options.recalculateProgress&&(this._loaded-=options.loaded||options.uploadedBytes||0,this._total-=options.total||this._getTotal(options.files))},_onAlways:function(jqXHRorResult,textStatus,jqXHRorError,options){this._active-=1,options.textStatus=textStatus,jqXHRorError&&jqXHRorError.always?(options.jqXHR=jqXHRorError,options.result=jqXHRorResult):(options.jqXHR=jqXHRorResult,options.errorThrown=jqXHRorError),this._trigger("always",null,options),0===this._active&&(this._trigger("stop"),this._loaded=this._total=0,this._bitrateTimer=null)},_onSend:function(e,data){var jqXHR,aborted,slot,pipe,that=this,options=that._getAJAXSettings(data),send=function(){return that._sending+=1,options._bitrateTimer=new that._BitrateTimer,jqXHR=jqXHR||((aborted||that._trigger("send",e,options)===!1)&&that._getXHRPromise(!1,options.context,aborted)||that._chunkedUpload(options)||$.ajax(options)).done(function(result,textStatus,jqXHR){that._onDone(result,textStatus,jqXHR,options)}).fail(function(jqXHR,textStatus,errorThrown){that._onFail(jqXHR,textStatus,errorThrown,options)}).always(function(jqXHRorResult,textStatus,jqXHRorError){if(that._sending-=1,that._onAlways(jqXHRorResult,textStatus,jqXHRorError,options),options.limitConcurrentUploads&&options.limitConcurrentUploads>that._sending)for(var isPending,nextSlot=that._slots.shift();nextSlot;){if(isPending=nextSlot.state?"pending"===nextSlot.state():!nextSlot.isRejected()){nextSlot.resolve();break}nextSlot=that._slots.shift()}})};return this._beforeSend(e,options),this.options.sequentialUploads||this.options.limitConcurrentUploads&&this.options.limitConcurrentUploads<=this._sending?(this.options.limitConcurrentUploads>1?(slot=$.Deferred(),this._slots.push(slot),pipe=slot.pipe(send)):pipe=this._sequence=this._sequence.pipe(send,send),pipe.abort=function(){return aborted=[void 0,"abort","abort"],jqXHR?jqXHR.abort():(slot&&slot.rejectWith(options.context,aborted),send())},this._enhancePromise(pipe)):send()},_onAdd:function(e,data){var paramNameSet,paramNameSlice,fileSet,i,that=this,result=!0,options=$.extend({},this.options,data),limit=options.limitMultiFileUploads,paramName=this._getParamName(options);if((options.singleFileUploads||limit)&&this._isXHRUpload(options))if(!options.singleFileUploads&&limit)for(fileSet=[],paramNameSet=[],i=0;i<data.files.length;i+=limit)fileSet.push(data.files.slice(i,i+limit)),paramNameSlice=paramName.slice(i,i+limit),paramNameSlice.length||(paramNameSlice=paramName),paramNameSet.push(paramNameSlice);else paramNameSet=paramName;else fileSet=[data.files],paramNameSet=[paramName];return data.originalFiles=data.files,$.each(fileSet||data.files,function(index,element){var newData=$.extend({},data);return newData.files=fileSet?element:[element],newData.paramName=paramNameSet[index],newData.submit=function(){return newData.jqXHR=this.jqXHR=that._trigger("submit",e,this)!==!1&&that._onSend(e,this),this.jqXHR},result=that._trigger("add",e,newData)}),result},_replaceFileInput:function(input){var inputClone=input.clone(!0);$("<form></form>").append(inputClone)[0].reset(),input.after(inputClone).detach(),$.cleanData(input.unbind("remove")),this.options.fileInput=this.options.fileInput.map(function(i,el){return el===input[0]?inputClone[0]:el}),input[0]===this.element[0]&&(this.element=inputClone)},_handleFileTreeEntry:function(entry,path){var dirReader,that=this,dfd=$.Deferred(),errorHandler=function(e){e&&!e.entry&&(e.entry=entry),dfd.resolve([e])};return path=path||"",entry.isFile?entry._file?(entry._file.relativePath=path,dfd.resolve(entry._file)):entry.file(function(file){file.relativePath=path,dfd.resolve(file)},errorHandler):entry.isDirectory?(dirReader=entry.createReader(),dirReader.readEntries(function(entries){that._handleFileTreeEntries(entries,path+entry.name+"/").done(function(files){dfd.resolve(files)}).fail(errorHandler)},errorHandler)):dfd.resolve([]),dfd.promise()},_handleFileTreeEntries:function(entries,path){var that=this;return $.when.apply($,$.map(entries,function(entry){return that._handleFileTreeEntry(entry,path)})).pipe(function(){return Array.prototype.concat.apply([],arguments)})},_getDroppedFiles:function(dataTransfer){dataTransfer=dataTransfer||{};var items=dataTransfer.items;return items&&items.length&&(items[0].webkitGetAsEntry||items[0].getAsEntry)?this._handleFileTreeEntries($.map(items,function(item){var entry;return item.webkitGetAsEntry?(entry=item.webkitGetAsEntry(),entry&&(entry._file=item.getAsFile()),entry):item.getAsEntry()})):$.Deferred().resolve($.makeArray(dataTransfer.files)).promise()},_getSingleFileInputFiles:function(fileInput){fileInput=$(fileInput);var files,value,entries=fileInput.prop("webkitEntries")||fileInput.prop("entries");if(entries&&entries.length)return this._handleFileTreeEntries(entries);if(files=$.makeArray(fileInput.prop("files")),files.length)void 0===files[0].name&&files[0].fileName&&$.each(files,function(index,file){file.name=file.fileName,file.size=file.fileSize});else{if(value=fileInput.prop("value"),!value)return $.Deferred().resolve([]).promise();files=[{name:value.replace(/^.*\\/,"")}]}return $.Deferred().resolve(files).promise()},_getFileInputFiles:function(fileInput){return fileInput instanceof $&&1!==fileInput.length?$.when.apply($,$.map(fileInput,this._getSingleFileInputFiles)).pipe(function(){return Array.prototype.concat.apply([],arguments)}):this._getSingleFileInputFiles(fileInput)},_onChange:function(e){var that=this,data={fileInput:$(e.target),form:$(e.target.form)};this._getFileInputFiles(data.fileInput).always(function(files){data.files=files,that.options.replaceFileInput&&that._replaceFileInput(data.fileInput),that._trigger("change",e,data)!==!1&&that._onAdd(e,data)})},_onPaste:function(e){var cbd=e.originalEvent.clipboardData,items=cbd&&cbd.items||[],data={files:[]};return $.each(items,function(index,item){var file=item.getAsFile&&item.getAsFile();file&&data.files.push(file)}),this._trigger("paste",e,data)===!1||this._onAdd(e,data)===!1?!1:void 0},_onDrop:function(e){e.preventDefault();var that=this,dataTransfer=e.dataTransfer=e.originalEvent.dataTransfer,data={};this._getDroppedFiles(dataTransfer).always(function(files){data.files=files,that._trigger("drop",e,data)!==!1&&that._onAdd(e,data)})},_onDragOver:function(e){var dataTransfer=e.dataTransfer=e.originalEvent.dataTransfer;return this._trigger("dragover",e)===!1?!1:(dataTransfer&&(dataTransfer.dropEffect="copy"),e.preventDefault(),void 0)},_initEventHandlers:function(){this._isXHRUpload(this.options)&&(this._on(this.options.dropZone,{dragover:this._onDragOver,drop:this._onDrop}),this._on(this.options.pasteZone,{paste:this._onPaste})),this._on(this.options.fileInput,{change:this._onChange})},_destroyEventHandlers:function(){this._off(this.options.dropZone,"dragover drop"),this._off(this.options.pasteZone,"paste"),this._off(this.options.fileInput,"change")},_setOption:function(key,value){var refresh=-1!==$.inArray(key,this._refreshOptionsList);refresh&&this._destroyEventHandlers(),this._super(key,value),refresh&&(this._initSpecialOptions(),this._initEventHandlers())},_initSpecialOptions:function(){var options=this.options;void 0===options.fileInput?options.fileInput=this.element.is('input[type="file"]')?this.element:this.element.find('input[type="file"]'):options.fileInput instanceof $||(options.fileInput=$(options.fileInput)),options.dropZone instanceof $||(options.dropZone=$(options.dropZone)),options.pasteZone instanceof $||(options.pasteZone=$(options.pasteZone))},_create:function(){var options=this.options;$.extend(options,$(this.element[0].cloneNode(!1)).data()),this._initSpecialOptions(),this._slots=[],this._sequence=this._getXHRPromise(!0),this._sending=this._active=this._loaded=this._total=0,this._initEventHandlers()},_destroy:function(){this._destroyEventHandlers()},add:function(data){var that=this;data&&!this.options.disabled&&(data.fileInput&&!data.files?this._getFileInputFiles(data.fileInput).always(function(files){data.files=files,that._onAdd(null,data)}):(data.files=$.makeArray(data.files),this._onAdd(null,data)))},send:function(data){if(data&&!this.options.disabled){if(data.fileInput&&!data.files){var jqXHR,aborted,that=this,dfd=$.Deferred(),promise=dfd.promise();return promise.abort=function(){return aborted=!0,jqXHR?jqXHR.abort():(dfd.reject(null,"abort","abort"),promise)},this._getFileInputFiles(data.fileInput).always(function(files){aborted||(data.files=files,jqXHR=that._onSend(null,data).then(function(result,textStatus,jqXHR){dfd.resolve(result,textStatus,jqXHR)},function(jqXHR,textStatus,errorThrown){dfd.reject(jqXHR,textStatus,errorThrown)}))}),this._enhancePromise(promise)}if(data.files=$.makeArray(data.files),data.files.length)return this._onSend(null,data)}return this._getXHRPromise(!1,data&&data.context)}})});