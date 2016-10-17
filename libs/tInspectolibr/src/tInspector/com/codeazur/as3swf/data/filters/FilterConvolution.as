//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.filters {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;

    public class FilterConvolution extends Filter implements IFilter {

        public var matrixX:uint;
        public var matrixY:uint;
        public var divisor:Number;
        public var bias:Number;
        public var defaultColor:uint;
        public var clamp:Boolean;
        public var preserveAlpha:Boolean;
        protected var _matrix:Vector.<Number>;

        public function FilterConvolution(id:uint){
            super(id);
            this._matrix = new Vector.<Number>();
        }
        public function get matrix():Vector.<Number>{
            return (this._matrix);
        }
        override public function parse(data:SWFData):void{
            this.matrixX = data.readUI8();
            this.matrixY = data.readUI8();
            this.divisor = data.readFLOAT();
            this.bias = data.readFLOAT();
            var len:uint = (this.matrixX * this.matrixY);
            var i:uint;
            while (i < len) {
                this._matrix.push(data.readFLOAT);
                i++;
            };
            this.defaultColor = data.readRGBA();
            var flags:uint = data.readUI8();
            this.clamp = !(((flags & 2) == 0));
            this.preserveAlpha = !(((flags & 1) == 0));
        }

    }
}//package com.codeazur.as3swf.data.filters 
