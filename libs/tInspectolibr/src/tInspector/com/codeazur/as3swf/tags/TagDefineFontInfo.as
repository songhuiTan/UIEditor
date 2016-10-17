//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import __AS3__.vec.*;
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.*;

    public class TagDefineFontInfo extends Tag implements ITag {

        public static const TYPE:uint = 13;

        public var fontId:uint;
        public var fontName:String;
        public var smallText:Boolean;
        public var shiftJIS:Boolean;
        public var ansi:Boolean;
        public var italic:Boolean;
        public var bold:Boolean;
        public var wideCodes:Boolean;
        public var langCode:uint = 0;
        protected var _codeTable:Vector.<uint>;
        protected var langCodeLength:uint = 0;

        public function TagDefineFontInfo(){
            super();
            this._codeTable = new Vector.<uint>();
        }
        public function get codeTable():Vector.<uint>{
            return (this._codeTable);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.fontId = data.readUI16();
            var fontNameLen:uint = data.readUI8();
            var fontNameRaw:ByteArray = new ByteArray();
            data.readBytes(fontNameRaw, 0, fontNameLen);
            this.fontName = fontNameRaw.readUTFBytes(fontNameLen);
            var flags:uint = data.readUI8();
            this.smallText = ((flags & 32) == 1);
            this.shiftJIS = ((flags & 16) == 1);
            this.ansi = ((flags & 8) == 1);
            this.italic = ((flags & 4) == 1);
            this.bold = ((flags & 2) == 1);
            this.wideCodes = ((flags & 1) == 1);
            this.parseLangCode(data);
            var numGlyphs:uint = (((length - fontNameLen) - this.langCodeLength) - 4);
            var i:uint;
            while (i < numGlyphs) {
                this._codeTable.push((this.wideCodes) ? data.readUI16() : data.readUI8());
                i++;
            };
        }
        protected function parseLangCode(data:SWFData):void{
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineFontInfo");
        }
        override public function get version():uint{
            return (1);
        }
        public function toString(indent:uint=0):String{
            return (((((((((((((((toStringMain(indent) + "FontID: ") + this.fontId) + ", ") + "FontName: ") + this.fontName) + ", ") + "Italic: ") + this.italic) + ", ") + "Bold: ") + this.bold) + ", ") + "Codes: ") + this._codeTable.length));
        }

    }
}//package com.codeazur.as3swf.tags 
