//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf3 {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.actions.*;

    public class ActionSetTarget extends Action implements IAction {

        public var targetName:String;

        public function ActionSetTarget(code:uint, length:uint){
            super(code, length);
        }
        override public function parse(data:SWFData):void{
            this.targetName = data.readString();
        }
        override public function publish(data:SWFData):void{
            var body:SWFData = new SWFData();
            body.writeString(this.targetName);
            write(data, body);
        }
        public function toString(indent:uint=0):String{
            return (("[ActionSetTarget] TargetName: " + this.targetName));
        }

    }
}//package com.codeazur.as3swf.data.actions.swf3 
