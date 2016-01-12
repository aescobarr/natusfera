function selectAllIconicTaxa(){$(".iconic_taxon_filter input").each(function(){this.checked=!0,$(this).siblings("label").addClass("selected")})}function deSelectAllIconicTaxa(){$(".iconic_taxon_filter input").each(function(){this.checked=!1,$(this).siblings("label").removeClass("selected")})}function toggleFilters(link,options){var options=$.extend({},options);0==$("#filters:visible").length?showFilters(link,options):hideFilters(link,options)}function showFilters(link,options){var options=$.extend({},options);$("#filters").show(),options.skipClass||$(link).addClass("open"),$("#filters input[name=filters_open]").val(!0),0==$("#filters .simpleTaxonSelector").length&&$("#filters input[name=taxon_name]").simpleTaxonSelector(),0==$("#place_filter .ui-widget").length&&$("#filters input[name=place_id]").chooser({collectionUrl:"/places/autocomplete.json",resourceUrl:"/places/{{id}}.json?partial=autocomplete_item",chosen:eval("("+$("#filters input[name=place_id]").attr("data-json")+")")})}function hideFilters(link,options){var options=$.extend({},options);$("#filters").hide(),options.skipClass||$(link).removeClass("open"),$("#filters input[name=filters_open]").val(!1)}function deselectAll(){$("#filters :text, #fitlers :input[type=hidden], #fitlers select").val(null),$("#filters :input:checkbox").attr("checked",!1),deSelectAllIconicTaxa(),$("#filters input[name=place_id]").chooser("clear",{bubble:!1}),$.fn.simpleTaxonSelector.unSelectTaxon("#filters .simpleTaxonSelector")}function setFiltersFromQuery(query){deselectAll();var params=$.deparam(query);$.each(params,function(k,v){"iconic_taxa"!=k&&"has"!=k&&$('#filters :input:radio[name="'+k+'"][value="'+v+'"]').attr("checked",!0),$("#filters :input[name="+k+"]").not(":checkbox, :radio").val(v),"place_id"==k?$("#filters input[name=place_id]").chooser("selectId",v):"taxon_id"==k?$.fn.simpleTaxonSelector.selectTaxonFromId("#filters .simpleTaxonSelector",v):"iconic_taxa"==k||"has"==k?$.each(v,function(i,av){$selection=$('#filters :input:checkbox[name="'+k+'[]"][value='+av+"]"),$selection.attr("checked",!0),"iconic_taxa"==k&&$selection.siblings("label").addClass("selected")}):"projects"==k&&$('#filters :input[name="projects[]"]').val(v)})}!function(){/*
 * iNaturalist javascript library
 * Copyright (c) iNaturalist, 2007-2008
 * 
 * @date: 2008-01-01
 * @author: n8agrin
 * @author: kueda
 *
 * Much love to jQuery for the inspiration behind this class' layout.
 */
var iNaturalist=window.iNaturalist=new function(){this.registerNameSpace=function(ns){for(var nsParts=ns.split("."),root=window,i=0;i<nsParts.length;i++)"undefined"==typeof root[nsParts[i]]&&(root[nsParts[i]]=new Object),root=root[nsParts[i]]},this.restfulDelete=function(deleteURL,options,target){if("undefined"==typeof options.plural)var plural=!1;else{var plural=options.plural;options.plural=null}var ajaxOptions=$.extend({},options,{type:"POST",data:$.extend({_method:"delete",authenticity_token:$("meta[name=csrf-token]").attr("content")},options.data),url:deleteURL});if(confirmStr=plural?"Are you sure you want to delete these?":"Are you sure you want to delete this?",!confirm(confirmStr))return!1;if("undefined"!=typeof target){$(target).hide();var deleteStatus=$('<span class="loading status">Deleting...</span>');$(target).after(deleteStatus)}$.ajax(ajaxOptions)},this.modalShow=function(o){iNaturalist.modalCenter(o.w),o.w.show()},this.modalCenter=function(elt){elt.height("auto");var height=.9*$(window).height();elt.height()<height&&(height=elt.height()),(height=elt.height())?elt.height("auto"):elt.height(height);var top=$(window).scrollTop()+$(window).height()/2-elt.height()/2-20;elt.css("top",top+"px")}};iNaturalist.version=.1,iNaturalist.form_authenticity_token=null}(),function(){/**
 * iNaturalist map object
 * Copyright (c) iNaturalist, 2007-2008
 * 
 * @created: 2008-01-01
 * @updated: 2008-04-12
 * @author: n8agrin
 * @author: kueda
 */
if("undefined"==typeof google||"undefined"==typeof google.maps)throw"The Google Maps libraries must be loaded to use the iNaturalist Map extensions.";var deselectText=function(){window.getSelection?window.getSelection().empty?window.getSelection().empty():window.getSelection().removeAllRanges&&window.getSelection().removeAllRanges():document.selection&&document.selection.empty()};google.maps.Marker.prototype.observation_id=null,google.maps.Map.prototype.observations={},google.maps.Map.prototype.places={},google.maps.Map.prototype.lastUnsavedMarker=null,google.maps.Map.prototype.infoWindow=null,google.maps.Map.prototype.createMarker=function(lat,lng,options){return options=options||{},options.position=new google.maps.LatLng(lat,lng),new google.maps.Marker(options)},google.maps.Map.prototype.removeMarker=function(marker){google.maps.event.clearInstanceListeners(marker),this.removeOverlay(marker)},google.maps.Map.prototype.addNewCenteredMarker=function(options){return this.addNewUnsavedMarker(this.getCenter().lat(),this.getCenter().lng(),options)},google.maps.Map.prototype.addNewUnsavedMarker=function(lat,lng,options){return this.removeLastUnsavedMarker(),this.lastUnsavedMarker=this.createMarker(lat,lng,options),this.lastUnsavedMarker.setMap(this),this.lastUnsavedMarker},google.maps.Map.prototype.removeLastUnsavedMarker=function(){return this.lastUnsavedMarker?(this.removeMarker(this.lastUnsavedMarker),this.lastUnsavedMarker=null,!0):!1},google.maps.Map.prototype.addObservation=function(observation,options){options=options||{};var lat=observation.private_latitude||observation.latitude,lon=observation.private_longitude||observation.longitude;if(!lat||!lon)return!1;options.icon||(options.icon=iNaturalist.Map.createObservationIcon({observation:observation}));var marker=this.createMarker(lat,lon,options);this.observations[observation.id]=marker,("undefined"==typeof options.clickable||0!=options.clickable)&&(marker.message=this.buildObservationInfoWindow(observation),google.maps.event.addListener(marker,"click",this.openInfoWindow));var bounds=this.getObservationBounds();if(bounds.extend(new google.maps.LatLng(lat,lon)),this.setObservationBounds(bounds),marker.setMap(this),observation.marker=marker,options.showAccuracy&&(observation.coordinates_obscured||observation.positional_accuracy&&observation.positional_accuracy>0)){var accuracy=parseInt(observation.positional_accuracy)||0;if(observation.coordinates_obscured&&(accuracy+=1e4),0==accuracy)return;var iconicTaxonName=observation.iconic_taxon_name;!iconicTaxonName&&observation.iconic_taxon&&(iconicTaxonName=observation.iconic_taxon.name);var color=iconicTaxonName?iNaturalist.Map.ICONIC_TAXON_COLORS[iconicTaxonName]:"#333333",circle=new google.maps.Circle({strokeColor:color,strokeOpacity:.8,strokeWeight:2,fillColor:color,fillOpacity:.35,map:this,center:marker.getPosition(),radius:accuracy});observation._circle=circle,google.maps.event.addListener(this,"zoom_changed",function(){var mapBounds=this.getBounds(),circleBounds=circle.getBounds();circleBounds.contains(mapBounds.getNorthEast())&&circleBounds.contains(mapBounds.getSouthWest())?circle.setVisible(!1):circle.setVisible(!0)})}return observation},google.maps.Map.prototype.removeObservation=function(observation){this.removeMarker(this.observations[observation.id]),this.observations[observation.id]&&this.observations[observation.id].setMap(null),delete this.observations[observation.id]},google.maps.Map.prototype.addObservations=function(observations,options){var map=this;$.each(observations,function(){map.addObservation(this,options)})},google.maps.Map.prototype.removeObservations=function(observations){var map=this;"undefined"==typeof observations?$.each(map.observations,function(k,v){map.removeMarker(v),v.setMap(null),delete map.observations[k],delete map.observationBounds}):$.each(observations,function(){map.removeObservation(this)})},google.maps.Map.prototype.getObservationBounds=function(){return this.observationBounds||(this.observationBounds=new google.maps.LatLngBounds),this.observationBounds},google.maps.Map.prototype.setObservationBounds=function(bounds){this.observationBounds=bounds},google.maps.Map.prototype.zoomToObservations=function(){this.fitBounds(this.getObservationBounds())},google.maps.Map.prototype.addPlaces=function(places){for(var i=places.length-1;i>=0;i--)this.addPlace(places[i])},google.maps.Map.prototype.addPlace=function(place,options){if("undefined"==typeof options)var options={};"undefined"==typeof options.icon&&(options.icon=iNaturalist.Map.createPlaceIcon());var marker=this.createMarker(place.latitude,place.longitude,options);this.places[place.id]=marker;var placesLength=0;for(var key in this.places)placesLength+=1;if(1==placesLength&&null!=place.swlat&&""!=place.swlat)var bounds=new google.maps.LatLngBounds(new google.maps.LatLng(place.swlat,place.swlng),new google.maps.LatLng(place.nelat,place.nelng));else{var bounds=this.getPlaceBounds();place.swlat?(bounds.extend(new google.maps.LatLng(place.swlat,place.swlng)),bounds.extend(new google.maps.LatLng(place.nelat,place.nelng))):bounds.extend(new google.maps.LatLng(place.latitude,place.longitude))}return this.setPlaceBounds(bounds),marker.setMap(this),place.marker=marker,place},google.maps.Map.prototype.setPlace=function(place,options){if(options=options||{},place.swlat){var bounds=new google.maps.LatLngBounds(new google.maps.LatLng(place.swlat,place.swlng),new google.maps.LatLng(place.nelat,place.nelng));this.fitBounds(bounds)}else this.setCenter(new google.maps.LatLng(place.latitude,place.longitude))},google.maps.Map.prototype.removePlace=function(place){this.removeMarker(this.places[place.id]),delete this.places[place.id]},google.maps.Map.prototype.removePlaces=function(places){var map=this;"undefined"==typeof places?$.each(map.places,function(){map.removeMarker(this),delete this}):$.each(places,function(){map.removePlace(this)}),this.placeBounds=new google.maps.LatLngBounds},google.maps.Map.prototype.zoomToPlaces=function(){this.fitBounds(this.getPlaceBounds())},google.maps.Map.prototype.getPlaceBounds=function(){return"undefined"==typeof this.placeBounds&&(this.placeBounds=new google.maps.LatLngBounds),this.placeBounds},google.maps.Map.prototype.setPlaceBounds=function(bounds){this.placeBounds=bounds},google.maps.Map.prototype.openInfoWindow=function(){iNaturalist.Map.infowWindow=iNaturalist.Map.infowWindow||new google.maps.InfoWindow,iNaturalist.Map.infowWindow.setContent(this.message),iNaturalist.Map.infowWindow.open(this.map,this)},google.maps.Map.prototype.buildObservationInfoWindow=function(observation){var existing=document.getElementById("observation-"+observation.id);if("undefined"!=typeof existing&&null!=existing){var infowinobs=$(existing).clone().get(0);$(infowinobs).find(".details").show();var wrapper=$('<div class="compact mini infowindow observations"></div>').append(infowinobs);return $(wrapper).get(0)}var photoURL,wrapper=$('<div class="observation"></div>');return"undefined"!=typeof observation.image_url&&null!=observation.image_url?photoURL=observation.image_url:"undefined"!=typeof observation.obs_image_url&&null!=observation.obs_image_url?photoURL=observation.obs_image_url:"undefined"!=typeof observation.photos&&observation.photos.length>0&&(photoURL=observation.photos[0].square_url),photoURL&&wrapper.append($('<img width="75" height="75"></img>').attr("src",photoURL).addClass("left")),wrapper.append($('<div class="readable attribute inlineblock"></div>').append($('<a href="/observations/'+observation.id+'"></a>').append(observation.species_guess))),observation.user?wrapper.append(", by ",$('<a href="/people/'+observation.user.login+'"></a>').append(observation.user.login)):"undefined"!=typeof observation.identifications&&observation.identifications.length>0&&"undefined"!=typeof observation.identifications[0].user&&wrapper.append(", by ",$('<a href="/people/'+observation.identifications[0].user.login+'"></a>').append(observation.identifications[0].user.login)),"undefined"!=typeof observation.short_description&&null!=observation.short_description?wrapper.append($('<div class="description"></div>').append(observation.short_description)):wrapper.append($('<div class="description"></div>').append(observation.description)),wrapper=$('<div class="compact observations mini infowindow"></div>').append(wrapper),wrapper.get(0)},google.maps.Map.prototype.showAllObsOverlay=function(){if("undefined"==typeof this._allObsOverlay){var myCopyright=new google.maps.CopyrightCollection,allObsLyr=new ObservationsTileLayer(myCopyright,0,18,{isPNG:!0,tileUrlTemplate:this._observationsTileServer+"/{Z}/{X}/{Y}.png"});this._allObsOverlay=new google.maps.TileLayerOverlay(allObsLyr);var baseIcon=new google.maps.MarkerImage;baseIcon.size=new google.maps.Size(20,20),baseIcon.anchor=new google.maps.Point(10,10),this._allObsMarker=new google.maps.Marker(new google.maps.LatLng(35,-90),{icon:baseIcon}),this._allObsMarker.setVisible(!1),google.maps.event.addListener(this._allObsMarker,"click",function(){var observation=this._observation,maxContentDiv=$('<div class="observations mini maxinfowindow"></div>').append($('<div class="loading status">'+I18n.t("loading")+"</div>")).get(0);this.openInfoWindowHtml(map.buildObservationInfoWindow(observation),{maxContent:maxContentDiv,maxTitle:"More about this observation"});var infoWindow=map.getInfoWindow();google.maps.event.addListener(infoWindow,"maximizeclick",function(){google.maps.DownloadUrl("/observations/"+observation.id+"?partial=observation",function(data){maxContentDiv.innerHTML=data,$(maxContentDiv).find(".details").show(),"undefined"!=typeof $.jqm&&$("#modal_image_box").jqmAddTrigger(".maxinfowindow a.modal_image_link")})})}),this._allObsMarker.map=map}this._allObsOverlay.map=map,this._mouseMoveListenerHandle=google.maps.event.addListener(map,"mousemove",this._mouseMoveListener)},google.maps.Map.prototype.hideAllObsOverlay=function(){"undefined"!=typeof this._allObsOverlay&&(this.removeOverlay(this._allObsOverlay),google.maps.event.removeListener(this._mouseMoveListenerHandle))},google.maps.Map.prototype._mouseMoveListener=function(e){e.latLng;var zoom=this.getZoom(),mousePx=e.pixel,tileKey=iNaturalist.Map.obsTilePointsURL(Math.floor(mousePx.x/256),Math.floor(mousePx.y/256),zoom);if(window.tilePoints=window.tilePoints||{},"undefined"!=typeof window.tilePoints[tileKey]&&0!=window.tilePoints[tileKey].length)for(var observations=window.tilePoints[tileKey],i=observations.length-1;i>=0;i--){var obsPx=G_NORMAL_MAP.getProjection().fromLatLngToPixel(new google.maps.LatLng(observations[i].latitude,observations[i].longitude),zoom),distance=Math.sqrt(Math.pow(mousePx.x-obsPx.x,2)+Math.pow(mousePx.y-obsPx.y,2));if(10>distance)return this._allObsMarker.setLatLng(new google.maps.LatLng(observations[i].latitude,observations[i].longitude)),this._allObsMarker._observation=observations[i],this._allObsMarker.show(),void 0;this._allObsMarker._observation=null,this._allObsMarker.setVisible(!1)}},"undefined"==typeof iNaturalist&&(this.iNaturalist={}),"undefined"==typeof iNaturalist.Map&&(this.iNaturalist.Map={}),iNaturalist.Map.createMap=function(options){options=options||{},options=$.extend({},{div:"map",center:new google.maps.LatLng(options.lat||0,options.lng||0),zoom:1,minZoom:1,mapTypeId:google.maps.MapTypeId.TERRAIN,streetViewControl:!1,observationsTileServer:"http://localhost:8000"},options);var map;if(map="string"==typeof options.div?new google.maps.Map(document.getElementById(options.div),options):new google.maps.Map(options.div,options),map.controls[google.maps.ControlPosition.TOP_RIGHT].push(new iNaturalist.FullScreenControl(map)),map.controls[google.maps.ControlPosition.TOP_RIGHT].push(new iNaturalist.DragDropShapeControl(map)),map._observationsTileServer=options.observationsTileServer,options.bounds)if("function"==typeof options.bounds.getCenter)map.setBounds(options.bounds);else{var bounds=new google.maps.LatLngBounds(new google.maps.LatLng(options.bounds.swlat,options.bounds.swlng),new google.maps.LatLng(options.bounds.nelat,options.bounds.nelng));map.fitBounds(bounds)}return map},iNaturalist.Map.createPlaceIcon=function(options){var options=options||{},iconPath="http://natusfera.gbif.es/assets/mapMarkers/mm_34_stemless_";iconPath+=options.color?options.color:"DeepPink",options.character&&(iconPath+="_"+options.character),iconPath+=".png";var place=new google.maps.MarkerImage(iconPath);return place.size=new google.maps.Size(20,20),place.anchor=new google.maps.Point(10,10),place},iNaturalist.Map.createObservationIcon=function(options){if("undefined"==typeof options)var options={};var iconPath;if(options.observation){var iconSet=options.observation.coordinates_obscured?"STEMLESS_ICONS":"ICONS",iconicTaxonIconsSet=options.observation.coordinates_obscured?"STEMLESS_ICONIC_TAXON_ICONS":"ICONIC_TAXON_ICONS",iconicTaxonName=options.observation.iconic_taxon_name;return!iconicTaxonName&&options.observation.iconic_taxon&&(iconicTaxonName=options.observation.iconic_taxon.name),iconPath=iconicTaxonName?iNaturalist.Map[iconicTaxonIconsSet][iconicTaxonName]:iNaturalist.Map[iconSet].unknown34}return iconPath="http://natusfera.gbif.es/assets/mapMarkers/mm_34_",iconPath+=options.stemless?"stemless_":"",iconPath+=options.color||"HotPink",iconPath+=options.character?"_"+options.character:"",iconPath+=".png"},iNaturalist.Map.obsTilePointsURL=function(x,y,zoom){return"/observations/tile_points/"+zoom+"/"+x+"/"+y+".json"},iNaturalist.Map.buildObservationsMapType=function(map){var tileUrlTemplate=map._observationsTileServer?map._observationsTileServer+"/{Z}/{X}/{Y}.png":"http://localhost:8000/{Z}/{X}/{Y}.png";return new google.maps.ImageMapType({getTileUrl:function(tilePoint,zoom){var tileUrl=tileUrlTemplate;return tileUrl=tileUrl.replace("{Z}",zoom).replace("{X}",tilePoint.x).replace("{Y}",tilePoint.y)},tileSize:new google.maps.Size(256,256),isPng:!0,name:"Observations"})},iNaturalist.Map.distanceInMeters=function(lat1,lon1,lat2,lon2){var earthRadius=6370997,degreesPerRadian=57.2958,dLat=(lat2-lat1)/degreesPerRadian,dLon=(lon2-lon1)/degreesPerRadian,lat1=lat1/degreesPerRadian,lat2=lat2/degreesPerRadian,a=Math.sin(dLat/2)*Math.sin(dLat/2)+Math.sin(dLon/2)*Math.sin(dLon/2)*Math.cos(lat1)*Math.cos(lat2),c=2*Math.atan2(Math.sqrt(a),Math.sqrt(1-a)),d=earthRadius*c;return d},iNaturalist.DragDropShapeControl=function(map){var controlDiv=$(document.createElement("div"));controlDiv[0].style.zIndex="1",controlDiv[0].style.padding="5px";var controlUI=$(document.createElement("div"));$(controlUI).addClass("ddUI"),$(controlUI).addClass("gmapv3control"),controlUI[0].style.textAlign="center",$(controlDiv).append(controlUI);var controlText=$(document.createElement("div"));return $(controlText).addClass("ddText"),$(controlText).addClass("gm-style"),controlText.prop("innerHTML","Drag shapefiles here!"),$(controlUI).append(controlText),zoomToShape=function(map){var bounds=new google.maps.LatLngBounds;map.data.forEach(function(feature){processPoints(feature.getGeometry(),bounds.extend,bounds)}),map.fitBounds(bounds)},processPoints=function(geometry,callback,thisArg){geometry instanceof google.maps.LatLng?callback.call(thisArg,geometry):geometry instanceof google.maps.Data.Point?callback.call(thisArg,geometry.get()):geometry.getArray().forEach(function(g){processPoints(g,callback,thisArg)})},loadGeoJsonString=function(geoString){var geojson=JSON.parse(geoString);map.data.addGeoJson(geojson),zoomToShape(map)},handleDragLeave=function(e){return e.stopPropagation(),e.preventDefault(),!1},handleDragOver=function(e){return e.stopPropagation(),e.preventDefault(),!1},handleDrop=function(e){e.preventDefault(),e.stopPropagation();var files=e.dataTransfer.files;if(files.length){for(var shape,file,db=null,i=0;file=files[i];i++)file.name.indexOf("dbf")>-1&&(db=file),file.name.indexOf("shp")>-1&&(shape=file);db&&shape?new Shapefile({shp:shape,dbf:db},function(data){var jsonString=JSON.stringify(data.geojson);loadGeoJsonString(jsonString)}):!db&&shape&&new Shapefile({shp:shape},function(data){var jsonString=JSON.stringify(data.geojson);loadGeoJsonString(jsonString)})}else{var plainText=e.dataTransfer.getData("text/plain");plainText&&loadGeoJsonString(plainText)}return!1},controlDiv[0].addEventListener("dragover",handleDragOver,!1),controlDiv[0].addEventListener("drop",handleDrop,!1),controlDiv[0].addEventListener("dragleave",handleDragLeave,!1),controlDiv[0]},iNaturalist.FullScreenControl=function(map){var controlDiv=document.createElement("DIV"),enter='<span class="ui-icon ui-icon-extlink">Full screen</span>',exit='<span class="ui-icon ui-icon-arrow-1-sw inlineblock"></span> '+I18n.t("exit_full_screen");controlDiv.style.padding="5px";var controlUI=$("<div></div>").html(enter).addClass("gmapv3control");controlDiv.appendChild(controlUI.get(0));var exitFullScreen=function(){var oldCenter=map.getCenter();$(this).html(enter).css("font-weight","normal"),$(map.getDiv()).removeClass("fullscreen"),google.maps.event.trigger(map,"resize"),map.setCenter(oldCenter)};window.fullscreenEscapeHandler=function(e){27===e.keyCode&&controlUI.click(),$(document).unbind("keyup",window.fullscreenEscapeHandler)};var enterFullScreen=function(){var oldCenter=map.getCenter();$(this).html(exit).css("font-weight","bold"),$(map.getDiv()).addClass("fullscreen"),google.maps.event.trigger(map,"resize"),map.setCenter(oldCenter),$(document).bind("keyup",window.fullscreenEscapeHandler)};return controlUI.toggle(enterFullScreen,exitFullScreen),controlDiv},iNaturalist.OverlayControl=function(map,options){options=options||{};var controlDiv=options.div||document.createElement("DIV");controlDiv.style.padding="5px";var controlUI=$("<div>"+I18n.t("taxon_map.overlays")+"</div>").addClass("gmapv3control overlaycontrol"),controlUI=$('<div><span class="ui-icon inat-icon ui-icon-layers">'+I18n.t("taxon_map.overlays")+"</span></div>").addClass("gmapv3control overlaycontrol"),ul=$("<ul></ul>").addClass("inat-overlay").hide();if(controlUI.append(ul),controlUI.hover(function(){$(this).addClass("open"),$("ul",this).show(),$(this).parent().css("z-index",1)},function(){$(this).removeClass("open"),$("ul",this).hide(),$(this).parent().css("z-index",0)}),controlDiv.appendChild(controlUI.get(0)),this.div=controlDiv,this.map=map,map.overlays)for(var i=0;i<map.overlays.length;i++)this.addOverlay(map.overlays[i]);return this},iNaturalist.OverlayControl.prototype.addWindshaftOverlayControl=function(layers,options){if(_.isArray(layers)&&0!==layers.length){var map=this.map,ul=$("ul",this.div),id="layer_"+layers[0].layerID,title=options.title||"Layer",description=options.description,checkbox=$("<input type='checkbox'/>"),label=$("<label/>").attr("for",id).html(title),li=$("<li/>");checkbox.attr("id",id).attr("name",title).attr("checked",!options.disabled),li.append(checkbox,label),checkbox.click(function(){var checked=this.checked;_.each(layers,function(layerData){map.overlayMapTypes.setAt(layerData.layerID-1,checked?layerData.layer:null)})}),description&&li.append($("<div/>").addClass("small meta").html(description)),ul.append(li),map._overlayControlDisplayed||(map.controls[google.maps.ControlPosition.TOP_RIGHT].push(map._overlayControl.div),map._overlayControlDisplayed=!0)}},iNaturalist.OverlayControl.prototype.addOverlay=function(lyr){var map=this.map,ul=$("ul",this.div);name=lyr.name,id=lyr.id||name,overlay=lyr.overlay,checkbox=$('<input type="checkbox"></input>'),label=$("<label></label>").attr("for",id).html(name),li=$("<li></li>"),checkbox.attr("id",id).attr("name",name).attr("checked",overlay.getMap()),checkbox.click(function(){var name=$(this).attr("name"),overlay=map.getOverlay(name).overlay;overlay.setMap(overlay.getMap()?null:map)}),li.append(checkbox,label),lyr.description&&li.append($("<div></div>").addClass("small meta").html(lyr.description)),ul.append(li)},google.maps.Map.prototype.addOverlay=function(name,overlay,options){options=options||{},this.overlays=this.overlays||[];var overlayOpts={name:name,overlay:overlay,id:options.id,description:options.description};this.overlays.push(overlayOpts),overlay.setMap&&!options.hidden&&overlay.setMap(this),this._overlayControl&&this._overlayControl.addOverlay(overlayOpts)},google.maps.Map.prototype.removeOverlay=function(name){if(this.overlays)for(var i=0;i<this.overlays.length;i++)this.overlays[i].name==name&&(this.overlays[i].overlay.setMap(null),this.overlays.splice(i))},google.maps.Map.prototype.getOverlay=function(name){if(this.overlays)for(var i=0;i<this.overlays.length;i++)if(this.overlays[i].name==name)return this.overlays[i]},google.maps.Map.prototype.addPlaceLayer=function(options){this.setTilt(0);var options=options||{},tiles_url=options.tiles_url||"http://193.146.75.173:4000",placeTileUrl=tiles_url+"/places/"+options.place.id+"/{z}/{x}/{y}.png",tilejson={tiles:[placeTileUrl]};return this.addLayerAndControl(tilejson,_.extend(options,{description:options.place.name}))},google.maps.Map.prototype.addTaxonRangeLayer=function(options){this.setTilt(0);var options=options||{},tiles_url=options.tiles_url||"http://193.146.75.173:4000",rangeTileUrl=tiles_url+"/taxon_ranges/"+options.taxon.id+"/{z}/{x}/{y}.png",tilejson={tiles:[rangeTileUrl]};return this.addLayerAndControl(tilejson,options)},google.maps.Map.prototype.addLayerAndControl=function(tilejson,options){options=options||{};var layer=new wax.g.connector(tilejson),layerID=this.overlayMapTypes.push(layer);return this._overlayControl&&this._overlayControl.addWindshaftOverlayControl([{layer:layer,layerID:layerID}],options),layerID},google.maps.Map.prototype.addObservationsLayer=function(options){this.setTilt(0),options.color&&(options.grid_color=null,options.point_color=null);var options=options||{},tiles_url=options.tiles_url||"http://193.146.75.173:4000",gridTileUrl=tiles_url+"/observations/grid/{z}/{x}/{y}.png",pointTileUrl=tiles_url+"/observations/points/{z}/{x}/{y}.png",gridmaxzoom=options.gridmaxzoom||9,gridParamKeys=["taxon_id","user_id","place_id","project_id","ttl","color","opacity","border_opacity"],pointParamKeys=gridParamKeys.concat(["observation_id"]),gridParams={},pointParams={};_.each(options,function(value,key){gridKey=key.replace("grid_",""),pointKey=key.replace("point_",""),_.contains(gridParamKeys,gridKey)&&(gridParams[gridKey]=value),_.contains(pointParamKeys,pointKey)&&(pointParams[pointKey]=value)}),gridParams&&(gridTileUrl+="?"+$.param(gridParams)),pointParams&&(pointTileUrl+="?"+$.param(pointParams)),gridLayer=this.addTileLayer(gridTileUrl,{maxzoom:gridmaxzoom,interactivity:!1,disabled:options.disabled}),pointLayer=this.addTileLayer(pointTileUrl,{interactivity:options.interactivity===!1?!1:"id,taxon_id,species_guess,latitude,longitude,positional_accuracy,captive,quality_grade,iconic_taxon_id",minzoom:gridmaxzoom+1,gridminzoom:gridmaxzoom+1,disabled:options.disabled}),this._overlayControl&&this._overlayControl.addWindshaftOverlayControl([gridLayer,pointLayer],options)},google.maps.Map.prototype.getInfoWindow=function(){return this.infoWindow||(this.infoWindow=new google.maps.InfoWindow({content:$('<div class="loading status">'+I18n.t("loading")+"</div>").get(0),position:new google.maps.LatLng(0,0)})),this.infoWindow},google.maps.Map.prototype.addTileLayer=function(tileURL,options){var options=options||{};options.interactivity,options.interactivity&&(options.grids=[this.interactivityURL(tileURL,options.interactivity)]);var tilejson=$.extend(!0,{},{tiles:[tileURL],template:"{{species_guess}}"},options),layer=new wax.g.connector(tilejson),layerID=this.overlayMapTypes.push(layer);return options.disabled&&this.overlayMapTypes.setAt(layerID-1,null),options.interactivity&&this.addTileInteractivity(tilejson),{layer:layer,layerID:layerID}},google.maps.Map.prototype.interactivityURL=function(tileURL,interactivity){return utfgridURL=tileURL.replace(/\.png/,".grid.json"),utfgridURL+=utfgridURL.indexOf("?")<0?"?":"&",utfgridURL+"interactivity="+interactivity},google.maps.Map.prototype.addTileInteractivity=function(tilejson){var map=this;wax.g.interaction().map(map).tilejson(tilejson).on({on:function(o){if(document.body.style.cursor="pointer","click"==o.e.type){if($(".gm-style-iw").parent().find(o.e.target).length>0)return!1;if(o.data.latitude){var latLng=new google.maps.LatLng(o.data.latitude,o.data.longitude);$.ajax({url:"/observations/"+o.data.id+".html?partial=cached_component",type:"GET",dataType:"html",beforeSend:function(){var iw=map.getInfoWindow();iw.position=latLng,iw.content=$('<div class="loading status">'+I18n.t("loading")+"</div>").get(0),iw.open(map),deselectText()},success:function(data){var iw=map.getInfoWindow();iw.position=latLng,iw.content=$('<div class="compact mini infowindow observations"></div>').append(data).get(0),iw.open(map),$(iw).focus(),deselectText()},error:function(jqXHR,textStatus){console.log(textStatus)}})}}else"mousemove"==o.e.type&&map.setOptions({draggableCursor:"pointer"})},off:function(){map.setOptions({draggableCursor:"url(http://maps.google.com/mapfiles/openhand.cur), move"})}})},iNaturalist.Map.ICONS={DodgerBlue34:new google.maps.MarkerImage("http://natusfera.gbif.es/assets/mapMarkers/mm_34_DodgerBlue.png"),DeepPink34:new google.maps.MarkerImage("http://natusfera.gbif.es/assets/mapMarkers/mm_34_DeepPink.png"),iNatGreen34:new google.maps.MarkerImage("http://natusfera.gbif.es/assets/mapMarkers/mm_34_iNatGreen.png"),OrangeRed34:new google.maps.MarkerImage("http://natusfera.gbif.es/assets/mapMarkers/mm_34_OrangeRed.png"),DarkMagenta34:new google.maps.MarkerImage("http://natusfera.gbif.es/assets/mapMarkers/mm_34_DarkMagenta.png"),unknown34:new google.maps.MarkerImage("http://natusfera.gbif.es/assets/mapMarkers/mm_34_unknown.png"),ChromistaBrown34:new google.maps.MarkerImage("http://natusfera.gbif.es/assets/mapMarkers/mm_34_ChromistaBrown.png")},iNaturalist.Map.STEMLESS_ICONS={DodgerBlue34:new google.maps.MarkerImage("http://natusfera.gbif.es/assets/mapMarkers/mm_34_stemless_DodgerBlue.png"),DeepPink34:new google.maps.MarkerImage("http://natusfera.gbif.es/assets/mapMarkers/mm_34_stemless_DeepPink.png"),iNatGreen34:new google.maps.MarkerImage("http://natusfera.gbif.es/assets/mapMarkers/mm_34_stemless_iNatGreen.png"),OrangeRed34:new google.maps.MarkerImage("http://natusfera.gbif.es/assets/mapMarkers/mm_34_stemless_OrangeRed.png"),DarkMagenta34:new google.maps.MarkerImage("http://natusfera.gbif.es/assets/mapMarkers/mm_34_stemless_DarkMagenta.png"),unknown34:new google.maps.MarkerImage("http://natusfera.gbif.es/assets/mapMarkers/mm_34_stemless_unknown.png"),ChromistaBrown34:new google.maps.MarkerImage("http://natusfera.gbif.es/assets/mapMarkers/mm_34_stemless_ChromistaBrown.png")},iNaturalist.Map.ICONIC_TAXON_ICONS={Protozoa:iNaturalist.Map.ICONS.DarkMagenta34,Animalia:iNaturalist.Map.ICONS.DodgerBlue34,Plantae:iNaturalist.Map.ICONS.iNatGreen34,Fungi:iNaturalist.Map.ICONS.DeepPink34,Amphibia:iNaturalist.Map.ICONS.DodgerBlue34,Reptilia:iNaturalist.Map.ICONS.DodgerBlue34,Aves:iNaturalist.Map.ICONS.DodgerBlue34,Mammalia:iNaturalist.Map.ICONS.DodgerBlue34,Actinopterygii:iNaturalist.Map.ICONS.DodgerBlue34,Mollusca:iNaturalist.Map.ICONS.OrangeRed34,Insecta:iNaturalist.Map.ICONS.OrangeRed34,Arachnida:iNaturalist.Map.ICONS.OrangeRed34,Chromista:iNaturalist.Map.ICONS.ChromistaBrown34},iNaturalist.Map.STEMLESS_ICONIC_TAXON_ICONS={Protozoa:iNaturalist.Map.STEMLESS_ICONS.DarkMagenta34,Animalia:iNaturalist.Map.STEMLESS_ICONS.DodgerBlue34,Plantae:iNaturalist.Map.STEMLESS_ICONS.iNatGreen34,Fungi:iNaturalist.Map.STEMLESS_ICONS.DeepPink34,Amphibia:iNaturalist.Map.STEMLESS_ICONS.DodgerBlue34,Reptilia:iNaturalist.Map.STEMLESS_ICONS.DodgerBlue34,Aves:iNaturalist.Map.STEMLESS_ICONS.DodgerBlue34,Mammalia:iNaturalist.Map.STEMLESS_ICONS.DodgerBlue34,Actinopterygii:iNaturalist.Map.STEMLESS_ICONS.DodgerBlue34,Mollusca:iNaturalist.Map.STEMLESS_ICONS.OrangeRed34,Insecta:iNaturalist.Map.STEMLESS_ICONS.OrangeRed34,Arachnida:iNaturalist.Map.STEMLESS_ICONS.OrangeRed34,Chromista:iNaturalist.Map.STEMLESS_ICONS.ChromistaBrown34},iNaturalist.Map.ICONIC_TAXON_COLORS={Protozoa:"#8B008B",Animalia:"#1E90FF",Plantae:"#73AC13",Fungi:"#FF1493",Amphibia:"#1E90FF",Reptilia:"#1E90FF",Aves:"#1E90FF",Mammalia:"#1E90FF",Actinopterygii:"#1E90FF",Mollusca:"#FF4500",Insecta:"#FF4500",Arachnida:"#FF4500",Chromista:"#993300"}}(),$(document).ready(function(){$(".iconic_taxon_filter input").change(function(){$(this).siblings("label").toggleClass("selected")}),$(".iconic_taxon_filter input:checked").each(function(){$(this).siblings("label").addClass("selected")})}),/*
 * jQuery Labelize Plugin (jQuery >= 1.2.2)
 *
 * This work is distributed under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 *
 * Copyright 2008, Ben Vinegar [ ben ! benlog dot org ]
 *
 * Usage:
 *
 * $('.myLabel').labelize()
 *
 */
function($){$.fn.labelize=function(hoverClass){function labelClickEvent(){$(this).unbind("click",labelClickEvent),$("input",this).click(),$(this).click(labelClickEvent)}var containers=$(this).filter(":has(input)");return $(containers).css("cursor","pointer").click(labelClickEvent),hoverClass&&containers.mouseover(function(){$(this).addClass(hoverClass)}).mouseout(function(){$(this).removeClass(hoverClass)}),$("input",this).mouseover(function(){$(containers).unbind("click",labelClickEvent)}).mouseout(function(){$(containers).click(labelClickEvent)}),this}}(jQuery),$.fn.check=function(){this.each(function(){this.checked=!0})},$.fn.uncheck=function(){this.each(function(){this.checked=!1})},$.fn.toggleCheck=function(){this.each(function(){this.checked=this.checked?!1:!0})};