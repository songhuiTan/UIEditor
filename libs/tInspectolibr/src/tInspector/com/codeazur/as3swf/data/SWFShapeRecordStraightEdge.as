//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFShapeRecordStraightEdge extends SWFShapeRecord {

        public var generalLineFlag:Boolean;
        public var vertLineFlag:Boolean;
        public var deltaY:int;
        public var deltaX:int;
        protected var numBits:uint;

        public function SWFShapeRecordStraightEdge(data:SWFData=null, numBits:uint=0, level:uint=1){
            this.numBits = numBits;
            super(data, level);
        }
        override public function parse(data:SWFData=null, level:uint=1):void{
            this.generalLineFlag = (data.readUB(1) == 1);
            this.vertLineFlag = (!(this.generalLineFlag)) ? !((data.readSB(1) == 0)) : false;
            this.deltaX = (((this.generalLineFlag) || (!(this.vertLineFlag)))) ? data.readSB(this.numBits) : 0;
            this.deltaY = (((this.generalLineFlag) || (this.vertLineFlag))) ? data.readSB(this.numBits) : 0;
        }
        override public function get type():uint{
            return (SWFShapeRecord.TYPE_STRAIGHTEDGE);
        }
        override public function toString(indent:uint=0):String{
            var str:String = "[SWFShapeRecordStraightEdge] ";
            if (this.generalLineFlag){
                str = (str + ((("General: " + this.deltaX) + ",") + this.deltaY));
            } else {
                if (this.vertLineFlag){
                    str = (str + ("Vertical: " + this.deltaY));
                } else {
                    str = (str + ("Horizontal: " + this.deltaX));
                };
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data 
