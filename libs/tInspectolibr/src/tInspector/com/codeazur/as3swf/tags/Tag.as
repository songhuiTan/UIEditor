//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import flash.utils.*;
    import tInspector.com.codeazur.utils.*;

    public class Tag {

        protected var _type:uint;
        protected var _raw:ByteArray;

        public function Tag(){
            super();
        }
        public function get type():uint{
            return (this._type);
        }
        public function get name():String{
            return ("????");
        }
        public function get version():uint{
            return (0);
        }
        public function get raw():ByteArray{
            return (this._raw);
        }
        public function set raw(value:ByteArray):void{
            this._raw = value;
        }
        protected function toStringMain(indent:uint=0):String{
            return ((((((StringUtils.repeat(indent) + "[") + StringUtils.printf("%02d", this.type)) + ":") + this.name) + "] "));
        }

    }
}//package com.codeazur.as3swf.tags 
