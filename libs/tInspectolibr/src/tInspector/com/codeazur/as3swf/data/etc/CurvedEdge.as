//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.etc {
    import flash.geom.*;

    public class CurvedEdge extends StraightEdge implements IEdge {

        protected var _control:Point;

        public function CurvedEdge(aFrom:Point, aControl:Point, aTo:Point, aLineStyleIdx:uint=0, aFillStyleIdx:uint=0){
            super(aFrom, aTo, aLineStyleIdx, aFillStyleIdx);
            this._control = aControl;
        }
        public function get control():Point{
            return (this._control);
        }
        override public function reverseWithNewFillStyle(newFillStyleIdx:uint):IEdge{
            return (new CurvedEdge(to, this.control, from, lineStyleIdx, newFillStyleIdx));
        }
        override public function toString():String{
            return ((((((((((("stroke:" + lineStyleIdx) + ", fill:") + fillStyleIdx) + ", start:") + from.toString()) + ", control:") + this.control.toString()) + ", end:") + to.toString()) + (isDuplicate) ? " (DUPE)" : ""));
        }

    }
}//package com.codeazur.as3swf.data.etc 
