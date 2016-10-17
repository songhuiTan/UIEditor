//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class TagDefineFont extends Tag implements ITag {

        public static const TYPE:uint = 10;

        protected var fontId:uint;
        protected var _glyphShapeTable:Vector.<SWFShape>;

        public function TagDefineFont(){
            super();
            this._glyphShapeTable = new Vector.<SWFShape>();
        }
        public function get glyphShapeTable():Vector.<SWFShape>{
            return (this._glyphShapeTable);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.fontId = data.readUI16();
            var numGlyphs:uint = (data.readUI16() >> 1);
            data.skipBytes(((numGlyphs - 1) << 1));
            var i:uint;
            while (i < numGlyphs) {
                this._glyphShapeTable.push(data.readSHAPE());
                i++;
            };
        }
        public function publish(data:SWFData, version:uint):void{
            var i:uint;
            var len:uint;
            var body:SWFData = new SWFData();
            var shapeTable:SWFData = new SWFData();
            var prevPtr:uint;
            body.writeUI16(this.fontId);
            i = 0;
            len = this._glyphShapeTable.length;
            while (i < len) {
                shapeTable.writeSHAPE(this._glyphShapeTable[i]);
                body.writeUI16((shapeTable.position - prevPtr));
                prevPtr = shapeTable.position;
                i++;
            };
            body.writeBytes(shapeTable);
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineFont");
        }
        public function toString(indent:uint=0):String{
            var str:String = (((((toStringMain(indent) + "ID: ") + this.fontId) + ", ") + "Glyphs: ") + this._glyphShapeTable.length);
            return ((str + this.toStringCommon(indent)));
        }
        protected function toStringCommon(indent:uint):String{
            var str:String = "";
            var i:uint;
            while (i < this._glyphShapeTable.length) {
                str = (str + (((("\n" + StringUtils.repeat((indent + 2))) + "[") + i) + "] GlyphShapes:"));
                str = (str + this._glyphShapeTable[i].toString((indent + 4)));
                i++;
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
