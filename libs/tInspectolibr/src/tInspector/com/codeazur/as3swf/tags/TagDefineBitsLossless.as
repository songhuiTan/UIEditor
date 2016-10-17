//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import flash.utils.*;
    
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.consts.*;

    public class TagDefineBitsLossless extends Tag implements ITag {

        public static const TYPE:uint = 20;

        public var characterId:uint;
        public var bitmapFormat:uint;
        public var bitmapWidth:uint;
        public var bitmapHeight:uint;
        public var bitmapColorTableSize:uint;
        protected var _zlibBitmapData:ByteArray;

        public function TagDefineBitsLossless(){
            super();
            this._zlibBitmapData = new ByteArray();
        }
        public function get zlibBitmapData():ByteArray{
            return (this._zlibBitmapData);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.characterId = data.readUI16();
            this.bitmapFormat = data.readUI8();
            this.bitmapWidth = data.readUI16();
            this.bitmapHeight = data.readUI16();
            if (this.bitmapFormat == BitmapFormat.BIT_8){
                this.bitmapColorTableSize = data.readUI8();
            };
			
			var countNum:uint=((this.bitmapFormat)==BitmapFormat.BIT_8) ? 8 : 7
			data.readBytes(this.zlibBitmapData, 0, (length - countNum));
//            data.readBytes(this.zlibBitmapData, 0, (length - ((this.bitmapFormat)==BitmapFormat.BIT_8) ? 8 : 7));
        }
        public function publish(data:SWFData, version:uint):void{
            var body:SWFData = new SWFData();
            body.writeUI16(this.characterId);
            body.writeUI8(this.bitmapFormat);
            body.writeUI16(this.bitmapWidth);
            body.writeUI16(this.bitmapHeight);
            if (this.bitmapFormat == BitmapFormat.BIT_8){
                body.writeUI8(this.bitmapColorTableSize);
            };
            if (this._zlibBitmapData.length > 0){
                body.writeBytes(this._zlibBitmapData);
            };
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineBitsLossless");
        }
        override public function get version():uint{
            return (2);
        }
        public function toString(indent:uint=0):String{
            return ((((((((((((toStringMain(indent) + "ID: ") + this.characterId) + ", ") + "Format: ") + BitmapFormat.toString(this.bitmapFormat)) + ", ") + "Size: (") + this.bitmapWidth) + ",") + this.bitmapHeight) + ")"));
        }

    }
}//package com.codeazur.as3swf.tags 
