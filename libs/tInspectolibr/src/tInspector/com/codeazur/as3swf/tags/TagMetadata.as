//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;

    public class TagMetadata extends Tag implements ITag {

        public static const TYPE:uint = 77;

        public var xmlString:String;

        public function TagMetadata(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.xmlString = data.readString();
        }
        public function publish(data:SWFData, version:uint):void{
            var body:SWFData = new SWFData();
            body.writeString(this.xmlString);
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("Metadata");
        }
        override public function get version():uint{
            return (1);
        }
        public function toString(indent:uint=0):String{
            return (((toStringMain(indent) + " ") + this.xmlString));
        }

    }
}//package com.codeazur.as3swf.tags 
