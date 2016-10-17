//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.*;

    public class TagDefineMorphShape2 extends TagDefineMorphShape implements ITag {

        public static const TYPE:uint = 84;

        public var startEdgeBounds:SWFRectangle;
        public var endEdgeBounds:SWFRectangle;
        public var usesNonScalingStrokes:Boolean;
        public var usesScalingStrokes:Boolean;

        public function TagDefineMorphShape2(){
            super();
        }
        override public function parse(data:SWFData, length:uint, version:uint):void{
            var i:uint;
            characterId = data.readUI16();
            startBounds = data.readRECT();
            endBounds = data.readRECT();
            this.startEdgeBounds = data.readRECT();
            this.endEdgeBounds = data.readRECT();
            var flags:uint = data.readUI8();
            this.usesNonScalingStrokes = !(((flags & 2) == 0));
            this.usesScalingStrokes = !(((flags & 1) == 0));
            var offset:uint = data.readUI32();
            var fillStyleCount:uint = data.readUI8();
            if (fillStyleCount == 0xFF){
                fillStyleCount = data.readUI16();
            };
            i = 0;
            while (i < fillStyleCount) {
                _morphFillStyles.push(data.readMORPHFILLSTYLE());
                i++;
            };
            var lineStyleCount:uint = data.readUI8();
            if (lineStyleCount == 0xFF){
                lineStyleCount = data.readUI16();
            };
            i = 0;
            while (i < lineStyleCount) {
                _morphLineStyles.push(data.readMORPHLINESTYLE2());
                i++;
            };
            startEdges = data.readSHAPE();
            endEdges = data.readSHAPE();
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineMorphShape2");
        }
        override public function get version():uint{
            return (8);
        }
        override public function toString(indent:uint=0):String{
            var str:String = ((((((((((((((toStringMain(indent) + "ID: ") + characterId) + ", ") + "StartBounds: ") + startBounds.toString()) + ", ") + "EndBounds: ") + endBounds.toString()) + ", ") + "StartEdgeBounds: ") + this.startEdgeBounds.toString()) + ", ") + "EndEdgeBounds: ") + this.endEdgeBounds.toString());
            str = (str + startEdges.toString((indent + 2)));
            str = (str + endEdges.toString((indent + 2)));
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
