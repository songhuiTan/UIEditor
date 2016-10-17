//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.data.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class TagDefineText2 extends TagDefineText implements ITag {

        public static const TYPE:uint = 33;

        public function TagDefineText2(){
            super();
        }
        override public function parse(data:SWFData, length:uint, version:uint):void{
            var record:SWFTextRecord;
            characterId = data.readUI16();
            textBounds = data.readRECT();
            textMatrix = data.readMATRIX();
            var glyphBits:uint = data.readUI8();
            var advanceBits:uint = data.readUI8();
            while ((record = data.readTEXTRECORD(glyphBits, advanceBits, record, 2)) != null) {
                _records.push(record);
            };
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineText2");
        }
        override public function toString(indent:uint=0):String{
            var i:uint;
            var str:String = ((((((((toStringMain(indent) + "ID: ") + characterId) + ", ") + "Bounds: ") + textBounds) + ", ") + "Matrix: ") + textMatrix);
            if (_records.length > 0){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "TextRecords:"));
                i = 0;
                while (i < _records.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + _records[i].toString()));
                    i++;
                };
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
