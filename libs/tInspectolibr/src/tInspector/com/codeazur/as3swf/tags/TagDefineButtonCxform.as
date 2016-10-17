//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.*;

    public class TagDefineButtonCxform extends Tag implements ITag {

        public static const TYPE:uint = 23;

        public var buttonId:uint;
        public var buttonColorTransform:SWFColorTransform;

        public function TagDefineButtonCxform(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.buttonId = data.readUI16();
            this.buttonColorTransform = data.readCXFORM();
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineButtonCxform");
        }
        public function toString(indent:uint=0):String{
            var str:String = (((((toStringMain(indent) + "ID: ") + this.buttonId) + ", ") + "ColorTransform: ") + this.buttonColorTransform);
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
