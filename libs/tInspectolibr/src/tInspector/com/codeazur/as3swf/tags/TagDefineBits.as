//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.*;

    public class TagDefineBits extends Tag implements ITag {

        public static const TYPE:uint = 6;

        public var characterId:uint;
        protected var _bitmapData:ByteArray;

        public function TagDefineBits(){
            super();
            this._bitmapData = new ByteArray();
        }
        public function get bitmapData():ByteArray{
            return (this._bitmapData);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.characterId = data.readUI16();
            if (length > 2){
                data.readBytes(this._bitmapData, 0, (length - 2));
            };
        }
        public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, (this._bitmapData.length + 2));
            data.writeUI16(this.characterId);
            if (this._bitmapData.length > 0){
                data.writeBytes(this._bitmapData);
            };
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineBits");
        }
        override public function get version():uint{
            return (1);
        }
        public function toString(indent:uint=0):String{
            return ((((((toStringMain(indent) + "ID: ") + this.characterId) + ", ") + "Length: ") + this._bitmapData.length));
        }

    }
}//package com.codeazur.as3swf.tags 
