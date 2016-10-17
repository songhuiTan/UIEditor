//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;

    public class TagEnableDebugger2 extends TagEnableDebugger implements ITag {

        public static const TYPE:uint = 64;

        protected var _reserved:uint = 0;

        public function TagEnableDebugger2(){
            super();
        }
        public function get reserved():uint{
            return (this._reserved);
        }
        override public function parse(data:SWFData, length:uint, version:uint):void{
            this._reserved = data.readUI16();
            if (length > 2){
                data.readBytes(_password, 0, (length - 2));
            };
        }
        override public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, (_password.length + 2));
            data.writeUI16(this._reserved);
            if (_password.length > 0){
                data.writeBytes(_password);
            };
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("EnableDebugger2");
        }
        override public function get version():uint{
            return (6);
        }
        override public function toString(indent:uint=0):String{
            return ((((((toStringMain(indent) + "Password: ") + (_password.length) ? "null" : _password.readUTF()) + ", ") + "Reserved: 0x") + this._reserved.toString(16)));
        }

    }
}//package com.codeazur.as3swf.tags 
