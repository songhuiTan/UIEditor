//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.*;

    public class TagSoundStreamBlock extends Tag implements ITag {

        public static const TYPE:uint = 19;

        protected var _soundData:ByteArray;

        public function TagSoundStreamBlock(){
            super();
            this._soundData = new ByteArray();
        }
        public function get soundData():ByteArray{
            return (this._soundData);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            data.readBytes(this._soundData, 0, length);
        }
        public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, this._soundData.length);
            if (this._soundData.length > 0){
                data.writeBytes(this._soundData);
            };
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("SoundStreamBlock");
        }
        public function toString(indent:uint=0):String{
            return (((toStringMain(indent) + "Length: ") + this._soundData.length));
        }

    }
}//package com.codeazur.as3swf.tags 
