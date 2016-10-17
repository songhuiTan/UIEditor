//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.consts {

    public class VideoCodecID {

        public static const H263:uint = 2;
        public static const SCREEN:uint = 3;
        public static const VP6:uint = 4;
        public static const VP6ALPHA:uint = 5;
        public static const SCREENV2:uint = 6;

        public static function toString(codecId:uint):String{
            switch (codecId){
                case H263:
                    return ("H.263");
                case SCREEN:
                    return ("Screen Video");
                case VP6:
                    return ("VP6");
                case VP6ALPHA:
                    return ("VP6 With Alpha");
                case SCREENV2:
                    return ("Screen Video V2");
                default:
                    return ("unknown");
            };
        }

    }
}//package com.codeazur.as3swf.data.consts 
