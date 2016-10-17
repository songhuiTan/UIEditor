//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFGlyphEntry {

        public var index:uint;
        public var advance:int;

        public function SWFGlyphEntry(data:SWFData=null, glyphBits:uint=0, advanceBits:uint=0){
            super();
            if (data != null){
                this.parse(data, glyphBits, advanceBits);
            };
        }
        public function parse(data:SWFData, glyphBits:uint, advanceBits:uint):void{
            this.index = data.readUB(glyphBits);
            this.advance = data.readSB(advanceBits);
        }
        public function toString():String{
            return (this.index.toString());
        }

    }
}//package com.codeazur.as3swf.data 
