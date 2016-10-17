//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    
    import tInspector.itamt.utils.*;

    public class InspectorSymbolIcon {

        public static const UNKNOWN:String = "UNKNOWN";
        public static const SPRITE:String = "Sprite";
        public static const MOVIE_CLIP:String = "MovieClip";
        public static const BITMAP:String = "Bitmap";
        public static const SHAPE:String = "Shape";
        public static const TEXT_FIELD:String = "TextField";
        public static const LOADER:String = "Loader";
        public static const VIDEO:String = "Video";
        public static const AVM1_MOVIE:String = "AVM1Movie";
        public static const SWF:String = "AVM1Movie";
        public static const STATIC_TEXT:String = "StaticText";
        public static const MORPH_SHAPE:String = "MorphShape";
        public static const SIMPLE_BUTTON:String = "SimpleButton";
        public static const STAGE:String = "Stage";
        public static const EXPAND:String = "+";
        public static const CLLOAPSE:String = "-";
        public static const BUG:String = "bug";
        public static const FAVORITE:String = "favorite";
        public static const DELETE:String = "delete";
        public static const LOGO:String = "inspector_logo";
        public static const INSPECT:String = "inspector_inspect";
        public static const FOLDER:String = "folder";
        public static const HELP:String = "help";

        private static var assetBmd:InspectorSymbolBmd;
        private static var iconBmds:Array;
        private static var icons:Array = [InspectorSymbolIcon.UNKNOWN, InspectorSymbolIcon.SPRITE, InspectorSymbolIcon.MOVIE_CLIP, InspectorSymbolIcon.BITMAP, InspectorSymbolIcon.SHAPE, InspectorSymbolIcon.TEXT_FIELD, InspectorSymbolIcon.LOADER, InspectorSymbolIcon.VIDEO, InspectorSymbolIcon.AVM1_MOVIE, InspectorSymbolIcon.STATIC_TEXT, InspectorSymbolIcon.MORPH_SHAPE, InspectorSymbolIcon.SIMPLE_BUTTON, InspectorSymbolIcon.STAGE, InspectorSymbolIcon.EXPAND, InspectorSymbolIcon.CLLOAPSE, InspectorSymbolIcon.BUG, InspectorSymbolIcon.FAVORITE, InspectorSymbolIcon.DELETE, InspectorSymbolIcon.LOGO, InspectorSymbolIcon.INSPECT, InspectorSymbolIcon.FOLDER, InspectorSymbolIcon.HELP];
        private static var types:Array;

        public static function getIconByClass(clazz:*):BitmapData{
            var bmd:BitmapData;
            if (types == null){
                types = [Sprite, MovieClip, Bitmap, Shape, TextField, Loader, Video, AVM1Movie, StaticText, MorphShape, SimpleButton, Stage, DisplayObject];
                types.sort(comapreClass);
            };
            var className:String = ClassTool.getShortClassName(DisplayObject);
            var i:int;
            while (i < types.length) {
                if ((clazz is types[i])){
                    className = ClassTool.getShortClassName(types[i]);
                    break;
                };
                i++;
            };
            bmd = getIcon(className);
            return (bmd);
        }
        private static function comapreClass(a:Class, b:Class):int{
            if (a == b){
                return (0);
            };
            var c:Class = b;
            while ((c = ClassTool.getParentClassOf(c))) {
                if (c == Object){
                    c = a;
                    while ((c = ClassTool.getParentClassOf(c))) {
                        if (c == Object){
                            return (0);
                        };
                        if (b == c){
                            return (-1);
                        };
                    };
                } else {
                    if (a == c){
                        return (1);
                    };
                };
            };
            return (0);
        }
        public static function getIcon(iconName:String):BitmapData{
            var bmd:BitmapData;
            if (assetBmd == null){
                assetBmd = new InspectorSymbolBmd();
                iconBmds = [];
            };
            var t:int = icons.indexOf(iconName);
            if (t < 0){
                t = 0;
            };
            if (!(iconBmds[t])){
                bmd = new BitmapData(16, 16, true, 0);
                bmd.copyPixels(assetBmd, new Rectangle((t * 16), 0, 16, 16), new Point(0, 0));
                iconBmds[t] = bmd;
            };
            return (iconBmds[t]);
        }
        public static function getIconNameByContentType(contentType:String):String{
            switch (contentType){
                case "application/x-shockwave-flash":
                    contentType = InspectorSymbolIcon.SWF;
                    break;
                case "image/png":
                case "image/jpeg":
                case "image/bmp":
                case "image/gif":
                    contentType = InspectorSymbolIcon.BITMAP;
                    break;
                case null:
                    contentType = InspectorSymbolIcon.FOLDER;
                    break;
                default:
                    contentType = InspectorSymbolIcon.UNKNOWN;
            };
            return (contentType);
        }

    }
}//package cn.itamt.utils.inspector.ui 
