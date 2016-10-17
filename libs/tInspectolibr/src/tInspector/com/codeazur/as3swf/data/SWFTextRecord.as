//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;

    public class SWFTextRecord {

        public var type:uint;
        public var hasFont:Boolean;
        public var hasColor:Boolean;
        public var hasXOffset:Boolean;
        public var hasYOffset:Boolean;
        public var fontId:uint;
        public var textColor:uint;
        public var textHeight:uint;
        public var xOffset:int;
        public var yOffset:int;
        protected var _glyphEntries:Vector.<SWFGlyphEntry>;

        public function SWFTextRecord(data:SWFData=null, glyphBits:uint=0, advanceBits:uint=0, previousRecord:SWFTextRecord=null, level:uint=1){
            super();
            this._glyphEntries = new Vector.<SWFGlyphEntry>();
            if (data != null){
                this.parse(data, glyphBits, advanceBits, previousRecord, level);
            };
        }
        public function get glyphEntries():Vector.<SWFGlyphEntry>{
            return (this._glyphEntries);
        }
        public function parse(data:SWFData, glyphBits:uint, advanceBits:uint, previousRecord:SWFTextRecord=null, level:uint=1):void{
            var styles:uint = data.readUI8();
            this.type = (styles >> 7);
            this.hasFont = !(((styles & 8) == 0));
            this.hasColor = !(((styles & 4) == 0));
            this.hasYOffset = !(((styles & 2) == 0));
            this.hasXOffset = !(((styles & 1) == 0));
            if (this.hasFont){
                this.fontId = data.readUI16();
            } else {
                if (previousRecord != null){
                    this.fontId = previousRecord.fontId;
                };
            };
            if (this.hasColor){
                this.textColor = ((level)<2) ? data.readRGB() : data.readRGBA();
            } else {
                if (previousRecord != null){
                    this.textColor = previousRecord.textColor;
                };
            };
            if (this.hasXOffset){
                this.xOffset = data.readSI16();
            } else {
                if (previousRecord != null){
                    this.xOffset = previousRecord.xOffset;
                };
            };
            if (this.hasYOffset){
                this.yOffset = data.readSI16();
            } else {
                if (previousRecord != null){
                    this.yOffset = previousRecord.yOffset;
                };
            };
            if (this.hasFont){
                this.textHeight = data.readUI16();
            } else {
                if (previousRecord != null){
                    this.textHeight = previousRecord.textHeight;
                };
            };
            var glyphCount:uint = data.readUI8();
            var i:uint;
            while (i < glyphCount) {
                this._glyphEntries.push(data.readGLYPHENTRY(glyphBits, advanceBits));
                i++;
            };
        }
        public function toString():String{
            var params:Array = [("Glyphs: " + this._glyphEntries.length.toString())];
            if (this.hasFont){
                params.push(("FontID: " + this.fontId));
                params.push(("Height: " + this.textHeight));
            };
            if (this.hasColor){
                params.push(("Color: " + this.textColor.toString(16)));
            };
            if (this.hasXOffset){
                params.push(("XOffset: " + this.xOffset));
            };
            if (this.hasYOffset){
                params.push(("YOffset: " + this.yOffset));
            };
            return (params.join(", "));
        }

    }
}//package com.codeazur.as3swf.data 
