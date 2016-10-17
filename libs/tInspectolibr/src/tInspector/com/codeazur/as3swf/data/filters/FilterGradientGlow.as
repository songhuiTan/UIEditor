//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.filters {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;

    public class FilterGradientGlow extends Filter implements IFilter {

        public var numColors:uint;
        public var glowColor:uint;
        public var blurX:Number;
        public var blurY:Number;
        public var strength:Number;
        public var innerShadow:Boolean;
        public var knockout:Boolean;
        public var compositeSource:Boolean;
        public var onTop:Boolean;
        public var passes:uint;
        protected var _gradientColors:Vector.<uint>;
        protected var _gradientRatios:Vector.<uint>;

        public function FilterGradientGlow(id:uint){
            super(id);
            this._gradientColors = new Vector.<uint>();
            this._gradientRatios = new Vector.<uint>();
        }
        public function get gradientColors():Vector.<uint>{
            return (this._gradientColors);
        }
        public function get gradientRatios():Vector.<uint>{
            return (this._gradientRatios);
        }
        override public function parse(data:SWFData):void{
            var i:uint;
            this.numColors = data.readUI8();
            i = 0;
            while (i < this.numColors) {
                this._gradientColors.push(data.readRGBA());
                i++;
            };
            i = 0;
            while (i < this.numColors) {
                this._gradientRatios.push(data.readUI8());
                i++;
            };
            this.blurX = data.readFIXED();
            this.blurY = data.readFIXED();
            this.strength = data.readFIXED8();
            var flags:uint = data.readUI8();
            this.innerShadow = !(((flags & 128) == 0));
            this.knockout = !(((flags & 64) == 0));
            this.compositeSource = !(((flags & 32) == 0));
            this.onTop = !(((flags & 32) == 0));
            this.passes = (flags & 15);
        }

    }
}//package com.codeazur.as3swf.data.filters 
