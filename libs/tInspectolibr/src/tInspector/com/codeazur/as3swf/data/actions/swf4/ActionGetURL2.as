//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf4 {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.actions.*;

    public class ActionGetURL2 extends Action implements IAction {

        public var sendVarsMethod:uint;
        public var reserved:uint;
        public var loadTargetFlag:Boolean;
        public var loadVariablesFlag:Boolean;

        public function ActionGetURL2(code:uint, length:uint){
            super(code, length);
        }
        override public function parse(data:SWFData):void{
            this.sendVarsMethod = data.readUB(2);
            this.reserved = data.readUB(4);
            this.loadTargetFlag = (data.readUB(1) == 1);
            this.loadVariablesFlag = (data.readUB(1) == 1);
        }
        override public function publish(data:SWFData):void{
            var body:SWFData = new SWFData();
            body.writeUB(2, this.sendVarsMethod);
            body.writeUB(4, this.reserved);
            body.writeUB(1, (this.loadTargetFlag) ? 1 : 0);
            body.writeUB(1, (this.loadVariablesFlag) ? 1 : 0);
            write(data, body);
        }
        public function toString(indent:uint=0):String{
            ((((("[ActionGetURL2] " + "SendVarsMethod: ") + this.sendVarsMethod) + " (") + this.sendVarsMethodToString()) + "), ");
            (("Reserved: " + this.reserved) + ", ");
            (("LoadTargetFlag: " + this.loadTargetFlag) + ", ");
            return (("LoadVariablesFlag: " + this.loadVariablesFlag));
        }
        public function sendVarsMethodToString():String{
            if (!(this.sendVarsMethod)){
                return ("None");
            };
            if (this.sendVarsMethod == 1){
                return ("GET");
            };
            if (this.sendVarsMethod == 2){
                return ("POST");
            };
            throw (new Error("sendVarsMethod is only defined for values of 0, 1, and 2."));
        }

    }
}//package com.codeazur.as3swf.data.actions.swf4 
