//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import tInspector.com.codeazur.as3swf.*;

    public class TagDefineMorphShape extends Tag implements ITag {

        public static const TYPE:uint = 46;

        public var characterId:uint;
        public var startBounds:SWFRectangle;
        public var endBounds:SWFRectangle;
        public var startEdges:SWFShape;
        public var endEdges:SWFShape;
        protected var _morphFillStyles:Vector.<SWFMorphFillStyle>;
        protected var _morphLineStyles:Vector.<SWFMorphLineStyle>;

        public function TagDefineMorphShape(){
            super();
            this._morphFillStyles = new Vector.<SWFMorphFillStyle>();
            this._morphLineStyles = new Vector.<SWFMorphLineStyle>();
        }
        public function get morphFillStyles():Vector.<SWFMorphFillStyle>{
            return (this._morphFillStyles);
        }
        public function get morphLineStyles():Vector.<SWFMorphLineStyle>{
            return (this._morphLineStyles);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            var i:uint;
            this.characterId = data.readUI16();
            this.startBounds = data.readRECT();
            this.endBounds = data.readRECT();
            var offset:uint = data.readUI32();
            var fillStyleCount:uint = data.readUI8();
            if (fillStyleCount == 0xFF){
                fillStyleCount = data.readUI16();
            };
            i = 0;
            while (i < fillStyleCount) {
                this._morphFillStyles.push(data.readMORPHFILLSTYLE());
                i++;
            };
            var lineStyleCount:uint = data.readUI8();
            if (lineStyleCount == 0xFF){
                lineStyleCount = data.readUI16();
            };
            i = 0;
            while (i < lineStyleCount) {
                this._morphLineStyles.push(data.readMORPHLINESTYLE());
                i++;
            };
            this.startEdges = data.readSHAPE();
            this.endEdges = data.readSHAPE();
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineMorphShape");
        }
        override public function get version():uint{
            return (3);
        }
        public function toString(indent:uint=0):String{
            var str:String = ((((((((toStringMain(indent) + "ID: ") + this.characterId) + ", ") + "StartBounds: ") + this.startBounds.toString()) + ", ") + "EndBounds: ") + this.endBounds.toString());
            str = (str + this.startEdges.toString((indent + 2)));
            str = (str + this.endEdges.toString((indent + 2)));
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
