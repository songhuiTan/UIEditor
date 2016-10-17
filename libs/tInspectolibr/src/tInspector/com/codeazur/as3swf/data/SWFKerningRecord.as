//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFKerningRecord {

        public var code1:uint;
        public var code2:uint;
        public var adjustment:int;

        public function SWFKerningRecord(data:SWFData=null, wideCodes:Boolean=false){
            super();
            if (data != null){
                this.parse(data, wideCodes);
            };
        }
        public function parse(data:SWFData, wideCodes:Boolean):void{
            this.code1 = (wideCodes) ? data.readUI16() : data.readUI8();
            this.code2 = (wideCodes) ? data.readUI16() : data.readUI8();
            this.adjustment = data.readSI16();
        }
        public function toString(indent:uint=0):String{
            return (((((((("Code1: " + this.code1) + ", ") + "Code2: ") + this.code2) + ", ") + "Adjustment: ") + this.adjustment));
        }

    }
}//package com.codeazur.as3swf.data 
