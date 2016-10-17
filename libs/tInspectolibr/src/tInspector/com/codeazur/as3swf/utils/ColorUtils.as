//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.utils {

    public class ColorUtils {

        public static function alpha(color:uint):Number{
            return ((Number((color >>> 24)) / 0xFF));
        }
        public static function rgb(color:uint):uint{
            return ((color & 0xFFFFFF));
        }
        public static function r(color:uint):Number{
            return ((Number(((rgb(color) >> 16) & 0xFF)) / 0xFF));
        }
        public static function g(color:uint):Number{
            return ((Number(((rgb(color) >> 8) & 0xFF)) / 0xFF));
        }
        public static function b(color:uint):Number{
            return ((Number((rgb(color) & 0xFF)) / 0xFF));
        }
        public static function rgbToString(color:uint):String{
            var result:String = rgb(color).toString(16).toUpperCase();
            while (result.length < 6) {
                result = ("0" + result);
            };
            return (("#" + result));
        }

    }
}//package com.codeazur.as3swf.utils 
