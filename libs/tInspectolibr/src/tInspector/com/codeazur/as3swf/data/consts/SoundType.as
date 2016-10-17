//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.consts {

    public class SoundType {

        public static const MONO:uint = 0;
        public static const STEREO:uint = 1;

        public static function toString(soundType:uint):String{
            switch (soundType){
                case MONO:
                    return ("mono");
                case STEREO:
                    return ("stereo");
                default:
                    return ("unknown");
            };
        }

    }
}//package com.codeazur.as3swf.data.consts 
