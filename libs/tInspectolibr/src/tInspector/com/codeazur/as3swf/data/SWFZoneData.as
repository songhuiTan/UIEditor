//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFZoneData {

        public var alignmentCoordinate:Number;
        public var range:Number;

        public function SWFZoneData(data:SWFData=null){
            super();
            if (data != null){
                this.parse(data);
            };
        }
        public function parse(data:SWFData):void{
            this.alignmentCoordinate = data.readFLOAT16();
            this.range = data.readFLOAT16();
        }
        public function toString():String{
            return ((((("(" + this.alignmentCoordinate) + ",") + this.range) + ")"));
        }

    }
}//package com.codeazur.as3swf.data 
