//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.*;

    public class TagDefineBinaryData extends Tag implements ITag {

        public static const TYPE:uint = 87;

        public var tagId:uint;
        protected var _binaryData:ByteArray;

        public function TagDefineBinaryData(){
            super();
            this._binaryData = new ByteArray();
        }
        public function get binaryData():ByteArray{
            return (this._binaryData);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.tagId = data.readUI16();
            data.readUI32();
            if (length > 6){
                data.readBytes(this._binaryData, 0, (length - 6));
            };
        }
        public function publish(data:SWFData, version:uint):void{
            var body:SWFData = new SWFData();
            body.writeUI16(this.tagId);
            body.writeUI32(0);
            if (this._binaryData.length > 0){
                body.writeBytes(this._binaryData);
            };
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineBinaryData");
        }
        override public function get version():uint{
            return (9);
        }
        public function toString(indent:uint=0):String{
            return (toStringMain(indent));
        }

    }
}//package com.codeazur.as3swf.tags 
