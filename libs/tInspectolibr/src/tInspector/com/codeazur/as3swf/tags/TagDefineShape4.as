//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.*;

    public class TagDefineShape4 extends TagDefineShape3 implements ITag {

        public static const TYPE:uint = 83;

        public var edgeBounds:SWFRectangle;
        public var usesFillWindingRule:Boolean;
        public var usesNonScalingStrokes:Boolean;
        public var usesScalingStrokes:Boolean;

        public function TagDefineShape4(){
            super();
        }
        override public function parse(data:SWFData, length:uint, version:uint):void{
            shapeId = data.readUI16();
            shapeBounds = data.readRECT();
            this.edgeBounds = data.readRECT();
            var flags:uint = data.readUI8();
            this.usesFillWindingRule = !(((flags & 4) == 0));
            this.usesNonScalingStrokes = !(((flags & 2) == 0));
            this.usesScalingStrokes = !(((flags & 1) == 0));
            shapes = data.readSHAPEWITHSTYLE(4);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineShape4");
        }
        override public function toString(indent:uint=0):String{
            var str:String = ((((((((toStringMain(indent) + "ID: ") + shapeId) + ", ") + "ShapeBounds: ") + shapeBounds) + ", ") + "EdgeBounds: ") + this.edgeBounds);
            str = (str + shapes.toString((indent + 2)));
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
