//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.filters {
    import tInspector.com.codeazur.as3swf.*;

    public class FilterBevel extends Filter implements IFilter {

        public var shadowColor:uint;
        public var highlightColor:uint;
        public var blurX:Number;
        public var blurY:Number;
        public var angle:Number;
        public var distance:Number;
        public var strength:Number;
        public var innerShadow:Boolean;
        public var knockout:Boolean;
        public var compositeSource:Boolean;
        public var onTop:Boolean;
        public var passes:uint;

        public function FilterBevel(id:uint){
            super(id);
        }
        override public function parse(data:SWFData):void{
            this.shadowColor = data.readRGBA();
            this.highlightColor = data.readRGBA();
            this.blurX = data.readFIXED();
            this.blurY = data.readFIXED();
            this.angle = data.readFIXED();
            this.distance = data.readFIXED();
            this.strength = data.readFIXED8();
            var flags:uint = data.readUI8();
            this.innerShadow = !(((flags & 128) == 0));
            this.knockout = !(((flags & 64) == 0));
            this.compositeSource = !(((flags & 32) == 0));
            this.onTop = !(((flags & 16) == 0));
            this.passes = (flags & 15);
        }

    }
}//package com.codeazur.as3swf.data.filters 
