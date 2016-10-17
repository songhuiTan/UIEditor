//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFMorphGradientRecord {

        public var startRatio:uint;
        public var startColor:uint;
        public var endRatio:uint;
        public var endColor:uint;

        public function SWFMorphGradientRecord(data:SWFData=null, level:uint=1){
            super();
            if (data != null){
                this.parse(data, level);
            };
        }
        public function parse(data:SWFData, level:uint):void{
            this.startRatio = data.readUI8();
            this.startColor = data.readRGBA();
            this.endRatio = data.readUI8();
            this.endColor = data.readRGBA();
        }
        public function toString():String{
            return ((((((((("[" + this.startRatio) + ",") + this.startColor.toString(16)) + ",") + this.endRatio) + ",") + this.endColor.toString(16)) + "]"));
        }

    }
}//package com.codeazur.as3swf.data 
