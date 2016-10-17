//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class SWFShapeRecordStyleChange extends SWFShapeRecord {

        public var stateNewStyles:Boolean;
        public var stateLineStyle:Boolean;
        public var stateFillStyle1:Boolean;
        public var stateFillStyle0:Boolean;
        public var stateMoveTo:Boolean;
        public var moveDeltaX:int = 0;
        public var moveDeltaY:int = 0;
        public var fillStyle0:uint = 0;
        public var fillStyle1:uint = 0;
        public var lineStyle:uint = 0;
        public var numFillBits:uint = 0;
        public var numLineBits:uint = 0;
        protected var _fillStyles:Vector.<SWFFillStyle>;
        protected var _lineStyles:Vector.<SWFLineStyle>;

        public function SWFShapeRecordStyleChange(data:SWFData=null, states:uint=0, fillBits:uint=0, lineBits:uint=0, level:uint=1){
            this._fillStyles = new Vector.<SWFFillStyle>();
            this._lineStyles = new Vector.<SWFLineStyle>();
            this.stateNewStyles = !(((states & 16) == 0));
            this.stateLineStyle = !(((states & 8) == 0));
            this.stateFillStyle1 = !(((states & 4) == 0));
            this.stateFillStyle0 = !(((states & 2) == 0));
            this.stateMoveTo = !(((states & 1) == 0));
            this.numFillBits = fillBits;
            this.numLineBits = lineBits;
            super(data, level);
        }
        public function get fillStyles():Vector.<SWFFillStyle>{
            return (this._fillStyles);
        }
        public function get lineStyles():Vector.<SWFLineStyle>{
            return (this._lineStyles);
        }
        override public function get type():uint{
            return (SWFShapeRecord.TYPE_STYLECHANGE);
        }
        override public function parse(data:SWFData=null, level:uint=1):void{
            var moveBits:uint;
            var i:uint;
            var fillStylesLen:uint;
            var lineStylesLen:uint;
            if (this.stateMoveTo){
                moveBits = data.readUB(5);
                this.moveDeltaX = data.readSB(moveBits);
                this.moveDeltaY = data.readSB(moveBits);
            };
            this.fillStyle0 = (this.stateFillStyle0) ? data.readUB(this.numFillBits) : 0;
            this.fillStyle1 = (this.stateFillStyle1) ? data.readUB(this.numFillBits) : 0;
            this.lineStyle = (this.stateLineStyle) ? data.readUB(this.numLineBits) : 0;
            if (this.stateNewStyles){
                data.resetBitsPending();
                fillStylesLen = this.readStyleArrayLength(data, level);
                i = 0;
                while (i < fillStylesLen) {
                    this.fillStyles.push(data.readFILLSTYLE(level));
                    i++;
                };
                lineStylesLen = this.readStyleArrayLength(data, level);
                i = 0;
                while (i < lineStylesLen) {
                    this.lineStyles.push(((level <= 3)) ? data.readLINESTYLE(level) : data.readLINESTYLE2(level));
                    i++;
                };
                this.numFillBits = data.readUB(4);
                this.numLineBits = data.readUB(4);
            };
        }
        protected function readStyleArrayLength(data:SWFData, level:uint=1):uint{
            var len:uint = data.readUI8();
            if ((((level >= 2)) && ((len == 0xFF)))){
                len = data.readUI16();
            };
            return (len);
        }
        override public function toString(indent:uint=0):String{
            var i:uint;
            var str:String = "[SWFShapeRecordStyleChange] ";
            var cmds:Array = [];
            if (this.stateMoveTo){
                cmds.push(((("MoveTo: " + this.moveDeltaX) + ",") + this.moveDeltaY));
            };
            if (this.stateFillStyle0){
                cmds.push(("FillStyle0: " + this.fillStyle0));
            };
            if (this.stateFillStyle1){
                cmds.push(("FillStyle1: " + this.fillStyle1));
            };
            if (this.stateLineStyle){
                cmds.push(("LineStyle: " + this.lineStyle));
            };
            if (cmds.length > 0){
                str = (str + cmds.join(", "));
            };
            if (this.stateNewStyles){
                if (this._fillStyles.length > 0){
                    str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "New FillStyles:"));
                    i = 0;
                    while (i < this._fillStyles.length) {
                        str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + (i + 1)) + "] ") + this._fillStyles[i].toString()));
                        i++;
                    };
                };
                if (this._lineStyles.length > 0){
                    str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "New LineStyles:"));
                    i = 0;
                    while (i < this._lineStyles.length) {
                        str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + (i + 1)) + "] ") + this._lineStyles[i].toString()));
                        i++;
                    };
                };
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data 
