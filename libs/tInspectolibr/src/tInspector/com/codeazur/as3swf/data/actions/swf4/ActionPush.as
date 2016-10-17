//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf4 {
    import tInspector.com.codeazur.as3swf.data.actions.*;
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import tInspector.com.codeazur.as3swf.*;

    public class ActionPush extends Action implements IAction {

        public var values:Vector.<SWFActionValue>;

        public function ActionPush(code:uint, length:uint){
            super(code, length);
            this.values = new Vector.<SWFActionValue>();
        }
        override public function parse(data:SWFData):void{
            var endPosition:uint = (data.position + length);
            while (data.position != endPosition) {
                this.values.push(data.readACTIONVALUE());
            };
        }
        override public function publish(data:SWFData):void{
            var body:SWFData = new SWFData();
            var i:uint;
            while (i < this.values.length) {
                body.writeACTIONVALUE(this.values[i]);
                i++;
            };
            write(data, body);
        }
        public function toString(indent:uint=0):String{
            return (("[ActionPush] " + this.values.join(", ")));
        }

    }
}//package com.codeazur.as3swf.data.actions.swf4 
