//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;

    public class TagDefineFontInfo2 extends TagDefineFontInfo implements ITag {

        public static const TYPE:uint = 62;

        public function TagDefineFontInfo2(){
            super();
        }
        override protected function parseLangCode(data:SWFData):void{
            langCode = data.readUI8();
            langCodeLength = 1;
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineFontInfo2");
        }
        override public function get version():uint{
            return (6);
        }
        override public function toString(indent:uint=0):String{
            return ((((((((((((((((((toStringMain(indent) + "FontID: ") + fontId) + ", ") + "FontName: ") + fontName) + ", ") + "Italic: ") + italic) + ", ") + "Bold: ") + bold) + ", ") + "LanguageCode: ") + langCode) + ", ") + "Codes: ") + _codeTable.length));
        }

    }
}//package com.codeazur.as3swf.tags 
