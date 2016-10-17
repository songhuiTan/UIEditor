//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class TagDebugID extends Tag implements ITag {

        public static const TYPE:uint = 63;

        protected var _uuid:ByteArray;

        public function TagDebugID(){
            super();
            this._uuid = new ByteArray();
        }
        public function get uuid():ByteArray{
            return (this._uuid);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            data.readBytes(this._uuid, 0, length);
        }
        public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, this._uuid.length);
            data.writeBytes(this._uuid);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DebugID");
        }
        override public function get version():uint{
            return (6);
        }
        public function toString(indent:uint=0):String{
            var str:String = (toStringMain(indent) + "UUID: ");
            if (this._uuid.length == 16){
                str = (str + StringUtils.printf("%02x%02x%02x%02x-", this._uuid[0], this._uuid[1], this._uuid[2], this._uuid[3]));
                str = (str + StringUtils.printf("%02x%02x-", this._uuid[4], this._uuid[5]));
                str = (str + StringUtils.printf("%02x%02x-", this._uuid[6], this._uuid[7]));
                str = (str + StringUtils.printf("%02x%02x-", this._uuid[8], this._uuid[9]));
                str = (str + StringUtils.printf("%02x%02x%02x%02x%02x%02x", this._uuid[10], this._uuid[11], this._uuid[12], this._uuid[13], this._uuid[14], this._uuid[15]));
            } else {
                str = (str + (("(invalid length: " + this._uuid.length) + ")"));
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
