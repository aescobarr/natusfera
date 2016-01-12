var inatTaxonMap={};!function($){$.fn.taxonMap=function(options){options=options||{},$(this).each(function(){"fit"==options?inatTaxonMap.fit(this):inatTaxonMap.setup(this,options)})}}(jQuery),inatTaxonMap.setup=function(elt,options){var options=$.extend({},options);options.taxon=$(elt).data("taxon"),options.latitude=options.latitude||$(elt).data("latitude"),options.longitude=options.longitude||$(elt).data("longitude"),options.mapType=$(elt).data("map-type"),options.zoomLevel=parseInt($(elt).data("zoom-level")),options.gbifKmlUrl=$(elt).data("gbif-kml"),options.showRange=$(elt).data("show-range"),options.place=$(elt).data("place"),options.minX=$(elt).data("min-x"),options.minY=$(elt).data("min-y"),options.maxX=$(elt).data("max-x"),options.maxY=$(elt).data("max-y"),options.flagLetters=$(elt).data("flag-letters"),options.windshaftProjectID=$(elt).data("windshaft-project-id"),options.windshaftUserID=$(elt).data("windshaft-user-id"),options.observations=options.observations||$(elt).data("observations"),options.mapTypeControl=$(elt).data("map-type-control"),options.showAllLayer=options.showAllLayer||$(elt).data("show-all-layer")||!0,options.featuredLayerLabel=options.featuredLayerLabel||$(elt).data("featured-layer-label"),options.placeLayerLabel=options.placeLayerLabel||$(elt).data("place-layer-label"),options.taxonRangeLayerLabel=options.taxonRangeLayerLabel||$(elt).data("taxon-range-layer-label"),options.taxonRangeLayerDescription=options.taxonRangeLayerDescription||$(elt).data("taxon-range-layer-description"),options.allLayerLabel=options.allLayerLabel||$(elt).data("all-layer-label"),options.allLayerDescription=options.allLayerDescription||$(elt).data("all-layer-description"),options.observations&&(options.observations=_.map(options.observations,function(observation){return jQuery.parseJSON(observation)})),""===options.gbifKmlUrl&&(options.gbifKmlUrl=null),0===options.zoomLevel&&(options.zoomLevel=null),$(elt).data("taxonMapOptions",options),inatTaxonMap.setupGoogle(elt)},inatTaxonMap.fit=function(elt){inatTaxonMap.fitGoogle(elt)},inatTaxonMap.setupGoogle=function(elt){var options=$(elt).data("taxonMapOptions"),map=iNaturalist.Map.createMap({div:elt,mapTypeControl:options.mapTypeControl!==!1}),preserveViewport=options.preserveViewport;options.minX?(map.fitBounds(new google.maps.LatLngBounds(new google.maps.LatLng(options.minY,options.minX),new google.maps.LatLng(options.maxY,options.maxX))),preserveViewport=!0):((options.latitude||options.longitude)&&map.setCenter(new google.maps.LatLng(options.latitude||0,options.longitude||0)),options.zoomLevel&&map.setZoom(options.zoomLevel)),options.mapType&&map.setMapTypeId(options.mapType),map._overlayControl=new iNaturalist.OverlayControl(map),options.showAllLayer&&map.addObservationsLayer({title:options.allLayerLabel,description:options.allLayerDescription,disabled:"enabled"!==options.showAllLayer,ttl:86400}),options.showRange&&options.taxon&&map.addTaxonRangeLayer({taxon:options.taxon,title:options.taxonRangeLayerLabel,description:options.taxonRangeLayerDescription}),options.place&&map.addPlaceLayer({place:options.place,title:options.placeLayerLabel});var windshaftOptions={};options.taxon&&(windshaftOptions.taxon_id=options.taxon.id),options.windshaftUserID&&(windshaftOptions.user_id=options.windshaftUserID),options.windshaftProjectID&&(windshaftOptions.project_id=options.windshaftProjectID),_.isEmpty(windshaftOptions)||(options.observations&&(windshaftOptions.point_observation_id=_.map(options.observations,function(o){return o.id}).join(",")),windshaftOptions.title=options.featuredLayerLabel,map.addObservationsLayer(windshaftOptions)),inatTaxonMap.addObservationsToMap(options,map,preserveViewport),inatTaxonMap.addGBIFKml(options,map),preserveViewport||inatTaxonMap.fit(elt),$(elt).data("taxonMap",map)},inatTaxonMap.addGBIFKml=function(options,map){if(options.gbifKmlUrl){var gbifLyr=new google.maps.KmlLayer(options.gbifKmlUrl,{suppressInfoWindows:!0,preserveViewport:!0});map.addOverlay(I18n.t("taxon_map.gbif_occurrences"),gbifLyr,{id:"gbif-"+options.taxon.id,hidden:!0,description:I18n.t("taxon_map.it_may_take_google_a_while_to")+' <a target="_blank" href="'+options.gbifKmlUrl.replace(/&format=kml/,"")+'">'+I18n.t("taxon_map.data_url")+"</a>"}),google.maps.event.addListener(gbifLyr,"click",function(e){window.kmlInfoWindows||(window.kmlInfoWindows={});for(var k in window.kmlInfoWindows)window.kmlInfoWindows[k].close();var win=window.kmlInfoWindows[e.featureData.id];if(!win){var content=(e.featureData.description||"").replace(/(<a.+?>)<a.+?>(.+?)<\/a><\/a>/g,"$1$2</a>");content=content.replace(/&lt;\/a/g,""),content=content.replace(/&gt;/g,""),content=content.replace(/<\/a"/g,'"'),win=window.kmlInfoWindows[e.featureData.id]=new google.maps.InfoWindow({content:content,position:e.latLng,pixelOffset:e.pixelOffset})}return win.open(map),!1})}},inatTaxonMap.addObservationsToMap=function(options,map,preserveViewport){if(options.observations){var letter_counter=0,letters="ABCDEFGHIJKLMNOPQRSTUVWXYZ";if(iNaturalist.Map.createObservationIcon({color:"HotPink"}),iNaturalist.Map.createObservationIcon({color:"DeepPink"}),_.each(options.observations,function(o){var icon_div=$("#observation-"+o.id+" .icon").get(0);if(!(o.latitude&&o.longitude||o.private_latitude&&o.private_longitude)&&options.appendMarkerToList){var icon_img=$('<img src="http://natusfera.gbif.es/assets/mapMarkers/questionmarker.png"/>');return $(icon_div).text("").append(icon_img),void 0}if(observationOptions={clickable:options.clickable,showAccuracy:options.showAccuracy},options.flagLetters&&(observationOptions.icon=iNaturalist.Map.createObservationIcon({color:"HotPink",character:letters[letter_counter],stemless:o.coordinates_obscured})),map.addObservation(o,observationOptions),!o.map_scale&&o.positional_accuracy&&new google.maps.Circle({center:new google.maps.LatLng(o.latitude,o.longitude),radius:10*o.positional_accuracy}),options.appendMarkerToList&&o.marker){o.marker;var src=o.marker.getIcon();src.url&&(src=src.url);var icon_img=$("<img/>").attr("src",src).addClass("marker");$(icon_div).text("").append(icon_img),$(icon_img).click(function(){map.openInfoWindow.apply(o.marker)})}letter_counter++}),!preserveViewport)if(1===options.observations.length){o=options.observations[0];var center=new google.maps.LatLng(o.private_latitude||o.latitude,o.private_longitude||o.longitude);map.setCenter(center)}else map.zoomToObservations()}},inatTaxonMap.fitGoogle=function(elt){var options=$(elt).data("taxonMapOptions"),map=$(elt).data("taxonMap");if(map){if(options.minX)return map.fitBounds(new google.maps.LatLngBounds(new google.maps.LatLng(options.minY,options.minX),new google.maps.LatLng(options.maxY,options.maxX))),void 0;map.setCenter(new google.maps.LatLng(0,0)),map.setZoom(1)}};