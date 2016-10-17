//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;

    public class SWFSoundInfo {

        public var syncStop:Boolean;
        public var syncNoMultiple:Boolean;
        public var hasEnvelope:Boolean;
        public var hasLoops:Boolean;
        public var hasOutPoint:Boolean;
        public var hasInPoint:Boolean;
        public var outPoint:uint;
        public var inPoint:uint;
        public var loopCount:uint;
        protected var _envelopeRecords:Vector.<SWFSoundEnvelope>;

        public function SWFSoundInfo(data:SWFData=null){
            super();
            this._envelopeRecords = new Vector.<SWFSoundEnvelope>();
            if (data != null){
                this.parse(data);
            };
        }
        public function get envelopeRecords():Vector.<SWFSoundEnvelope>{
            return (this._envelopeRecords);
        }
        public function parse(data:SWFData):void{
            var envPoints:uint;
            var i:uint;
            var flags:uint = data.readUI8();
            this.syncStop = !(((flags & 32) == 0));
            this.syncNoMultiple = !(((flags & 16) == 0));
            this.hasEnvelope = !(((flags & 8) == 0));
            this.hasLoops = !(((flags & 4) == 0));
            this.hasOutPoint = !(((flags & 2) == 0));
            this.hasInPoint = !(((flags & 1) == 0));
            if (this.hasInPoint){
                this.inPoint = data.readUI32();
            };
            if (this.hasOutPoint){
                this.outPoint = data.readUI32();
            };
            if (this.hasLoops){
                this.loopCount = data.readUI16();
            };
            if (this.hasEnvelope){
                envPoints = data.readUI8();
                i = 0;
                while (i < envPoints) {
                    this._envelopeRecords.push(data.readSOUNDENVELOPE());
                    i++;
                };
            };
        }
        public function toString():String{
            return ("[SWFSoundInfo]");
        }

    }
}//package com.codeazur.as3swf.data 
