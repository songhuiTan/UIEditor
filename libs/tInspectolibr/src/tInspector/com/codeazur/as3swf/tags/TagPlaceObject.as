//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.*;

    public class TagPlaceObject extends Tag implements ITag {

        public static const TYPE:uint = 4;

        public var hasClipActions:Boolean;
        public var hasClipDepth:Boolean;
        public var hasName:Boolean;
        public var hasRatio:Boolean;
        public var hasColorTransform:Boolean;
        public var hasMatrix:Boolean;
        public var hasCharacter:Boolean;
        public var hasMove:Boolean;
        public var characterId:uint;
        public var depth:uint;
        public var matrix:SWFMatrix;
        public var colorTransform:SWFColorTransform;

        public function TagPlaceObject(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            var pos:uint = data.position;
            this.characterId = data.readUI16();
            this.depth = data.readUI16();
            this.matrix = data.readMATRIX();
            this.hasCharacter = true;
            this.hasMatrix = true;
            if ((data.position - pos) < length){
                this.colorTransform = data.readCXFORM();
                this.hasColorTransform = true;
            };
        }
        public function publish(data:SWFData, version:uint):void{
            var body:SWFData = new SWFData();
            body.writeUI16(this.characterId);
            body.writeUI16(this.depth);
            body.writeMATRIX(this.matrix);
            if (this.hasColorTransform){
                body.writeCXFORM(this.colorTransform);
            };
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("PlaceObject");
        }
        public function toString(indent:uint=0):String{
            var str:String = ((toStringMain(indent) + "Depth: ") + this.depth);
            if (this.hasCharacter){
                str = (str + (", CharacterID: " + this.characterId));
            };
            if (this.hasMatrix){
                str = (str + (", Matrix: " + this.matrix));
            };
            if (this.hasColorTransform){
                str = (str + (", ColorTransform: " + this.colorTransform));
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
