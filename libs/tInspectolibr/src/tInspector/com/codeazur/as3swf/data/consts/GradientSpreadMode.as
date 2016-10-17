//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.consts {
    import flash.display.*;

    public class GradientSpreadMode {

        public static const PAD:uint = 0;
        public static const REFLECT:uint = 1;
        public static const REPEAT:uint = 2;

        public static function toString(spreadMode:uint):String{
            switch (spreadMode){
                case PAD:
                    return (SpreadMethod.PAD);
                case REFLECT:
                    return (SpreadMethod.REFLECT);
                case REPEAT:
                    return (SpreadMethod.REPEAT);
                default:
                    return ("unknown");
            };
        }

    }
}//package com.codeazur.as3swf.data.consts 
