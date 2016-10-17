//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.etc {
    import flash.geom.*;

    public class StraightEdge implements IEdge {

        protected var _from:Point;
        protected var _to:Point;
        protected var _lineStyleIdx:uint = 0;
        protected var _fillStyleIdx:uint = 0;
        protected var _isDuplicate:Boolean = false;

        public function StraightEdge(aFrom:Point, aTo:Point, aLineStyleIdx:uint=0, aFillStyleIdx:uint=0){
            super();
            this._from = aFrom;
            this._to = aTo;
            this._lineStyleIdx = aLineStyleIdx;
            this._fillStyleIdx = aFillStyleIdx;
        }
        public function get from():Point{
            return (this._from);
        }
        public function get to():Point{
            return (this._to);
        }
        public function get lineStyleIdx():uint{
            return (this._lineStyleIdx);
        }
        public function get fillStyleIdx():uint{
            return (this._fillStyleIdx);
        }
        public function get isDuplicate():Boolean{
            return (this._isDuplicate);
        }
        public function set isDuplicate(value:Boolean):void{
            this._isDuplicate = value;
        }
        public function reverseWithNewFillStyle(newFillStyleIdx:uint):IEdge{
            return (new StraightEdge(this.to, this.from, this.lineStyleIdx, newFillStyleIdx));
        }
        public function toString():String{
            return ((((((((("stroke:" + this.lineStyleIdx) + ", fill:") + this.fillStyleIdx) + ", start:") + this.from.toString()) + ", end:") + this.to.toString()) + (this.isDuplicate) ? " (DUPE)" : ""));
        }

    }
}//package com.codeazur.as3swf.data.etc 
