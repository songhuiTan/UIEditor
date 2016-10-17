//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFRectangle {

        public var xmin:int = 0;
        public var xmax:int = 11000;
        public var ymin:int = 0;
        public var ymax:int = 8000;

        public function SWFRectangle(data:SWFData=null){
            super();
            if (data != null){
                this.parse(data);
            };
        }
        public function parse(data:SWFData):void{
            data.resetBitsPending();
            var bits:uint = data.readUB(5);
            this.xmin = data.readSB(bits);
            this.xmax = data.readSB(bits);
            this.ymin = data.readSB(bits);
            this.ymax = data.readSB(bits);
        }
        public function publish(data:SWFData):void{
            var numBits:uint = data.calculateMaxBits(true, this.xmin, this.xmax, this.ymin, this.ymax);
            data.resetBitsPending();
            data.writeUB(5, numBits);
            data.writeSB(numBits, this.xmin);
            data.writeSB(numBits, this.xmax);
            data.writeSB(numBits, this.ymin);
            data.writeSB(numBits, this.ymax);
        }
        public function toString():String{
            return ((((((((("(" + this.xmin) + ",") + this.xmax) + ",") + this.ymin) + ",") + this.ymax) + ")"));
        }
        public function toStringSize():String{
            return ((((("(" + ((Number(this.xmax) / 20) - (Number(this.xmin) / 20))) + ",") + ((Number(this.ymax) / 20) - (Number(this.ymin) / 20))) + ")"));
        }

    }
}//package com.codeazur.as3swf.data 
