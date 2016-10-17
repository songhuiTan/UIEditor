//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFGradientRecord {

        public var ratio:uint;
        public var color:uint;

        public function SWFGradientRecord(data:SWFData=null, level:uint=1){
            super();
            if (data != null){
                this.parse(data, level);
            };
        }
        public function parse(data:SWFData, level:uint):void{
            this.ratio = data.readUI8();
            this.color = ((level)<=2) ? data.readRGB() : data.readRGBA();
        }
        public function toString():String{
            return ((((("[" + this.ratio) + ",") + this.color.toString(16)) + "]"));
        }

    }
}//package com.codeazur.as3swf.data 
