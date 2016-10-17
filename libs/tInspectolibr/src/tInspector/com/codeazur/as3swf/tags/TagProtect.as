//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.*;

    public class TagProtect extends Tag implements ITag {

        public static const TYPE:uint = 24;

        protected var _password:ByteArray;

        public function TagProtect(){
            super();
            this._password = new ByteArray();
        }
        public function get password():ByteArray{
            return (this._password);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            if (length > 0){
                data.readBytes(this._password, 0, length);
            };
        }
        public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, this._password.length);
            if (this._password.length > 0){
                data.writeBytes(this._password);
            };
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("Protect");
        }
        override public function get version():uint{
            return (2);
        }
        public function toString(indent:uint=0):String{
            return (toStringMain(indent));
        }

    }
}//package com.codeazur.as3swf.tags 
