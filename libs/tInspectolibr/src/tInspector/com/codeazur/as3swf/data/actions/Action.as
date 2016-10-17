//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions {
    import tInspector.com.codeazur.as3swf.*;

    public class Action {

        protected var _code:uint;
        protected var _length:uint;

        public function Action(code:uint, length:uint){
            super();
            this._code = code;
            this._length = length;
        }
        public function get code():uint{
            return (this._code);
        }
        public function get length():uint{
            return (this._length);
        }
        public function parse(data:SWFData):void{
        }
        public function publish(data:SWFData):void{
            this.write(data);
        }
        protected function write(data:SWFData, body:SWFData=null):void{
            data.writeUI8(this.code);
            if (this.code >= 128){
                if (((!((body == null))) && ((body.length > 0)))){
                    this._length = body.length;
                    data.writeUI16(this._length);
                    data.writeBytes(body);
                } else {
                    this._length = 0;
                    throw (new Error("Action body null or empty."));
                };
            } else {
                this._length = 0;
            };
        }

    }
}//package com.codeazur.as3swf.data.actions 
