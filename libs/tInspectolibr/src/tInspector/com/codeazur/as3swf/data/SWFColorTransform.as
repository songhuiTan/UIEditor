//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFColorTransform {

        public var rMult:int = 1;
        public var gMult:int = 1;
        public var bMult:int = 1;
        public var rAdd:int = 0;
        public var gAdd:int = 0;
        public var bAdd:int = 0;
        public var aMult:int = 1;
        public var aAdd:int = 0;

        public function SWFColorTransform(data:SWFData){
            super();
            if (data != null){
                this.parse(data);
            };
        }
        public function parse(data:SWFData):void{
            var hasMultTerms:uint;
            data.resetBitsPending();
            var hasAddTerms:uint = data.readUB(1);
            hasMultTerms = data.readUB(1);
            var bits:uint = data.readUB(4);
            this.rMult = 1;
            this.gMult = 1;
            this.bMult = 1;
            if (hasMultTerms == 1){
                this.rMult = data.readSB(bits);
                this.gMult = data.readSB(bits);
                this.bMult = data.readSB(bits);
            };
            this.rAdd = 0;
            this.gAdd = 0;
            this.bAdd = 0;
            if (hasAddTerms == 1){
                this.rAdd = data.readSB(bits);
                this.gAdd = data.readSB(bits);
                this.bAdd = data.readSB(bits);
            };
        }
        public function toString():String{
            return (((((((((((this.rMult + ",") + this.gMult) + ",") + this.bMult) + ",") + this.rAdd) + ",") + this.gAdd) + ",") + this.bAdd));
        }

    }
}//package com.codeazur.as3swf.data 
