//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.*;

    public class TagJPEGTables extends Tag implements ITag {

        public static const TYPE:uint = 8;

        protected var _jpegTables:ByteArray;

        public function TagJPEGTables(){
            super();
            this._jpegTables = new ByteArray();
        }
        public function get jpegTables():ByteArray{
            return (this._jpegTables);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            if (length > 0){
                data.readBytes(this._jpegTables, 0, length);
            };
        }
        public function publish(data:SWFData, version:uint):void{
            var body:SWFData = new SWFData();
            if (((this._jpegTables) && (this._jpegTables.length))){
                this._jpegTables.readBytes(data, 0, this._jpegTables.length);
            };
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("JPEGTables");
        }
        public function toString(indent:uint=0):String{
            return (((toStringMain(indent) + " Length: ") + this._jpegTables.length));
        }

    }
}//package com.codeazur.as3swf.tags 
