//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;

    public class SWFMorphGradient {

        protected var _records:Vector.<SWFMorphGradientRecord>;

        public function SWFMorphGradient(data:SWFData=null, level:uint=1){
            super();
            this._records = new Vector.<SWFMorphGradientRecord>();
            if (data != null){
                this.parse(data, level);
            };
        }
        public function get records():Vector.<SWFMorphGradientRecord>{
            return (this._records);
        }
        public function parse(data:SWFData, level:uint):void{
            var numGradients:uint = data.readUI8();
            var i:uint;
            while (i < numGradients) {
                this._records.push(data.readMORPHGRADIENTRECORD());
                i++;
            };
        }
        public function toString():String{
            return ((("(" + this._records.join(",")) + ")"));
        }

    }
}//package com.codeazur.as3swf.data 
