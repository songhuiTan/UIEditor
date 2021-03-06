﻿//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.exporters.*;
    import tInspector.com.codeazur.as3swf.data.*;

    public class TagDefineShape extends Tag implements ITag {

        public static const TYPE:uint = 2;

        public var shapeId:uint;
        public var shapeBounds:SWFRectangle;
        public var shapes:SWFShapeWithStyle;

        public function TagDefineShape(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.shapeId = data.readUI16();
            this.shapeBounds = data.readRECT();
            this.shapes = data.readSHAPEWITHSTYLE();
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        public function export(handler:IShapeExportDocumentHandler=null):void{
            this.shapes.export(handler);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineShape");
        }
        public function toString(indent:uint=0):String{
            var str:String = (((((toStringMain(indent) + "ID: ") + this.shapeId) + ", ") + "Bounds: ") + this.shapeBounds);
            str = (str + this.shapes.toString((indent + 2)));
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
