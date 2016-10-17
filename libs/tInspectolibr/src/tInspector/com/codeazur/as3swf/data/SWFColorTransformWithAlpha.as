//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFColorTransformWithAlpha extends SWFColorTransform {

        public function SWFColorTransformWithAlpha(data:SWFData=null){
            super(data);
        }
        override public function parse(data:SWFData):void{
            var hasAddTerms:uint;
            var hasMultTerms:uint;
            var bits:uint;
            data.resetBitsPending();
            hasAddTerms = data.readUB(1);
            hasMultTerms = data.readUB(1);
            bits = data.readUB(4);
            rMult = 1;
            gMult = 1;
            bMult = 1;
            aMult = 1;
            if (hasMultTerms == 1){
                rMult = data.readSB(bits);
                gMult = data.readSB(bits);
                bMult = data.readSB(bits);
                aMult = data.readSB(bits);
            };
            rAdd = 0;
            gAdd = 0;
            bAdd = 0;
            aAdd = 0;
            if (hasAddTerms == 1){
                rAdd = data.readSB(bits);
                gAdd = data.readSB(bits);
                bAdd = data.readSB(bits);
                aAdd = data.readSB(bits);
            };
        }
        override public function toString():String{
            return (((((((((((((((rMult + ",") + gMult) + ",") + bMult) + ",") + aMult) + ",") + rAdd) + ",") + gAdd) + ",") + bAdd) + ",") + aAdd));
        }

    }
}//package com.codeazur.as3swf.data 
