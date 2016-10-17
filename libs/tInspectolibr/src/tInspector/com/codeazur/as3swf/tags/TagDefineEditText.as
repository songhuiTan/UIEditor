//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.*;

    public class TagDefineEditText extends Tag implements ITag {

        public static const TYPE:uint = 37;

        public var characterId:uint;
        public var bounds:SWFRectangle;
        public var variableName:String;
        public var hasText:Boolean;
        public var wordWrap:Boolean;
        public var multiline:Boolean;
        public var password:Boolean;
        public var readOnly:Boolean;
        public var hasTextColor:Boolean;
        public var hasMaxLength:Boolean;
        public var hasFont:Boolean;
        public var hasFontClass:Boolean;
        public var autoSize:Boolean;
        public var hasLayout:Boolean;
        public var noSelect:Boolean;
        public var border:Boolean;
        public var wasStatic:Boolean;
        public var html:Boolean;
        public var useOutlines:Boolean;
        public var fontId:uint;
        public var fontClass:String;
        public var fontHeight:uint;
        public var textColor:uint;
        public var maxLength:uint;
        public var align:uint;
        public var leftMargin:uint;
        public var rightMargin:uint;
        public var indent:uint;
        public var leading:int;
        public var initialText:String;

        public function TagDefineEditText(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.characterId = data.readUI16();
            this.bounds = data.readRECT();
            var flags1:uint = data.readUI8();
            this.hasText = !(((flags1 & 128) == 0));
            this.wordWrap = !(((flags1 & 64) == 0));
            this.multiline = !(((flags1 & 32) == 0));
            this.password = !(((flags1 & 16) == 0));
            this.readOnly = !(((flags1 & 8) == 0));
            this.hasTextColor = !(((flags1 & 4) == 0));
            this.hasMaxLength = !(((flags1 & 2) == 0));
            this.hasFont = !(((flags1 & 1) == 0));
            var flags2:uint = data.readUI8();
            this.hasFontClass = !(((flags2 & 128) == 0));
            this.autoSize = !(((flags2 & 64) == 0));
            this.hasLayout = !(((flags2 & 32) == 0));
            this.noSelect = !(((flags2 & 16) == 0));
            this.border = !(((flags2 & 8) == 0));
            this.wasStatic = !(((flags2 & 4) == 0));
            this.html = !(((flags2 & 2) == 0));
            this.useOutlines = !(((flags2 & 1) == 0));
            if (this.hasFont){
                this.fontId = data.readUI16();
            };
            if (this.hasFontClass){
                this.fontClass = data.readString();
            };
            if (this.hasFont){
                this.fontHeight = data.readUI16();
            };
            if (this.hasTextColor){
                this.textColor = data.readRGBA();
            };
            if (this.hasMaxLength){
                this.maxLength = data.readUI16();
            };
            if (this.hasLayout){
                this.align = data.readUI8();
                this.leftMargin = data.readUI16();
                this.rightMargin = data.readUI16();
                this.indent = data.readUI16();
                this.leading = data.readSI16();
            };
            this.variableName = data.readString();
            if (this.hasText){
                this.initialText = data.readString();
            };
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineEditText");
        }
        public function toString(indent:uint=0):String{
            var str:String = ((((((toStringMain(indent) + "ID: ") + this.characterId) + ", ") + ((this.variableName.length)>0) ? (("VariableName: " + this.variableName) + ", ") : "") + "Bounds: ") + this.bounds);
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
