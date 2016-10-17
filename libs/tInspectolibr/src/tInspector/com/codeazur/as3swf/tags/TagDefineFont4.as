//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.*;

    public class TagDefineFont4 extends Tag implements ITag {

        public static const TYPE:uint = 91;

        public var fontId:uint;
        public var hasFontData:Boolean;
        public var italic:Boolean;
        public var bold:Boolean;
        public var fontName:String;
        protected var _fontData:ByteArray;

        public function TagDefineFont4(){
            super();
            this._fontData = new ByteArray();
        }
        public function get fontData():ByteArray{
            return (this._fontData);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            var pos:uint = data.position;
            this.fontId = data.readUI16();
            var flags:uint = data.readUI8();
            this.hasFontData = !(((flags & 4) == 0));
            this.italic = !(((flags & 2) == 0));
            this.bold = !(((flags & 1) == 0));
            this.fontName = data.readString();
            if (((this.hasFontData) && ((length > (data.position - pos))))){
                data.readBytes(this._fontData, 0, (length - (data.position - pos)));
            };
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineFont4");
        }
        override public function get version():uint{
            return (10);
        }
        public function toString(indent:uint=0):String{
            var str:String = ((((((((((((((toStringMain(indent) + "ID: ") + this.fontId) + ", ") + "FontName: ") + this.fontName) + ", ") + "HasFontData: ") + this.hasFontData) + ", ") + "Italic: ") + this.italic) + ", ") + "Bold: ") + this.bold);
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
