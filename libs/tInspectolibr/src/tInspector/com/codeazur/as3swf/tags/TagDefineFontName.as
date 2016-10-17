//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;

    public class TagDefineFontName extends Tag implements ITag {

        public static const TYPE:uint = 88;

        public var fontId:uint;
        public var fontName:String;
        public var fontCopyright:String;

        public function TagDefineFontName(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.fontId = data.readUI16();
            this.fontName = data.readString();
            this.fontCopyright = data.readString();
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineFontName");
        }
        public function toString(indent:uint=0):String{
            return (((((((((toStringMain(indent) + "FontID: ") + this.fontId) + ", ") + "Name: ") + this.fontName) + ", ") + "Copyright: ") + this.fontCopyright));
        }

    }
}//package com.codeazur.as3swf.tags 
