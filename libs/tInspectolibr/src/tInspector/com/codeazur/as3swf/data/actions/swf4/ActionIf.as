//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf4 {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.actions.*;

    public class ActionIf extends Action implements IAction {

        public var branchOffset:int;

        public function ActionIf(code:uint, length:uint){
            super(code, length);
        }
        override public function parse(data:SWFData):void{
            this.branchOffset = data.readSI16();
        }
        override public function publish(data:SWFData):void{
            var body:SWFData = new SWFData();
            body.writeSI16(this.branchOffset);
            write(data, body);
        }
        public function toString(indent:uint=0):String{
            return (("[ActionIf] BranchOffset: " + this.branchOffset));
        }

    }
}//package com.codeazur.as3swf.data.actions.swf4 
