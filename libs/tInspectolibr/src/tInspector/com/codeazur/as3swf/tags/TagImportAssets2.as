//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;

    public class TagImportAssets2 extends TagImportAssets implements ITag {

        public static const TYPE:uint = 71;

        public function TagImportAssets2(){
            super();
        }
        override public function parse(data:SWFData, length:uint, version:uint):void{
            url = data.readString();
            data.readUI8();
            data.readUI8();
            var numSymbols:uint = data.readUI16();
            var i:uint;
            while (i < numSymbols) {
                _symbols.push(data.readSYMBOL());
                i++;
            };
        }
        override public function publish(data:SWFData, version:uint):void{
            var body:SWFData = new SWFData();
            body.writeString(url);
            body.writeUI8(1);
            body.writeUI8(0);
            var numSymbols:uint = _symbols.length;
            body.writeUI16(numSymbols);
            var i:uint;
            while (i < numSymbols) {
                body.writeSYMBOL(_symbols[i]);
                i++;
            };
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("ImportAssets2");
        }
        override public function get version():uint{
            return (8);
        }

    }
}//package com.codeazur.as3swf.tags 
