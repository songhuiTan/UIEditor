//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.filters.*;
    import tInspector.com.codeazur.as3swf.*;

    public class SWFButtonRecord {

        public var hasBlendMode:Boolean;
        public var hasFilterList:Boolean;
        public var stateHitTest:Boolean;
        public var stateDown:Boolean;
        public var stateOver:Boolean;
        public var stateUp:Boolean;
        public var characterId:uint;
        public var placeDepth:uint;
        public var placeMatrix:SWFMatrix;
        public var colorTransform:SWFColorTransformWithAlpha;
        public var blendMode:uint;
        protected var _filterList:Vector.<IFilter>;

        public function SWFButtonRecord(data:SWFData=null, level:uint=1){
            super();
            this._filterList = new Vector.<IFilter>();
            if (data != null){
                this.parse(data, level);
            };
        }
        public function get filterList():Vector.<IFilter>{
            return (this._filterList);
        }
        public function parse(data:SWFData, level:uint=1):void{
            var numberOfFilters:uint;
            var i:uint;
            var flags:uint = data.readUI8();
            this.hasBlendMode = !(((flags & 32) == 0));
            this.hasFilterList = !(((flags & 16) == 0));
            this.stateHitTest = !(((flags & 8) == 0));
            this.stateDown = !(((flags & 4) == 0));
            this.stateOver = !(((flags & 2) == 0));
            this.stateUp = !(((flags & 1) == 0));
            this.characterId = data.readUI16();
            this.placeDepth = data.readUI16();
            this.placeMatrix = data.readMATRIX();
            if (level >= 2){
                this.colorTransform = data.readCXFORMWITHALPHA();
                if (this.hasFilterList){
                    numberOfFilters = data.readUI8();
                    i = 0;
                    while (i < numberOfFilters) {
                        this._filterList.push(data.readFILTER());
                        i++;
                    };
                };
                if (this.hasBlendMode){
                    this.blendMode = data.readUI8();
                };
            };
        }
        public function toString():String{
            var str:String = (((("Depth: " + this.placeDepth) + ", CharacterID: ") + this.characterId) + ", States: ");
            var states:Array = [];
            if (this.stateUp){
                states.push("up");
            };
            if (this.stateOver){
                states.push("over");
            };
            if (this.stateDown){
                states.push("down");
            };
            if (this.stateHitTest){
                states.push("hit");
            };
            str = (str + states.join(","));
            return (str);
        }

    }
}//package com.codeazur.as3swf.data 
