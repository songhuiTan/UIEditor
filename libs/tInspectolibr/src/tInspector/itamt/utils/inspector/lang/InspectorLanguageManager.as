//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.lang {
    import flash.system.*;

    public class InspectorLanguageManager {

        private static var lang:Lang;

        public static function setLanguage(n:Lang):void{
            lang = n;
        }
        public static function getStr(str:String):String{
            if (lang == null){
                switch (Capabilities.language){
                    case "zh-CN":
                    case "zh-TW":
                        lang = new CN();
                        break;
                    default:
                        lang = new EN();
                };
            };
            return (lang.getTipValueString(str));
        }
        public static function getLanguage():String{
            var ret:String = "en";
            switch (Capabilities.language){
                case "zh-CN":
                case "zh-TW":
                    ret = "cn";
                    break;
                default:
                    ret = "en";
            };
            return (ret);
        }

    }
}//package cn.itamt.utils.inspector.lang 
