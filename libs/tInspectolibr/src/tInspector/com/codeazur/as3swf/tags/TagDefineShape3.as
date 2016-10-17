//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;

    public class TagDefineShape3 extends TagDefineShape2 implements ITag {

        public static const TYPE:uint = 32;

        public function TagDefineShape3(){
            super();
        }
        override public function parse(data:SWFData, length:uint, version:uint):void{
            shapeId = data.readUI16();
            shapeBounds = data.readRECT();
            shapes = data.readSHAPEWITHSTYLE(3);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineShape3");
        }
        override public function toString(indent:uint=0):String{
            var str:String = (((((toStringMain(indent) + "ID: ") + shapeId) + ", ") + "Bounds: ") + shapeBounds);
            str = (str + shapes.toString((indent + 2)));
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
