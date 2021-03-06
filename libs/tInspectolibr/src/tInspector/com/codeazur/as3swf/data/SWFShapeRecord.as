﻿//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFShapeRecord {

        public static const TYPE_UNKNOWN:uint = 0;
        public static const TYPE_END:uint = 1;
        public static const TYPE_STYLECHANGE:uint = 2;
        public static const TYPE_STRAIGHTEDGE:uint = 3;
        public static const TYPE_CURVEDEDGE:uint = 4;

        public function SWFShapeRecord(data:SWFData=null, level:uint=1){
            super();
            if (data != null){
                this.parse(data, level);
            };
        }
        public function get type():uint{
            return (TYPE_UNKNOWN);
        }
        public function parse(data:SWFData=null, level:uint=1):void{
        }
        public function toString(indent:uint=0):String{
            return ("[SWFShapeRecord]");
        }

    }
}//package com.codeazur.as3swf.data 
