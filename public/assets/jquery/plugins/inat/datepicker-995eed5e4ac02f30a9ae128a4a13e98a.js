!function($){$.datepicker._doKeyPress=function(){return!0},$.fn.iNatDatepicker=function(options){$(this).width($(this).width()-26),$(this).css({"margin-right":"10px","vertical-align":"middle"}),options=options||{},options=$.extend({},{showOn:"both",buttonImage:"http://natusfera.gbif.es/assets/silk/date-1bd0871bfda4d20defcfcd524f68036b.png",buttonImageOnly:!0,showButtonPanel:!0,showAnim:"fadeIn",yearRange:"c-100:c+0",maxDate:"+0d",constrainInput:!1,firstDay:0,changeFirstDay:!1,changeMonth:!0,changeYear:!0,dateFormat:"yy-mm-dd",timeFormat:"hh:mm tt z",showTimezone:!0,closeText:I18n.t("date_picker.closeText"),currentText:I18n.t("date_picker.currentText"),prevText:I18n.t("date_picker.prevText"),nextText:I18n.t("date_picker.nextText"),monthNames:eval(I18n.t("date_picker.monthNames")),monthNamesShort:eval(I18n.t("date_picker.monthNamesShort")),dayNames:eval(I18n.t("date_picker.dayNames")),dayNamesShort:eval(I18n.t("date_picker.dayNamesShort")),dayNamesMin:eval(I18n.t("date_picker.dayNamesMin"))},options),options.time?$(this).datetimepicker(options):$(this).datepicker(options),$(this).next(".ui-datepicker-trigger").css({"vertical-align":"middle"})}}(jQuery);