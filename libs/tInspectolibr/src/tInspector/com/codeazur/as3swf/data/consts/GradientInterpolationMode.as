//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.consts {
    import flash.display.*;

    public class GradientInterpolationMode {

        public static const NORMAL:uint = 0;
        public static const LINEAR:uint = 1;

        public static function toString(interpolationMode:uint):String{
            switch (interpolationMode){
                case NORMAL:
                    return (InterpolationMethod.RGB);
                case LINEAR:
                    return (InterpolationMethod.LINEAR_RGB);
                default:
                    return ("unknown");
            };
        }

    }
}//package com.codeazur.as3swf.data.consts 
