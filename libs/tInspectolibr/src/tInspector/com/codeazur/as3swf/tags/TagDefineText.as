//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class TagDefineText extends Tag implements ITag {

        public static const TYPE:uint = 11;

        public var characterId:uint;
        public var textBounds:SWFRectangle;
        public var textMatrix:SWFMatrix;
        protected var _records:Vector.<SWFTextRecord>;

        public function TagDefineText(){
            super();
            this._records = new Vector.<SWFTextRecord>();
        }
        public function get records():Vector.<SWFTextRecord>{
            return (this._records);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            var record:SWFTextRecord;
            this.characterId = data.readUI16();
            this.textBounds = data.readRECT();
            this.textMatrix = data.readMATRIX();
            var glyphBits:uint = data.readUI8();
            var advanceBits:uint = data.readUI8();
            while ((record = data.readTEXTRECORD(glyphBits, advanceBits, record)) != null) {
                this._records.push(record);
            };
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineText");
        }
        public function toString(indent:uint=0):String{
            var i:uint;
            var str:String = ((((((((toStringMain(indent) + "ID: ") + this.characterId) + ", ") + "Bounds: ") + this.textBounds) + ", ") + "Matrix: ") + this.textMatrix);
            if (this._records.length > 0){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "TextRecords:"));
                i = 0;
                while (i < this._records.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this._records[i].toString()));
                    i++;
                };
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
