//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.filters.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.consts.*;
    import tInspector.com.codeazur.utils.*;

    public class TagPlaceObject3 extends TagPlaceObject2 implements ITag {

        public static const TYPE:uint = 70;

        public var hasImage:Boolean;
        public var hasClassName:Boolean;
        public var hasCacheAsBitmap:Boolean;
        public var hasBlendMode:Boolean;
        public var hasFilterList:Boolean;
        public var className:String;
        public var blendMode:uint;
        public var bitmapCache:uint;
        protected var _surfaceFilterList:Vector.<IFilter>;

        public function TagPlaceObject3(){
            super();
            this._surfaceFilterList = new Vector.<IFilter>();
        }
        public function get surfaceFilterList():Vector.<IFilter>{
            return (this._surfaceFilterList);
        }
        override public function parse(data:SWFData, length:uint, version:uint):void{
            var flags1:uint;
            var numberOfFilters:uint;
            var i:uint;
            flags1 = data.readUI8();
            hasClipActions = !(((flags1 & 128) == 0));
            hasClipDepth = !(((flags1 & 64) == 0));
            hasName = !(((flags1 & 32) == 0));
            hasRatio = !(((flags1 & 16) == 0));
            hasColorTransform = !(((flags1 & 8) == 0));
            hasMatrix = !(((flags1 & 4) == 0));
            hasCharacter = !(((flags1 & 2) == 0));
            hasMove = !(((flags1 & 1) == 0));
            var flags2:uint = data.readUI8();
            this.hasImage = !(((flags2 & 16) == 0));
            this.hasClassName = !(((flags2 & 8) == 0));
            this.hasCacheAsBitmap = !(((flags2 & 4) == 0));
            this.hasBlendMode = !(((flags2 & 2) == 0));
            this.hasFilterList = !(((flags2 & 1) == 0));
            depth = data.readUI16();
            if (((this.hasClassName) || (((this.hasImage) && (hasCharacter))))){
                this.className = data.readString();
            };
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
                ratio = data.readUI16();
            };
            if (hasName){
                objName = data.readString();
            };
            if (hasClipDepth){
                clipDepth = data.readUI16();
            };
            if (this.hasFilterList){
                numberOfFilters = data.readUI8();
                i = 0;
                while (i < numberOfFilters) {
                    this._surfaceFilterList.push(data.readFILTER());
                    i++;
                };
            };
            if (this.hasBlendMode){
                this.blendMode = data.readUI8();
            };
            if (this.hasCacheAsBitmap){
                this.bitmapCache = data.readUI8();
            };
            if (hasClipActions){
                clipActions = data.readCLIPACTIONS(version);
            };
        }
        override public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("PlaceObject3");
        }
        override public function get version():uint{
            return (8);
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
                str = (str + (", Ratio: " + ratio));
            };
            if (hasName){
                str = (str + (", Name: " + objName));
            };
            if (this.hasBlendMode){
                str = (str + (", BlendMode: " + BlendMode.toString(this.blendMode)));
            };
            if (this.hasCacheAsBitmap){
                str = (str + (", CacheAsBitmap: " + this.bitmapCache));
            };
            if (hasClipActions){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + clipActions.toString((indent + 2))));
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
