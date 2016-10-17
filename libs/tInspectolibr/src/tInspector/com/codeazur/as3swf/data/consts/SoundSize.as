//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.consts {

    public class SoundSize {

        public static const BIT_8:uint = 0;
        public static const BIT_16:uint = 1;

        public static function toString(soundSize:uint):String{
            switch (soundSize){
                case BIT_8:
                    return ("8bit");
                case BIT_16:
                    return ("16bit");
                default:
                    return ("unknown");
            };
        }

    }
}//package com.codeazur.as3swf.data.consts 
