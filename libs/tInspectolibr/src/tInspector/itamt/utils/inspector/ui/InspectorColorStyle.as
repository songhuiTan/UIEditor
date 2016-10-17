//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import flash.utils.*;
    import flash.display.*;

    public class InspectorColorStyle {

        public static const MOVIE_CLIP:uint = 39167;
        public static const SPRITE:uint = 0xFF3300;
        public static const SHAPE:uint = 16737791;
        public static const BITMAP:uint = 0x99CC00;
        public static const STAGE:uint = 0;
        public static const DISPLAY_OBJECT:uint = 0xCCCCCC;
        public static const DEFAULT_BG:uint = 0x393939;
        public static const TYPE_ARR:Array = ["sprite", "movie clip", "bitmap", "shape", "textfield", "loader", "video", "avm1movie", "static text", "morphshape"];

        public static function getObjectColor(src:DisplayObject):uint{
            var lineColor:uint;
            var mc:Array = [];
            var str:String = getQualifiedClassName(src);
            var classNameStr:String = str.slice(((str.lastIndexOf("::"))>=0) ? (str.lastIndexOf("::") + 2) : 0);
            switch (classNameStr){
                case "Shape":
                    lineColor = InspectorColorStyle.SHAPE;
                    break;
                case "Stage":
                    lineColor = InspectorColorStyle.STAGE;
                    break;
                case "Bitmap":
                    lineColor = InspectorColorStyle.BITMAP;
                    break;
                case "MovieClip":
                    lineColor = InspectorColorStyle.MOVIE_CLIP;
                    break;
                case "Sprite":
                    lineColor = InspectorColorStyle.SPRITE;
                    break;
                default:
                    if ((src is Shape)){
                        lineColor = InspectorColorStyle.SHAPE;
                    } else {
                        if ((src is Bitmap)){
                            lineColor = InspectorColorStyle.BITMAP;
                        } else {
                            if ((src is MovieClip)){
                                lineColor = InspectorColorStyle.MOVIE_CLIP;
                            } else {
                                if ((src is Stage)){
                                    lineColor = InspectorColorStyle.STAGE;
                                } else {
                                    if ((src is Sprite)){
                                        lineColor = InspectorColorStyle.SPRITE;
                                    } else {
                                        if ((src is DisplayObject)){
                                            lineColor = InspectorColorStyle.DISPLAY_OBJECT;
                                        };
                                    };
                                };
                            };
                        };
                    };
            };
            return (lineColor);
        }

    }
}//package cn.itamt.utils.inspector.ui 
