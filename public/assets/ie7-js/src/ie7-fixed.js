!new function(_){function _fixBackground(){"fixed"!=body.currentStyle.backgroundAttachment&&("none"==body.currentStyle.backgroundImage&&(body.runtimeStyle.backgroundRepeat="no-repeat",body.runtimeStyle.backgroundImage="url("+BLANK_GIF+")"),body.runtimeStyle.backgroundAttachment="fixed"),_fixBackground=Undefined}function _isFixed(element){return element?isFixed(element)||_isFixed(element.parentElement):!1}function _setExpression(element,propertyName,expression){setTimeout("document.all."+element.uniqueID+".runtimeStyle.setExpression('"+propertyName+"','"+expression+"')",0)}function _backgroundFixed(element){register(_backgroundFixed,element,"fixed"==element.currentStyle.backgroundAttachment&&!element.contains(body))&&(_fixBackground(),bgLeft(element),bgTop(element),_backgroundPosition(element))}function _backgroundPosition(element){_tmp.src=element.currentStyle.backgroundImage.slice(5,-2);var parentElement=element.canHaveChildren?element:element.parentElement;parentElement.appendChild(_tmp),setOffsetLeft(element),setOffsetTop(element),parentElement.removeChild(_tmp)}function bgLeft(element){element.style.backgroundPositionX=element.currentStyle.backgroundPositionX,_isFixed(element)||_setExpression(element,"backgroundPositionX","(parseInt(runtimeStyle.offsetLeft)+document."+$viewport+".scrollLeft)||0")}function setOffsetLeft(element){var propertyName=_isFixed(element)?"backgroundPositionX":"offsetLeft";element.runtimeStyle[propertyName]=getOffsetLeft(element,element.style.backgroundPositionX)-element.getBoundingClientRect().left-element.clientLeft+2}function getOffsetLeft(element,position){switch(position){case"left":case"top":return 0;case"right":case"bottom":return viewport.clientWidth-_tmp.offsetWidth;case"center":return(viewport.clientWidth-_tmp.offsetWidth)/2;default:return PERCENT.test(position)?parseInt((viewport.clientWidth-_tmp.offsetWidth)*parseFloat(position)/100):(_tmp.style.left=position,_tmp.offsetLeft)}}function _positionFixed(element){register(_positionFixed,element,isFixed(element))&&(setOverrideStyle(element,"position","absolute"),setOverrideStyle(element,"left",element.currentStyle.left),setOverrideStyle(element,"top",element.currentStyle.top),_fixBackground(),IE7.Layout.fixRight(element),_foregroundPosition(element))}function _foregroundPosition(element,recalc){if(positionTop(element,recalc),positionLeft(element,recalc,!0),!element.runtimeStyle.autoLeft&&"auto"==element.currentStyle.marginLeft&&"auto"!=element.currentStyle.right){var left=viewport.clientWidth-getPixelWidth(element,element.currentStyle.right)-getPixelWidth(element,element.runtimeStyle._left)-element.clientWidth;"auto"==element.currentStyle.marginRight&&(left=parseInt(left/2)),_isFixed(element.offsetParent)?element.runtimeStyle.pixelLeft+=left:element.runtimeStyle.shiftLeft=left}clipWidth(element),clipHeight(element)}function clipWidth(element){var fixWidth=element.runtimeStyle.fixWidth;if(element.runtimeStyle.borderRightWidth="",element.runtimeStyle.width=fixWidth?getPixelWidth(element,fixWidth):"","auto"!=element.currentStyle.width){var rect=element.getBoundingClientRect(),width=element.offsetWidth-viewport.clientWidth+rect.left-2;if(width>=0)return element.runtimeStyle.borderRightWidth="0px",width=Math.max(getPixelValue(element,element.currentStyle.width)-width,0),setOverrideStyle(element,"width",width),width}}function positionLeft(element,recalc){!recalc&&PERCENT.test(element.currentStyle.width)&&(element.runtimeStyle.fixWidth=element.currentStyle.width),element.runtimeStyle.fixWidth&&(element.runtimeStyle.width=getPixelWidth(element,element.runtimeStyle.fixWidth)),element.runtimeStyle.shiftLeft=0,element.runtimeStyle._left=element.currentStyle.left,element.runtimeStyle.autoLeft="auto"!=element.currentStyle.right&&"auto"==element.currentStyle.left,element.runtimeStyle.left="",element.runtimeStyle.screenLeft=getScreenLeft(element),element.runtimeStyle.pixelLeft=element.runtimeStyle.screenLeft,recalc||_isFixed(element.offsetParent)||_setExpression(element,"pixelLeft","runtimeStyle.screenLeft+runtimeStyle.shiftLeft+document."+$viewport+".scrollLeft")}function getScreenLeft(element){var screenLeft=element.offsetLeft,nested=1;for(element.runtimeStyle.autoLeft&&(screenLeft=viewport.clientWidth-element.offsetWidth-getPixelWidth(element,element.currentStyle.right)),"auto"!=element.currentStyle.marginLeft&&(screenLeft-=getPixelWidth(element,element.currentStyle.marginLeft));element=element.offsetParent;)"static"!=element.currentStyle.position&&(nested=-1),screenLeft+=element.offsetLeft*nested;return screenLeft}function getPixelWidth(element,value){return PERCENT.test(value)?parseInt(parseFloat(value)/100*viewport.clientWidth):getPixelValue(element,value)}function _resize(){var elements=_backgroundFixed.elements;for(var i in elements)_backgroundPosition(elements[i]);elements=_positionFixed.elements;for(i in elements)_foregroundPosition(elements[i],!0),_foregroundPosition(elements[i],!0);_timer=0}if(!(appVersion>=7)){IE7.CSS.addRecalc("position","fixed",_positionFixed,"absolute"),IE7.CSS.addRecalc("background(-attachment)?","[^};]*fixed",_backgroundFixed);var $viewport=quirksMode?"body":"documentElement",_tmp=createTempElement("img");eval(rotate(bgLeft)),eval(rotate(setOffsetLeft)),eval(rotate(getOffsetLeft)),eval(rotate(clipWidth)),eval(rotate(positionLeft)),eval(rotate(getScreenLeft)),eval(rotate(getPixelWidth));var _timer;addResize(function(){_timer||(_timer=setTimeout(_resize,0))})}};