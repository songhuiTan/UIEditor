//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf3 {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.actions.*;

    public class ActionGotoFrame extends Action implements IAction {

        public var frame:uint;

        public function ActionGotoFrame(code:uint, length:uint){
            super(code, length);
        }
        override public function parse(data:SWFData):void{
            this.frame = data.readUI16();
        }
        override public function publish(data:SWFData):void{
            var body:SWFData = new SWFData();
            body.writeUI16(this.frame);
            write(data, body);
        }
        public function toString(indent:uint=0):String{
            return (("[ActionGotoFrame] Frame: " + this.frame));
        }

    }
}//package com.codeazur.as3swf.data.actions.swf3 
