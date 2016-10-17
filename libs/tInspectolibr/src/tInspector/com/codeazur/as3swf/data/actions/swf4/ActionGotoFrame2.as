//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf4 {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.actions.*;

    public class ActionGotoFrame2 extends Action implements IAction {

        public var sceneBiasFlag:Boolean;
        public var playFlag:Boolean;
        public var sceneBias:uint;

        public function ActionGotoFrame2(code:uint, length:uint){
            super(code, length);
        }
        override public function parse(data:SWFData):void{
            var flags:uint = data.readUI8();
            this.sceneBiasFlag = !(((flags & 2) == 0));
            this.playFlag = !(((flags & 1) == 0));
            if (this.sceneBiasFlag){
                this.sceneBias = data.readUI16();
            };
        }
        override public function publish(data:SWFData):void{
            var body:SWFData = new SWFData();
            var flags:uint;
            if (this.sceneBiasFlag){
                flags = (flags | 2);
            };
            if (this.playFlag){
                flags = (flags | 1);
            };
            body.writeUI8(flags);
            if (this.sceneBiasFlag){
                body.writeUI16(this.sceneBias);
            };
            write(data, body);
        }
        public function toString(indent:uint=0):String{
            var str:String = ((("[ActionGotoFrame2] " + "PlayFlag: ") + this.playFlag) + ", ");
            ("SceneBiasFlag: " + this.sceneBiasFlag);
            if (this.sceneBiasFlag){
                str = (str + (", " + this.sceneBias));
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data.actions.swf4 
