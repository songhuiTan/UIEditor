//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.data.consts.*;
    import tInspector.com.codeazur.as3swf.*;

    public class TagDefineBitsJPEG2 extends TagDefineBits implements ITag {

        public static const TYPE:uint = 21;

        public var bitmapType:uint = 1;

        public function TagDefineBitsJPEG2(){
            super();
        }
        override public function parse(data:SWFData, length:uint, version:uint):void{
            super.parse(data, length, version);
            if ((((bitmapData[0] == 0xFF)) && ((((bitmapData[1] == 216)) || ((bitmapData[1] == 217)))))){
                this.bitmapType = BitmapType.JPEG;
            } else {
                if ((((((((((((((((bitmapData[0] == 137)) && ((bitmapData[1] == 80)))) && ((bitmapData[2] == 78)))) && ((bitmapData[3] == 71)))) && ((bitmapData[4] == 13)))) && ((bitmapData[5] == 10)))) && ((bitmapData[6] == 26)))) && ((bitmapData[7] == 10)))){
                    this.bitmapType = BitmapType.PNG;
                } else {
                    if ((((((((((((bitmapData[0] == 71)) && ((bitmapData[1] == 73)))) && ((bitmapData[2] == 70)))) && ((bitmapData[3] == 56)))) && ((bitmapData[4] == 57)))) && ((bitmapData[5] == 97)))){
                        this.bitmapType = BitmapType.GIF89A;
                    };
                };
            };
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineBitsJPEG2");
        }
        override public function get version():uint{
            return (((this.bitmapType)==BitmapType.JPEG) ? 2 : 8);
        }
        override public function toString(indent:uint=0):String{
            var str:String = (((((toStringMain(indent) + "ID: ") + characterId) + ", ") + "Type: ") + BitmapType.toString(this.bitmapType));
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
