//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFSoundEnvelope {

        public var pos44:uint;
        public var leftLevel:uint;
        public var rightLevel:uint;

        public function SWFSoundEnvelope(data:SWFData=null){
            super();
            if (data != null){
                this.parse(data);
            };
        }
        public function parse(data:SWFData):void{
            this.pos44 = data.readUI32();
            this.leftLevel = data.readUI16();
            this.rightLevel = data.readUI16();
        }
        public function toString():String{
            return ("[SWFSoundEnvelope]");
        }

    }
}//package com.codeazur.as3swf.data 
