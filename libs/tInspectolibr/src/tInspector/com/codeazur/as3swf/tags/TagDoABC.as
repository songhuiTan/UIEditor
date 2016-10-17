//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.*;

    public class TagDoABC extends Tag implements ITag {

        public static const TYPE:uint = 82;

        public var lazyInitializeFlag:Boolean;
        public var abcName:String;
        protected var _bytes:ByteArray;

        public function TagDoABC(){
            super();
            this._bytes = new ByteArray();
        }
        public static function create(abcData:ByteArray=null, aName:String="", aLazyInitializeFlag:Boolean=true):TagDoABC{
            var doABC:TagDoABC = new (TagDoABC)();
            if (((!((abcData == null))) && ((abcData.length > 0)))){
                doABC.bytes.writeBytes(abcData);
            };
            doABC.abcName = aName;
            doABC.lazyInitializeFlag = aLazyInitializeFlag;
            return (doABC);
        }

        public function get bytes():ByteArray{
            return (this._bytes);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            var pos:uint = data.position;
            var flags:uint = data.readUI32();
            this.lazyInitializeFlag = !(((flags & 1) == 0));
            this.abcName = data.readString();
            data.readBytes(this.bytes, 0, (length - (data.position - pos)));
        }
        public function publish(data:SWFData, version:uint):void{
            var body:SWFData = new SWFData();
            body.writeUI32((this.lazyInitializeFlag) ? 1 : 0);
            body.writeString(this.abcName);
            if (this._bytes.length > 0){
                body.writeBytes(this._bytes);
            };
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DoABC");
        }
        override public function get version():uint{
            return (9);
        }
        public function toString(indent:uint=0):String{
            return (((((((toStringMain(indent) + "Lazy: ") + this.lazyInitializeFlag) + ", ") + ((this.abcName.length)>0) ? (("Name: " + this.abcName) + ", ") : "") + "Length: ") + this._bytes.length));
        }

    }
}//package com.codeazur.as3swf.tags 
