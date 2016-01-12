function getDescription(url){$.ajax({url:url,method:"get",beforeSend:function(){$(".taxon_description").loadingShades()},success:function(data){$(".taxon_description").replaceWith(data),$(".taxon_description select").change(function(){getDescription("/taxa/"+TAXON.id+"/description?from="+$(this).val())})},error:function(){$(".taxon_description").loadingShades("close")}})}$(document).ready(function(){$("#tabs").tabs(),$(".observationcontrols").observationControls({div:$("#taxon_observations .observations")}),$("#photos").imagesLoaded(function(){var h=$(this).height()-108;h>$("#observations").height()&&($("#observations").css({"max-height":"none"}),$("#observations").height(h))}),$("#taxon_range_map").taxonMap(),window.map=$("#taxon_range_map").data("taxonMap"),ADDITIONAL_RANGES&&ADDITIONAL_RANGES.length>0&&$.each(ADDITIONAL_RANGES,function(){var range=this,lyr=new google.maps.KmlLayer(range.kml_url,{suppressInfoWindows:!0,preserveViewport:!0});if(range.source&&range.source.in_text)var title=I18n.t("range_from")+range.source.in_text,description=range.description||range.source.citation;else var title=I18n.t("additional_range"),description=range.description||I18n.t("additional_range_data_from_an_unknown_source");map.addOverlay(title,lyr,{id:"taxon_range-"+range.id,hidden:!0,description:description})}),$("#tabs").bind("tabsshow",function(event,ui){"taxon_range"==ui.panel.id&&(google.maps.event.trigger(window.map,"resize"),$("#taxon_range_map").taxonMap("fit"))}),$(".list_selector_row .addlink").bind("ajax:beforeSend",function(){$(this).hide(),$(this).nextAll(".loading").show()}).bind("ajax:complete",function(){$(this).nextAll(".loading").hide()}).bind("ajax:success",function(){$(this).siblings(".removelink").show(),$(this).parents(".list_selector_row").addClass("added")}).bind("ajax:error",function(event,jqXHR,ajaxSettings,thrownError){$(this).show();var json=eval("("+jqXHR.responseText+")"),errorStr="Heads up: "+json.errors;alert(errorStr)}),$(".list_selector_row .removelink").bind("ajax:beforeSend",function(){$(this).hide(),$(this).nextAll(".loading").show()}).bind("ajax:complete",function(){$(this).nextAll(".loading").hide()}).bind("ajax:success",function(){$(this).siblings(".addlink").show(),$(this).parents(".list_selector_row").removeClass("added")}).bind("ajax:error",function(){$(this).show()}),TAXON.auto_description&&getDescription("/taxa/"+TAXON.id+"/description"),$("#edit_photos_dialog").dialog({modal:!0,title:I18n.t("choose_photos_for_this_taxon"),autoOpen:!1,width:700,open:function(){$("#edit_photos_dialog").loadingShades(I18n.t("loading"),{cssClass:"smallloading"}),$("#edit_photos_dialog").load("/taxa/"+TAXON.id+"/edit_photos",function(){var photoSelectorOptions={defaultQuery:TAXON.name,skipLocal:!0,baseURL:"/flickr/photo_fields",urlParams:{authenticity_token:$("meta[name=csrf-token]").attr("content"),limit:14},afterQueryPhotos:function(q,wrapper){$(wrapper).imagesLoaded(function(){$("#edit_photos_dialog").centerDialog()})}};$(".tabs",this).tabs({show:function(event,ui){"flickr_taxon_photos"!=$(ui.panel).attr("id")||$(ui.panel).hasClass("loaded")?"inat_obs_taxon_photos"!=$(ui.panel).attr("id")||$(ui.panel).hasClass("loaded")?"eol_taxon_photos"!=$(ui.panel).attr("id")||$(ui.panel).hasClass("loaded")?"wikimedia_taxon_photos"!=$(ui.panel).attr("id")||$(ui.panel).hasClass("loaded")||$(".taxon_photos",ui.panel).photoSelector($.extend(!0,{},photoSelectorOptions,{taxon_id:TAXON.id,baseURL:"/wikimedia_commons/photo_fields"})):$(".taxon_photos",ui.panel).photoSelector($.extend(!0,{},photoSelectorOptions,{baseURL:"/eol/photo_fields"})):$(".taxon_photos",ui.panel).photoSelector($.extend(!0,{},photoSelectorOptions,{baseURL:"/taxa/"+TAXON.id+"/observation_photos"})):$(".taxon_photos",ui.panel).photoSelector(photoSelectorOptions),$(ui.panel).addClass("loaded"),$("#edit_photos_dialog").centerDialog()}})})}}),$("#edit_colors_dialog form").bind("ajax:before",function(){$("#edit_colors .button").hide(),$("#edit_colors .loading").show()}).bind("ajax:complete",function(){$("#edit_colors .button").show(),$("#edit_colors .loading").hide()}).bind("ajax:success",function(){$("#colorboxen .color").remove(),$("#colors .notice").remove(),$("#colors .description").remove(),$("#edit_colors input:checked").each(function(){$("#colorboxen").append($("<div>&nbsp;</div>").css({"background-color":$(this).attr("alt")}).addClass("color").attr("title",$(this).attr("alt")))})}).bind("ajax:error",function(){alert("Error updating colors")}),$("#place_selector_search form, #place_selector_paste form").live("ajax:before",function(){$(".loading",this).show()}).live("ajax:complete",function(){$(".loading",this).hide()}).live("ajax:success",function(event,json){$(this).siblings(".place_selector_places").html(json.map(function(place){return place.html}).join(" "))}),$(".add_to_place_link .add_link, .add_to_place_link .remove_link").live("ajax:before",function(){$(this).siblings(".status").show(),$(this).hide()}).live("ajax:error",function(){$(this).hide()}),$(".add_to_place_link .add_link").live("ajax:success",function(){$(this).siblings(".status").html(I18n.t("added!")).removeClass("loading").addClass("success")}),$(".add_to_place_link .remove_link").live("ajax:success",function(){$(this).siblings(".status").html(I18n.t("removed!")).removeClass("loading")}),$("#place_selector_paste form").live("ajax:success",function(event,json){$(this).siblings(".places").html(json.map(function(place){return place.html}).join(" "))})});