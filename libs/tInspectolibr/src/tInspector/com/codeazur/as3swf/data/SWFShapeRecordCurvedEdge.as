//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFShapeRecordCurvedEdge extends SWFShapeRecord {

        public var controlDeltaX:int;
        public var controlDeltaY:int;
        public var anchorDeltaX:int;
        public var anchorDeltaY:int;
        protected var numBits:uint;

        public function SWFShapeRecordCurvedEdge(data:SWFData=null, numBits:uint=0, level:uint=1){
            this.numBits = numBits;
            super(data, level);
        }
        override public function parse(data:SWFData=null, level:uint=1):void{
            this.controlDeltaX = data.readSB(this.numBits);
            this.controlDeltaY = data.readSB(this.numBits);
            this.anchorDeltaX = data.readSB(this.numBits);
            this.anchorDeltaY = data.readSB(this.numBits);
        }
        override public function get type():uint{
            return (SWFShapeRecord.TYPE_CURVEDEDGE);
        }
        override public function toString(indent:uint=0):String{
            return (((((((((("[SWFShapeRecordCurvedEdge] " + "ControlDelta: ") + this.controlDeltaX) + ",") + this.controlDeltaY) + ", ") + "AnchorDelta: ") + this.anchorDeltaX) + ",") + this.anchorDeltaY));
        }

    }
}//package com.codeazur.as3swf.data 
