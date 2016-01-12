function addTaxaSingle(){var $inputs=$("#addtaxa-single input[name=taxon_id]");window.addingTaxonIds=$inputs.map(function(){var v=$(this).val();return""==v?null:v}).get(),0==addingTaxonIds.length&&checkAddingTaxaFor(null),$inputs.each(function(){var taxonId=$(this).val();!parseInt(taxonId)||parseInt(taxonId)<=0||$.post("/guide_taxa.json",{"guide_taxon[guide_id]":GUIDE.id,"guide_taxon[taxon_id]":taxonId,partial:"guides/guide_taxon_row"}).success(function(json){$("#guide_taxa .nocontent").remove(),$("#guide_taxa").prepend(json.guide_taxon.html),$("#guide_taxa .guide_taxon:first").labelize()}).error(function(xhr){var errors=$.parseJSON(xhr.responseText);alert(I18n.t("there_were_problems_adding_taxa",{errors:errors.join(", ")}))}).complete(function(){checkAddingTaxaFor(taxonId)})})}function completeAddTaxa(){var btn=$("#addtaxa .modal-footer .btn-primary");btn.show(),btn.attr("disabled",!1).removeClass("disabled description"),btn.val(btn.data("original-value")),btn.siblings(".loadingclick").hide(),$("#addtaxa").modal("hide"),bindDeleteButtons()}function checkAddingTaxaFor(taxonId){var i=window.addingTaxonIds.indexOf(taxonId);i>=0&&window.addingTaxonIds.splice(i,1),0==window.addingTaxonIds.length&&($("#addtaxa-single").html(""),addTaxonField(),completeAddTaxa())}function addTaxaFromPlace(){var placeId=$("#addtaxa-place .placechooser").val(),taxonId=$("#addtaxa-place .taxonchooser").val(),rank=$("#addtaxa-place select[name=rank]").val();$.post("/guides/"+GUIDE.id+"/import_taxa",{taxon_id:taxonId,place_id:placeId,rank:rank,partial:"guides/guide_taxon_row"},addImportedTaxaFromJSON,"json").complete(function(){completeAddTaxa()})}function addImportedTaxaFromJSON(json){if(json.error)return alert(json.error),void 0;for(var i=json.guide_taxa.length-1;i>=0;i--)json.guide_taxa[i].html&&($("#guide_taxa .nocontent").remove(),$("#guide_taxa").prepend(json.guide_taxa[i].html),$("#guide_taxa .guide_taxon:first").labelize())}function addTaxaFromEol(){var eolCollectionUrl=$("#addtaxa-eol input:first").val();$.post("/guides/"+GUIDE.id+"/import_taxa",{eol_collection_url:eolCollectionUrl,partial:"guides/guide_taxon_row"},addImportedTaxaFromJSON,"json").complete(function(){completeAddTaxa()})}function addTaxaFromPaste(){$.post("/guides/"+GUIDE.id+"/import_taxa",{names:$("#addtaxa-paste textarea:first").val(),partial:"guides/guide_taxon_row"},addImportedTaxaFromJSON,"json").complete(function(){completeAddTaxa()})}function bindDeleteButtons(){$(".guide_taxon .delete").not(".deleteBound").bind("ajax:before",function(){$(this).parents(".guide_taxon").slideUp()}).bind("ajax:success",function(){$(this).parents(".guide_taxon").remove()}).addClass("deleteBound")}function incrementLoadingStatus(options){options=options||{};var status=$(".bigloading.status").text(),matches=status.match(/ (\d+) of (\d+)/);if(matches&&matches[1]){var current=parseInt(matches[1]),total=matches[2],verb=options.verb||I18n.t("saving_verb");$(".bigloading.status").text(I18n.t("verbing_x_of_y",{verb:verb,x:current+1,y:total}))}}function deleteGuideTaxon(options){var options=options||{},container=$("#guide_taxa"),recordContainer=$(this).parents("form:first"),params="",recordId=$(this).data("guide-taxon-id")||$(this).attr("href").match(/\d+$/)[0],nextMethod=function(){if(options.chain){var link=recordContainer.nextAll().has("input[type=checkbox]:checked").find(".delete").get(0);link?(incrementLoadingStatus({verb:I18n.t("deleting_verb")}),deleteGuideTaxon.apply(link,[options])):container.shades("close")}};return recordId&&""!=recordId?(params+="&_method=DELETE",url="/guide_taxa/"+recordId,$.post(url,params,function(){recordContainer.slideUp(function(){nextMethod(),recordContainer.remove()})},"json").error(function(xhr){var json=eval("("+xhr.responseText+")");if(recordContainer.removeClass("success"),recordContainer.addClass("error"),json.full_messages)errors=json.full_messages;else{var errors="";for(var key in json.errors)errors+=key.replace(/_/," ")+" "+json.errors[key]}recordContainer.find(".message td").html(errors),recordContainer.effect("highlight",{color:"lightpink"},1e3),nextMethod()}),void 0):(recordContainer.hide(),nextMethod(),recordContainer.remove(),void 0)}function removeSelected(){if($selection=$(".guide_taxon").has("input[type=checkbox]:checked"),0==$selection.length)return!1;if(confirm(I18n.t("are_you_sure_you_want_to_remove_these_x_taxa?",{x:$selection.length}))){var msg=I18n.t("verbing_x_of_y",{verb:I18n.t("deleting_verb"),x:1,y:$selection.length});engageShades(msg);var link=$selection.find(".delete:first").get(0);deleteGuideTaxon.apply(link,[{chain:!0}])}}function updatePositions(container,sortable){$selection=$(sortable+":visible",container),$selection.each(function(){$('input[name*="position"]',this).val($selection.index(this)+1)})}function updateGuideTaxa(){window.updateGuideTaxaTimeout=null,saveGuideTaxon.apply($("#guide_taxa form:first").get(0),[{chain:!0,unchecked:!0}])}function saveGuideTaxon(options){var options=options||{},container=$("#guide_taxa"),recordContainer=$(this),nextMethod=function(){if(options.chain){var next;next=options.unchecked?recordContainer.nextAll("form").get(0):recordContainer.nextAll("form").has("input[type=checkbox]:checked:visible").get(0),next?(incrementLoadingStatus(),saveGuideTaxon.apply(next,[options])):container.shades("close")}},url=$(this).attr("action"),params=$(this).serialize();$.post(url,params,function(){nextMethod()},"json").error(function(xhr){var json=eval("("+xhr.responseText+")");nextMethod()})}function addColorTags(){engageShades(I18n.t("tagging")),$.ajax({url:"/guides/"+GUIDE.id+"/add_color_tags",type:"put",dataType:"json",data:$("#guide_taxa form.edit_guide_taxon:visible input[type=checkbox]:checked").serialize()}).success(function(json){$("#guide_taxa").shades("close"),$.each(json,function(){$("#edit_guide_taxon_"+this.id+" [name*=tag_list]").val(this.tag_list.join(", "))})}).error(function(){alert("Failed to add tags")})}function addRankTags(){engageShades(I18n.t("tagging"));var data=$("#guide_taxa form.edit_guide_taxon:visible input[type=checkbox]:checked").serialize()+"&"+$("#addtags-ranks :input").serialize(),rank=$("#addtags-ranks :input[name=rank]").val();$.ajax({url:"/guides/"+GUIDE.id+"/add_tags_for_rank/"+rank,type:"put",dataType:"json",data:data}).success(function(json){$("#guide_taxa").shades("close"),$.each(json,function(){$("#edit_guide_taxon_"+this.id+" [name*=tag_list]").val(this.tag_list.join(", "))})}).error(function(){alert("Failed to add tags")})}function addYourTags(){var tags=($("#addtags-your input[type=text]").val()||"").split(",").map(function(t){return $.trim(t)});if($selection=$("#guide_taxa form.edit_guide_taxon:visible").has("input[type=checkbox]:checked"),0==tags.length||0==$selection.length)return $("#addtags").modal("hide"),void 0;var msg=I18n.t("verbing_x_of_y",{verb:I18n.t("saving_verb"),x:1,y:$selection.length});engageShades(msg),$selection.each(function(){var existing,input=$("input[name*=tag_list]",this),val=$(input).val();existing=val?val.split(",").map(function(t){return $.trim(t)}):[];var newTags=$.unique(existing.concat(tags));$(input).val(newTags.join(", "))}),saveGuideTaxon.apply($selection.get(0),[{chain:!0}])}function addTag(tag){var tags,tag=$.trim(tag);tags=""==$.trim($("#addtags-your input[type=text]").val())?[]:$("#addtags-your input[type=text]").val().split(",").map($.trim),tags.indexOf(tag)<0&&(tags.push(tag),$("#addtags-your input[type=text]").val(tags.join(", ")))}function removeTag(tag){var tags,tag=$.trim(tag);tags=""==$.trim($("#removetags input[type=text]").val())?[]:$("#removetags input[type=text]").val().split(",").map($.trim),tags.indexOf(tag)<0&&(tags.push(tag),$("#removetags input[type=text]").val(tags.join(", ")))}function removeAllTags(){confirm(I18n.t("are_you_sure_you_want_to_remove_all_tags"))&&(engageShades(I18n.t("removing")),$.ajax({url:"/guides/"+GUIDE.id+"/remove_all_tags",type:"put",dataType:"json"}).success(function(){$("#guide_taxa").shades("close"),$(":input[name*=tag_list]").val("")}).error(function(){alert("Failed to remove tags"),$("#guide_taxa").shades("close")}))}function engageShades(msg){$("#guide_taxa").loadingShades(msg,{cssClass:"bigloading",top:$("body").scrollTop()+$(window).height()/2-100+"px"})}if($("#addtaxa").modal({backdrop:!0,show:!1}).on("hidden",completeAddTaxa),$("#addtaxa").on("shown",function(){$("input:visible:first",this).focus()}),$("#addtaxa-place .taxonchooser").chooser({collectionUrl:"/taxa/autocomplete.json",resourceUrl:"/taxa/{{id}}.json?partial=chooser"}),$("#addtaxa-place .placechooser").chooser({collectionUrl:"/places/autocomplete.json",resourceUrl:"/places/{{id}}.json?partial=autocomplete_item",afterSelect:function(){$("#addtaxa-place .taxonchooser").nextAll(":input:visible:first").focus()}}),$("#addtaxa-place .chooser, #addtaxa-place :input[name=rank]").change(function(){$("#addtaxa-place .status").addClass("loading").html("Counting matches..."),window.matchingTaxaRequest&&window.matchingTaxaRequest.abort();var params="place_id="+$("#addtaxa-place .placechooser").val()+"&taxon_id="+$("#addtaxa-place .taxonchooser").val(),rank=$("#addtaxa-place :input[name=rank]").val();rank&&(params+="&rank="+rank),window.matchingTaxaRequest=$.getJSON("/taxa.json",params,function(taxa,status,xhr){var c=parseInt(xhr.getResponseHeader("x-total-entries")||0),names=$.map(taxa,function(t){return t.name}),msg=I18n.t("x_matching_taxa_html",{count:c});1==names.length?msg+=": "+names.join(", "):names.length>0&&(msg+=", "+I18n.t("including")+" "+names.slice(0,10).join(", ")),$("#addtaxa-place .status").removeClass("loading").html(msg)})}),window.addTaxonField=function(){var newInput=$('<input type="text" name="taxon_id" placeholder="'+I18n.t("start_typing_taxon_name")+'"/>');$("#addtaxa-single").append(newInput),newInput.chooser({collectionUrl:"/taxa/autocomplete.json",resourceUrl:"/taxa/{{id}}.json?partial=chooser",afterSelect:function(){window.addTaxonField()}}),$("#addtaxa-single input:visible:last").focus()},addTaxonField(),$("#addtaxa .modal-footer .btn-primary").click(function(){loadingClickForLink.apply(this),$("#addtaxa-single:visible").length>0?addTaxaSingle():$("#addtaxa-place:visible").length>0?addTaxaFromPlace():$("#addtaxa-eol:visible").length>0?addTaxaFromEol():$("#addtaxa-paste:visible").length>0?addTaxaFromPaste():completeAddTaxa()}),window.addingTaxonIds=[],bindDeleteButtons(),$(".navbar-search input").keyup(function(){var q=$(this).val();return q&&""!=q?($(".guide_taxon").each(function(){$(this).data("search-name").match(q)?$(this).show():$(this).hide()}),void 0):($(".guide_taxon").show(),void 0)}),$("#selectall").click(function(){$(".guide_taxon input:checkbox:visible").attr("checked",!0).change()}),$("#selectnone").click(function(){$(".guide_taxon input:checkbox").attr("checked",!1).change()}),$("#guide_taxa").sortable({items:"> form",cursor:"move",placeholder:"row-fluid stacked sorttarget",update:function(){updatePositions("#guide_taxa","form"),window.updateGuideTaxaTimeout||(window.updateGuideTaxaTimeout=setTimeout("updateGuideTaxa()",5e3))}}),iNaturalist&&iNaturalist.Map){window.map=iNaturalist.Map.createMap({div:$("#map").get(0)});var preserveViewport=GUIDE.latitude&&GUIDE.zoom_level;map.setMapTypeId(GUIDE.map_type),GUIDE.zoom_level&&map.setZoom(GUIDE.zoom_level),$("#map_search").latLonSelector({mapDiv:$("#map").get(0),map:map,noAccuracy:!0}),google.maps.event.addListener(map,"maptypeid_changed",function(){$("#guide_map_type").val(window.map.getMapTypeId())}),google.maps.event.addListener(map,"zoom_changed",function(){$("#guide_zoom_level").val(window.map.getZoom())})}window.firstRun=!0,$("#guide_place_id").chooser({collectionUrl:"/places/autocomplete.json",resourceUrl:"/places/{{id}}.json?partial=autocomplete_item",chosen:PLACE,afterSelect:function(item){if($("#guide_place_id").data("json",item),window.firstRun&&PLACE)window.firstRun=!1;else{if($("#guide_latitude").val(item.latitude),$("#guide_longitude").val(item.longitude),item.swlat){var bounds=new google.maps.LatLngBounds(new google.maps.LatLng(item.swlat,item.swlng),new google.maps.LatLng(item.nelat,item.nelng));map.fitBounds(bounds)}$("#guide_latitude").val(item.latitude).change()}}}),$("#addtags .modal-footer .btn-primary").click(function(){$("#addtags-colors:visible").length>0?addColorTags():$("#addtags-ranks:visible").length>0?addRankTags():addYourTags(),$("#addtags").modal("hide")}),$("#removetags .modal-footer .btn-primary").click(function(){var tags=($("#removetags input[type=text]").val()||"").split(",").map(function(t){return $.trim(t)});if($selection=$("#guide_taxa form.edit_guide_taxon:visible").has("input[type=checkbox]:checked"),0==tags.length||0==$selection.length)return $("#removetags").modal("hide"),void 0;var msg=I18n.t("verbing_x_of_y",{verb:I18n.t("removing_verb"),x:1,y:$selection.length});engageShades(msg),$selection.each(function(){for(var input=$("input[name*=tag_list]",this),existing=($(input).val()||"").split(",").map(function(t){return $.trim(t)}),newTags=[],i=0;i<existing.length;i++)$.inArray(existing[i],tags)<0&&newTags.push(existing[i]);$(input).val(newTags.join(", "))}),saveGuideTaxon.apply($selection.get(0),[{chain:!0}]),$("#removetags").modal("hide")}),$(".guide_taxon input[name*=tag_list]").live("change",function(){saveGuideTaxon.apply($(this).parents("form:first").get(0))}),$("#guide_taxa .guide_taxon").labelize(),$('input[name="guide_eol_update_flow_task[options][sections]"]').live("change",function(){$(this).is(":checked")?($('input[name="guide_eol_update_flow_task[options][overview]"]').enable(),$("#eol_subjects :input").enable()):($('input[name="guide_eol_update_flow_task[options][overview]"]').disable(),$("#eol_subjects :input").disable())}),$('input[name="guide_eol_update_flow_task[options][overview]"]').live("change",function(){"true"==$(this).val()?$("#eol_subjects").hide():$("#eol_subjects").show()}),$("#new_guide_eol_update_flow_task .btn-primary").click(function(){$selection=$("#guide_taxa form.edit_guide_taxon:visible").has("input[type=checkbox]:checked");for(var data=$("#new_guide_eol_update_flow_task").serializeArray(),i=0;i<$selection.length;i++){var guideTaxonId=$($selection[i]).attr("action").match(/\d+$/)[0];guideTaxonId&&(data.push({name:"guide_eol_update_flow_task[inputs_attributes]["+i+"][resource_type]",value:"GuideTaxon"}),data.push({name:"guide_eol_update_flow_task[inputs_attributes]["+i+"][resource_id]",value:guideTaxonId}))}return loadingClickForButton.apply($(".modal:visible input[data-loading-click]").get(0),[{ajax:!1}]),$.ajax({url:"/flow_tasks",type:"post",dataType:"json",data:data}).success(function(json){runFlowTask("/flow_tasks/"+json.id+"/run.json")}).error(function(arguments){var btn=$(".modal:visible input[data-loading-click]");btn.attr("disabled",!1).removeClass("disabled description"),btn.val(btn.data("original-value")),alert("Error: ",arguments)}),!1}),window.runFlowTask=function(runUrl){$(".modal:visible .patience").show(),$.ajax({url:runUrl,statusCode:{202:function(){setTimeout('runFlowTask("'+runUrl+'")',5e3)},200:function(){$(".modal:visible .patience").hide();var btn=$(".modal:visible input[data-loading-click]");btn.attr("disabled",!1).removeClass("disabled description"),btn.val(btn.data("original-value")),window.location.reload()}}}).error(function(arguments){var btn=$(".modal:visible input[data-loading-click]");btn.attr("disabled",!1).removeClass("disabled description"),btn.val(btn.data("original-value")),alert("Error: ",arguments),$(".modal:visible .patience").hide()})},$("#guide_eol_update_flow_task_options_subjects").multiselect(),$("#eolupdate").on("shown",function(){$("body").css({height:"100%",overflow:"hidden"});var count=$(".guide_taxon input[type=checkbox]:checked").length,val=I18n.t("update_x_selected_taxa",{count:count});0==count&&(val=I18n.t("you_must_select_at_least_one_taxon")),count>0?$("#eolupdate .modal-footer .btn-primary").enable().val(val):$("#eolupdate .modal-footer .btn-primary").disable().val(val)}),$("#eolupdate").on("hidden",function(){$("body").css({height:"auto",overflow:"auto"})}),$("#guide_users").bind("cocoon:after-insert",function(){$(".guide-user-chooser").chooser({queryParam:"q",collectionUrl:"/people/search.json",resourceUrl:"/people/{{id}}.json"})});