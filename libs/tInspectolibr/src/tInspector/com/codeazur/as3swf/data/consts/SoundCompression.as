//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.consts {

    public class SoundCompression {

        public static const UNCOMPRESSED_NATIVE_ENDIAN:uint = 0;
        public static const ADPCM:uint = 1;
        public static const MP3:uint = 2;
        public static const UNCOMPRESSED_LITTLE_ENDIAN:uint = 3;
        public static const NELLYMOSER_16_KHZ:uint = 4;
        public static const NELLYMOSER_8_KHZ:uint = 5;
        public static const NELLYMOSER:uint = 6;
        public static const SPEEX:uint = 11;

        public static function toString(soundCompression:uint):String{
            switch (soundCompression){
                case UNCOMPRESSED_NATIVE_ENDIAN:
                    return ("Uncompressed Native Endian");
                case ADPCM:
                    return ("ADPCM");
                case MP3:
                    return ("MP3");
                case UNCOMPRESSED_LITTLE_ENDIAN:
                    return ("Uncompressed Little Endian");
                case NELLYMOSER_16_KHZ:
                    return ("Nellymoser 16kHz");
                case NELLYMOSER_8_KHZ:
                    return ("Nellymoser 8kHz");
                case NELLYMOSER:
                    return ("Nellymoser");
                case SPEEX:
                    return ("Speex");
                default:
                    return ("unknown");
            };
        }

    }
}//package com.codeazur.as3swf.data.consts 
