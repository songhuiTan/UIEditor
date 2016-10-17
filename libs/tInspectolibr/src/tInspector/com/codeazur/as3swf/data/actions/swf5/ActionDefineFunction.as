//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf5 {
    import tInspector.com.codeazur.as3swf.data.actions.*;
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class ActionDefineFunction extends Action implements IAction {

        public var functionName:String;
        public var functionParams:Vector.<String>;
        public var functionBody:Vector.<IAction>;

        public function ActionDefineFunction(code:uint, length:uint){
            super(code, length);
            this.functionParams = new Vector.<String>();
            this.functionBody = new Vector.<IAction>();
        }
        override public function parse(data:SWFData):void{
            this.functionName = data.readString();
            var count:uint = data.readUI16();
            var i:uint;
            while (i < count) {
                this.functionParams.push(data.readString());
                i++;
            };
            var codeSize:uint = data.readUI16();
            var bodyEndPosition:uint = (data.position + codeSize);
            while (data.position < bodyEndPosition) {
                this.functionBody.push(data.readACTIONRECORD());
            };
        }
        override public function publish(data:SWFData):void{
            var i:uint;
            var body:SWFData = new SWFData();
            body.writeString(this.functionName);
            body.writeUI16(this.functionParams.length);
            i = 0;
            while (i < this.functionParams.length) {
                body.writeString(this.functionParams[i]);
                i++;
            };
            var bodyActions:SWFData = new SWFData();
            i = 0;
            while (i < this.functionBody.length) {
                bodyActions.writeACTIONRECORD(this.functionBody[i]);
                i++;
            };
            body.writeUI16(bodyActions.length);
            body.writeBytes(bodyActions);
            write(data, body);
        }
        public function toString(indent:uint=0):String{
            var str:String = (((("[ActionDefineFunction] " + ((((this.functionName == null)) || ((this.functionName.length == 0)))) ? "<anonymous>" : this.functionName) + "(") + this.functionParams.join(", ")) + ")");
            var i:uint;
            while (i < this.functionBody.length) {
                str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this.functionBody[i].toString((indent + 4))));
                i++;
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data.actions.swf5 
