//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;
    import tInspector.com.codeazur.as3swf.data.*;

    public class TagPlaceObject2 extends TagPlaceObject implements ITag {

        public static const TYPE:uint = 26;

        public var ratio:uint;
        public var objName:String;
        public var clipDepth:uint;
        public var clipActions:SWFClipActions;

        public function TagPlaceObject2(){
            super();
        }
        override public function parse(data:SWFData, length:uint, version:uint):void{
            var flags:uint = data.readUI8();
            hasClipActions = !(((flags & 128) == 0));
            hasClipDepth = !(((flags & 64) == 0));
            hasName = !(((flags & 32) == 0));
            hasRatio = !(((flags & 16) == 0));
            hasColorTransform = !(((flags & 8) == 0));
            hasMatrix = !(((flags & 4) == 0));
            hasCharacter = !(((flags & 2) == 0));
            hasMove = !(((flags & 1) == 0));
            depth = data.readUI16();
            if (hasCharacter){
                characterId = data.readUI16();
            };
            if (hasMatrix){
                matrix = data.readMATRIX();
            };
            if (hasColorTransform){
                colorTransform = data.readCXFORMWITHALPHA();
            };
            if (hasRatio){
                this.ratio = data.readUI16();
            };
            if (hasName){
                this.objName = data.readString();
            };
            if (hasClipDepth){
                this.clipDepth = data.readUI16();
            };
            if (hasClipActions){
                this.clipActions = data.readCLIPACTIONS(version);
            };
        }
        override public function publish(data:SWFData, version:uint):void{
            var flags:uint;
            var body:SWFData = new SWFData();
            if (hasMove){
                flags = (flags | 1);
            };
            if (hasCharacter){
                flags = (flags | 2);
            };
            if (hasMatrix){
                flags = (flags | 4);
            };
            if (hasColorTransform){
                flags = (flags | 8);
            };
            if (hasRatio){
                flags = (flags | 16);
            };
            if (hasName){
                flags = (flags | 32);
            };
            if (hasClipDepth){
                flags = (flags | 64);
            };
            if (hasClipActions){
                flags = (flags | 128);
            };
            body.writeUI8(flags);
            body.writeUI16(depth);
            if (hasMove){
            };
            if (hasCharacter){
                body.writeUI16(characterId);
            };
            if (hasMatrix){
                body.writeMATRIX(matrix);
            };
            if (hasColorTransform){
                body.writeCXFORM(colorTransform);
            };
            if (hasRatio){
                body.writeUI16(this.ratio);
            };
            if (hasName){
                body.writeString(this.objName);
            };
            if (hasClipDepth){
                body.writeUI16(this.clipDepth);
            };
            if (hasClipActions){
            };
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("PlaceObject2");
        }
        override public function toString(indent:uint=0):String{
            var str:String = ((toStringMain(indent) + "Depth: ") + depth);
            if (hasCharacter){
                str = (str + (", CharacterID: " + characterId));
            };
            if (hasMatrix){
                str = (str + (", Matrix: " + matrix.toString()));
            };
            if (hasColorTransform){
                str = (str + (", ColorTransform: " + colorTransform));
            };
            if (hasRatio){
                str = (str + (", Ratio: " + this.ratio));
            };
            if (hasName){
                str = (str + (", Name: " + this.objName));
            };
            if (hasClipActions){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + this.clipActions.toString((indent + 2))));
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
