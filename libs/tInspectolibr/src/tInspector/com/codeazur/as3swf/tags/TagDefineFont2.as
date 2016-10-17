//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import __AS3__.vec.*;
    
    import flash.utils.*;
    
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import tInspector.com.codeazur.utils.*;

    public class TagDefineFont2 extends TagDefineFont implements ITag {

        public static const TYPE:uint = 48;

        public var hasLayout:Boolean;
        public var shiftJIS:Boolean;
        public var smallText:Boolean;
        public var ansi:Boolean;
        public var wideOffsets:Boolean;
        public var wideCodes:Boolean;
        public var italic:Boolean;
        public var bold:Boolean;
        public var languageCode:uint;
        public var fontName:String;
        public var ascent:int;
        public var descent:int;
        public var leading:int;
        protected var _codeTable:Vector.<uint>;
        protected var _fontAdvanceTable:Vector.<int>;
        protected var _fontBoundsTable:Vector.<SWFRectangle>;
        protected var _fontKerningTable:Vector.<SWFKerningRecord>;

        public function TagDefineFont2(){
            super();
            this._codeTable = new Vector.<uint>();
            this._fontAdvanceTable = new Vector.<int>();
            this._fontBoundsTable = new Vector.<SWFRectangle>();
            this._fontKerningTable = new Vector.<SWFKerningRecord>();
        }
        public function get codeTable():Vector.<uint>{
            return (this._codeTable);
        }
        public function get fontAdvanceTable():Vector.<int>{
            return (this._fontAdvanceTable);
        }
        public function get fontBoundsTable():Vector.<SWFRectangle>{
            return (this._fontBoundsTable);
        }
        public function get fontKerningTable():Vector.<SWFKerningRecord>{
            return (this._fontKerningTable);
        }
        override public function parse(data:SWFData, length:uint, version:uint):void{
            var i:uint;
            var kerningCount:uint;
            fontId = data.readUI16();
            var flags:uint = data.readUI8();
            this.hasLayout = !(((flags & 128) == 0));
            this.shiftJIS = !(((flags & 64) == 0));
            this.smallText = !(((flags & 32) == 0));
            this.ansi = !(((flags & 16) == 0));
            this.wideOffsets = !(((flags & 8) == 0));
            this.wideCodes = !(((flags & 4) == 0));
            this.italic = !(((flags & 2) == 0));
            this.bold = !(((flags & 1) == 0));
            this.languageCode = data.readLANGCODE();
            var fontNameLen:uint = data.readUI8();
            var fontNameRaw:ByteArray = new ByteArray();
            data.readBytes(fontNameRaw, 0, fontNameLen);
            this.fontName = fontNameRaw.readUTFBytes(fontNameLen);
            var numGlyphs:uint = data.readUI16();
			var moveNum:int= (this.wideOffsets) ? 2 : 1
            data.skipBytes((numGlyphs <<moveNum));
            var codeTableOffset:uint = (this.wideOffsets) ? data.readUI32() : data.readUI16();
            i = 0;
            while (i < numGlyphs) {
                _glyphShapeTable.push(data.readSHAPE());
                i++;
            };
            i = 0;
            while (i < numGlyphs) {
                this._codeTable.push(data.readUI16());
                i++;
            };
            if (this.hasLayout){
                this.ascent = data.readSI16();
                this.descent = data.readSI16();
                this.leading = data.readSI16();
                i = 0;
                while (i < numGlyphs) {
                    this._fontAdvanceTable.push(data.readSI16());
                    i++;
                };
                i = 0;
                while (i < numGlyphs) {
                    this._fontBoundsTable.push(data.readRECT());
                    i++;
                };
                kerningCount = data.readUI16();
                i = 0;
                while (i < kerningCount) {
                    this._fontKerningTable.push(data.readKERNINGRECORD(this.wideCodes));
                    i++;
                };
            };
        }
        override public function publish(data:SWFData, version:uint):void{
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineFont2");
        }
        override public function toString(indent:uint=0):String{
            var str:String = ((((((((((((((toStringMain(indent) + "ID: ") + fontId) + ", ") + "FontName: ") + this.fontName) + ", ") + "Italic: ") + this.italic) + ", ") + "Bold: ") + this.bold) + ", ") + "Glyphs: ") + _glyphShapeTable.length);
            return ((str + this.toStringCommon(indent)));
        }
        override protected function toStringCommon(indent:uint):String{
            var i:uint;
            var hasNonNullBounds:Boolean;
            var rect:SWFRectangle;
            var str:String = super.toStringCommon(indent);
            if (this.hasLayout){
                str = (str + ((("\n" + StringUtils.repeat((indent + 2))) + "Ascent: ") + this.ascent));
                str = (str + ((("\n" + StringUtils.repeat((indent + 2))) + "Descent: ") + this.descent));
                str = (str + ((("\n" + StringUtils.repeat((indent + 2))) + "Leading: ") + this.leading));
            };
            if (this._codeTable.length > 0){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "CodeTable:"));
                i = 0;
                while (i < this._codeTable.length) {
                    if ((i & 15) == 0){
                        str = (str + (("\n" + StringUtils.repeat((indent + 4))) + this._codeTable[i].toString()));
                    } else {
                        str = (str + (", " + this._codeTable[i].toString()));
                    };
                    i++;
                };
            };
            if (this._fontAdvanceTable.length > 0){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "FontAdvanceTable:"));
                i = 0;
                while (i < this._fontAdvanceTable.length) {
                    if ((i & 7) == 0){
                        str = (str + (("\n" + StringUtils.repeat((indent + 4))) + this._fontAdvanceTable[i].toString()));
                    } else {
                        str = (str + (", " + this._fontAdvanceTable[i].toString()));
                    };
                    i++;
                };
            };
            if (this._fontBoundsTable.length > 0){
                hasNonNullBounds = false;
                i = 0;
                while (i < this._fontBoundsTable.length) {
                    rect = this._fontBoundsTable[i];
                    if (((((((!((rect.xmin == 0))) || (!((rect.xmax == 0))))) || (!((rect.ymin == 0))))) || (!((rect.ymax == 0))))){
                        hasNonNullBounds = true;
                        break;
                    };
                    i++;
                };
                if (hasNonNullBounds){
                    str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "FontBoundsTable:"));
                    i = 0;
                    while (i < this._fontBoundsTable.length) {
                        str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this._fontBoundsTable[i].toString()));
                        i++;
                    };
                };
            };
            if (this._fontKerningTable.length > 0){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "KerningTable:"));
                i = 0;
                while (i < this._fontKerningTable.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this._fontKerningTable[i].toString()));
                    i++;
                };
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
