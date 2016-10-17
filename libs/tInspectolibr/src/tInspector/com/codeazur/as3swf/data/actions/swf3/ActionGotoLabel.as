//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf3 {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.actions.*;

    public class ActionGotoLabel extends Action implements IAction {

        public var label:String;

        public function ActionGotoLabel(code:uint, length:uint){
            super(code, length);
        }
        override public function parse(data:SWFData):void{
            this.label = data.readString();
        }
        override public function publish(data:SWFData):void{
            var body:SWFData = new SWFData();
            body.writeString(this.label);
            write(data, body);
        }
        public function toString(indent:uint=0):String{
            return (("[ActionGotoLabel] Label: " + this.label));
        }

    }
}//package com.codeazur.as3swf.data.actions.swf3 
