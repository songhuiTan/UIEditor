//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.filters {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;

    public class FilterColorMatrix extends Filter implements IFilter {

        protected var _colorMatrix:Vector.<Number>;

        public function FilterColorMatrix(id:uint){
            super(id);
            this._colorMatrix = new Vector.<Number>();
        }
        public function get colorMatrix():Vector.<Number>{
            return (this._colorMatrix);
        }
        override public function parse(data:SWFData):void{
            var i:uint;
            while (i < 20) {
                this._colorMatrix.push(data.readFLOAT);
                i++;
            };
        }

    }
}//package com.codeazur.as3swf.data.filters 
