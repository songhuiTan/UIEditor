//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {

    public class TagDefineFont3 extends TagDefineFont2 implements ITag {

        public static const TYPE:uint = 75;

        public function TagDefineFont3(){
            super();
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineFont3");
        }
        override public function toString(indent:uint=0):String{
            var str:String = ((((((((((((((toStringMain(indent) + "ID: ") + fontId) + ", ") + "FontName: ") + fontName) + ", ") + "Italic: ") + italic) + ", ") + "Bold: ") + bold) + ", ") + "Glyphs: ") + _glyphShapeTable.length);
            return ((str + toStringCommon(indent)));
        }

    }
}//package com.codeazur.as3swf.tags 
