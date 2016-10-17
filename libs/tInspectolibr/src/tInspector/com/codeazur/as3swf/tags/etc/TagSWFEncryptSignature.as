//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags.etc {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.tags.*;

    public class TagSWFEncryptSignature extends Tag implements ITag {

        public static const TYPE:uint = 0xFF;

        public function TagSWFEncryptSignature(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            data.skipBytes(length);
        }
        public function publish(data:SWFData, version:uint):void{
            if (raw != null){
                data.writeBytes(raw);
            } else {
                throw (new Error("No raw tag data available."));
            };
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("SWFEncryptSignature");
        }
        public function toString(indent:uint=0):String{
			return ""
//            return (((toStringMain(indent) + "Length: ") + ((raw)!=null) ? String( raw.length) : "unknown"));
        }

    }
}//package com.codeazur.as3swf.tags.etc 
