//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class TagImportAssets extends Tag implements ITag {

        public static const TYPE:uint = 57;

        public var url:String;
        protected var _symbols:Vector.<SWFSymbol>;

        public function TagImportAssets(){
            super();
            this._symbols = new Vector.<SWFSymbol>();
        }
        public function get symbols():Vector.<SWFSymbol>{
            return (this._symbols);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.url = data.readString();
            var numSymbols:uint = data.readUI16();
            var i:uint;
            while (i < numSymbols) {
                this._symbols.push(data.readSYMBOL());
                i++;
            };
        }
        public function publish(data:SWFData, version:uint):void{
            var body:SWFData = new SWFData();
            body.writeString(this.url);
            var numSymbols:uint = this._symbols.length;
            body.writeUI16(numSymbols);
            var i:uint;
            while (i < numSymbols) {
                body.writeSYMBOL(this._symbols[i]);
                i++;
            };
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("ImportAssets");
        }
        override public function get version():uint{
            return (5);
        }
        public function toString(indent:uint=0):String{
            var i:uint;
            var str:String = toStringMain(indent);
            if (this._symbols.length > 0){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "Assets:"));
                i = 0;
                while (i < this._symbols.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this._symbols[i].toString()));
                    i++;
                };
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
