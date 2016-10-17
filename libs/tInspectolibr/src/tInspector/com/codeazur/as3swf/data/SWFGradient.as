//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;

    public class SWFGradient {

        public var spreadMode:uint;
        public var interpolationMode:uint;
        public var focalPoint:Number = 0;
        protected var _records:Vector.<SWFGradientRecord>;

        public function SWFGradient(data:SWFData=null, level:uint=1){
            super();
            this._records = new Vector.<SWFGradientRecord>();
            if (data != null){
                this.parse(data, level);
            };
        }
        public function get records():Vector.<SWFGradientRecord>{
            return (this._records);
        }
        public function parse(data:SWFData, level:uint):void{
            data.resetBitsPending();
            this.spreadMode = data.readUB(2);
            this.interpolationMode = data.readUB(2);
            var numGradients:uint = data.readUB(4);
            var i:uint;
            while (i < numGradients) {
                this._records.push(data.readGRADIENTRECORD(level));
                i++;
            };
        }
        public function toString():String{
            return ((("(" + this._records.join(",")) + ")"));
        }

    }
}//package com.codeazur.as3swf.data 
