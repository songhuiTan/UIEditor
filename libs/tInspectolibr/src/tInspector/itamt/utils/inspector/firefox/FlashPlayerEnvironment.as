//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.firefox {
    import flash.external.*;
    import tInspector.itamt.utils.*;
    import flash.geom.*;
    import flash.system.*;

    public class FlashPlayerEnvironment {

        private static var _swfId:String;

        public static function get swfId():String{
            if (_swfId == null){
                return (ExternalInterface.objectID);
            };
            return (_swfId);
        }
        public static function set swfId(val:String):void{
            _swfId = val;
        }
        public static function getAllowFullScreen():Boolean{
            var allowFullScreen:Boolean;
            var attr:Object;
            if (ExternalInterface.available){
                attr = getSwfObjectAttributes();
                if (attr != null){
                    allowFullScreen = (attr["allowfullscreen"] == "true");
                };
            } else {
                allowFullScreen = true;
            };
            return (allowFullScreen);
        }
        public static function getSwfObjectAttributes():Object{
            var attribute:* = null;
            var prop:* = null;
            Debug.trace("[FlashPlayerEnvironment][getSwfObjectAttributes]");
            var tmpXML:* = <xml><![CDATA[
			function(){
				/**
				var eles = document.embeds.concat(document.getElementsByTagName("object"));
				var swf;
				if(eles.length == 1){
					swf = eles[0];
				}else{
					for(var i=0; i<eles.length; i++){
						if(eles[i].type == "application/x-shockwave-flash"){
							if(eles[i].id == &SWFID& || eles[i].name==&SWFID&){
								swf = eles[i];
							}
						}
					}
				}
				*/
				
				var swf = document.getElementById(&SWFID&);
				
				var attrs = {};
				var str = "";
				if(swf){
					for(var i=0; i<swf.attributes.length; i++){
						attrs[swf.attributes[i].name.toLowerCase()] = swf.attributes[i].value;
						str += swf.attributes[i].name.toLowerCase() + ":" + swf.attributes[i].value + '\n';
					}
				}
				alert(str);
				
				return attrs;
			}
			]]></xml>
            ;
            var js:* = tmpXML.toString().replace(/&SWFID&/g, (("\"" + swfId) + "\""));
            if (ExternalInterface.available){
                try {
                    attribute = ExternalInterface.call(js);
                } catch(e:Error) {
                };
            };
            for (prop in attribute) {
                Debug.trace(((("[FlashPlayerEnvironment][getAllowFullScreen]" + prop) + ": ") + attribute[prop]));
            };
            return (attribute);
        }
        public static function getSwfSize():Rectangle{
            var size:Rectangle;
            var tmpXML:XML = <xml><![CDATA[
				function(){				
					var swf = document.getElementById(&SWFID&);
					var rect = {x:swf.offsetLeft, y:swf.offsetTop, width:swf.offsetWidth, height:swf.offsetHeight};
					return rect;
				}
			]]></xml>
            ;
            var js:String = tmpXML.toString().replace(/&SWFID&/g, (("\"" + swfId) + "\""));
            if (!(ExternalInterface.available)){
                return (null);
            };
            var rect:* = ExternalInterface.call(js);
            if (rect == null){
                return (null);
            };
            size = new Rectangle(rect.x, rect.y, rect.width, rect.height);
            return (size);
        }
        public static function setSwfSize(width:Number, height:Number):void{
            var tmpXML:XML = <xml><![CDATA[
			function(swfid, width, height){				
				var swf = document.getElementById(swfid);
				swf.setAttribute("width", width);				swf.setAttribute("height", height);
			}
			]]></xml>
            ;
            var js:String = tmpXML.toString();
            if (ExternalInterface.available){
                ExternalInterface.call(js, swfId, width, height);
            };
        }
        public static function getSwfBgColor():int{
            var res:String;
            var color:int = -1;
            var tmpXML:XML = <xml><![CDATA[
			function(swfid){				
				var swf = document.getElementById(swfid);
				if(swf.tagName == "OBJECT"){
					for(var i=0; i<swf.children.length; i++){
						if(swf.children[i].name == "bgcolor"){
							return swf.children[i].value;
						}
					}
					return "null";
				}else if(swf.tagName == "EMBED"){
					if(swf.getAttribute("bgcolor")){
						return swf.getAttribute("bgcolor");
					}else{
						return "null";
					}
				}
			}
			]]></xml>
            ;
            var js:String = tmpXML.toString();
            if (ExternalInterface.available){
                res = ExternalInterface.call(js, swfId);
                if (((res) && (!((res == "null"))))){
                    if (res.indexOf("#") > -1){
                        res = res.replace(/^\s+|\s+$/g, "");
                        res = res.replace(/#/g, "");
                    };
                    color = parseInt(res, 16);
                };
            };
            return (color);
        }
        public static function setSwfBgColor(color:uint):void{
            var colorStr:String;
            Debug.trace(("[FlashPlayerEnvironment][setSwfBgColor]" + color));
            var tmpXML:XML = <xml><![CDATA[
			function(swfid, colorStr){
				var swf = document.getElementById(swfid);
				if(swf.tagName == "OBJECT"){
					for(var i=0; i<swf.children.length; i++){
						if(swf.children[i].name == "bgcolor"){
							swf.children[i].value = colorStr;
						}
					}
					if(i == swf.children.length){
						var param = document.createElement("param");
						param.name = "bgcolor";
						param.value = colorStr;
						swf.appendChild(param);
					}
				}else if(swf.tagName == "EMBED"){
					swf.setAttribute("bgcolor", colorStr);
				}
			}
			]]></xml>
            ;
            var js:String = tmpXML.toString();
            if (ExternalInterface.available){
                colorStr = color.toString(16);
                while (colorStr.length < 6) {
                    colorStr = ("0" + colorStr);
                };
                ExternalInterface.call(js, swfId, ("#" + colorStr));
                ExternalInterface.call("fInspectorReloadSwf", FlashPlayerEnvironment.swfId);
            };
        }
        public static function isInFirefox():Boolean{
            var browser:* = "";
            if (ExternalInterface.available){
                try {
                    browser = ExternalInterface.call("function(){return navigator.userAgent.toLowerCase();}");
                } catch(e:Error) {
                };
            };
            return (((browser == null)) ? false : (browser.indexOf("firefox") >= 0));
        }
        public static function isDebugVersion():Boolean{
            return (Capabilities.isDebugger);
        }

    }
}//package cn.itamt.utils.inspector.firefox 
