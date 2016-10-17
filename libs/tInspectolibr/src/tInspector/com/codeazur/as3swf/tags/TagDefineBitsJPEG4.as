//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.data.consts.*;
    import tInspector.com.codeazur.as3swf.*;

    public class TagDefineBitsJPEG4 extends TagDefineBitsJPEG3 implements ITag {

        public static const TYPE:uint = 90;

        public var deblockParam:Number;

        public function TagDefineBitsJPEG4(){
            super();
        }
        override public function parse(data:SWFData, length:uint, version:uint):void{
            characterId = data.readUI16();
            var alphaDataOffset:uint = data.readUI32();
            this.deblockParam = data.readFIXED8();
            data.readBytes(_bitmapData, 0, alphaDataOffset);
            if ((((bitmapData[0] == 0xFF)) && ((((bitmapData[1] == 216)) || ((bitmapData[1] == 217)))))){
                bitmapType = BitmapType.JPEG;
            } else {
                if ((((((((((((((((bitmapData[0] == 137)) && ((bitmapData[1] == 80)))) && ((bitmapData[2] == 78)))) && ((bitmapData[3] == 71)))) && ((bitmapData[4] == 13)))) && ((bitmapData[5] == 10)))) && ((bitmapData[6] == 26)))) && ((bitmapData[7] == 10)))){
                    bitmapType = BitmapType.PNG;
                } else {
                    if ((((((((((((bitmapData[0] == 71)) && ((bitmapData[1] == 73)))) && ((bitmapData[2] == 70)))) && ((bitmapData[3] == 56)))) && ((bitmapData[4] == 57)))) && ((bitmapData[5] == 97)))){
                        bitmapType = BitmapType.GIF89A;
                    };
                };
            };
            var alphaDataSize:uint = ((length - alphaDataOffset) - 6);
            if (alphaDataSize > 0){
                data.readBytes(_bitmapAlphaData, 0, alphaDataSize);
            };
        }
        override public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, ((_bitmapData.length + _bitmapAlphaData.length) + 6));
            data.writeUI16(characterId);
            data.writeUI32(_bitmapData.length);
            data.writeFIXED8(this.deblockParam);
            if (_bitmapData.length > 0){
                data.writeBytes(_bitmapData);
            };
            if (_bitmapAlphaData.length > 0){
                data.writeBytes(_bitmapAlphaData);
            };
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineBitsJPEG4");
        }
        override public function get version():uint{
            return (10);
        }
        override public function toString(indent:uint=0):String{
            var str:String = (((((((((((toStringMain(indent) + "ID: ") + characterId) + ", ") + "Type: ") + BitmapType.toString(bitmapType)) + ", ") + "DeblockParam: ") + this.deblockParam) + ", ") + "HasAlphaData: ") + (_bitmapAlphaData.length > 0));
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
