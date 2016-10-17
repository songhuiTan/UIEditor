//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.data.consts.*;
    import tInspector.com.codeazur.as3swf.*;

    public class TagDefineBitsJPEG3 extends TagDefineBitsJPEG2 implements ITag {

        public static const TYPE:uint = 35;

        protected var _bitmapAlphaData:ByteArray;

        public function TagDefineBitsJPEG3(){
            super();
            this._bitmapAlphaData = new ByteArray();
        }
        public function get bitmapAlphaData():ByteArray{
            return (this._bitmapAlphaData);
        }
        override public function parse(data:SWFData, length:uint, version:uint):void{
            characterId = data.readUI16();
            var alphaDataOffset:uint = data.readUI32();
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
                data.readBytes(this._bitmapAlphaData, 0, alphaDataSize);
            };
        }
        override public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, ((_bitmapData.length + this._bitmapAlphaData.length) + 6));
            data.writeUI16(characterId);
            data.writeUI32(_bitmapData.length);
            if (_bitmapData.length > 0){
                data.writeBytes(_bitmapData);
            };
            if (this._bitmapAlphaData.length > 0){
                data.writeBytes(this._bitmapAlphaData);
            };
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineBitsJPEG3");
        }
        override public function get version():uint{
            return (((bitmapType)==BitmapType.JPEG) ? 3 : 8);
        }
        override public function toString(indent:uint=0):String{
            var str:String = ((((((((toStringMain(indent) + "ID: ") + characterId) + ", ") + "Type: ") + BitmapType.toString(bitmapType)) + ", ") + "HasAlphaData: ") + (this._bitmapAlphaData.length > 0));
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
