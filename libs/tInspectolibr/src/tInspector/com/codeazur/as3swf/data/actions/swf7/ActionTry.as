//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf7 {
    import tInspector.com.codeazur.as3swf.data.actions.*;
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class ActionTry extends Action implements IAction {

        public var catchInRegisterFlag:Boolean;
        public var finallyBlockFlag:Boolean;
        public var catchBlockFlag:Boolean;
        public var catchName:String;
        public var catchRegister:uint;
        public var tryBody:Vector.<IAction>;
        public var catchBody:Vector.<IAction>;
        public var finallyBody:Vector.<IAction>;

        public function ActionTry(code:uint, length:uint){
            super(code, length);
            this.tryBody = new Vector.<IAction>();
            this.catchBody = new Vector.<IAction>();
            this.finallyBody = new Vector.<IAction>();
        }
        override public function parse(data:SWFData):void{
            var flags:uint = data.readUI8();
            this.catchInRegisterFlag = !(((flags & 4) == 0));
            this.finallyBlockFlag = !(((flags & 2) == 0));
            this.catchBlockFlag = !(((flags & 1) == 0));
            var trySize:uint = data.readUI16();
            var catchSize:uint = data.readUI16();
            var finallySize:uint = data.readUI16();
            if (this.catchInRegisterFlag){
                this.catchRegister = data.readUI8();
            } else {
                this.catchName = data.readString();
            };
            var tryEndPosition:uint = (data.position + trySize);
            while (data.position < tryEndPosition) {
                this.tryBody.push(data.readACTIONRECORD());
            };
            var catchEndPosition:uint = (data.position + catchSize);
            while (data.position < catchEndPosition) {
                this.catchBody.push(data.readACTIONRECORD());
            };
            var finallyEndPosition:uint = (data.position + finallySize);
            while (data.position < finallyEndPosition) {
                this.finallyBody.push(data.readACTIONRECORD());
            };
        }
        override public function publish(data:SWFData):void{
            var i:uint;
            var body:SWFData = new SWFData();
            var flags:uint;
            if (this.catchInRegisterFlag){
                flags = (flags | 4);
            };
            if (this.finallyBlockFlag){
                flags = (flags | 2);
            };
            if (this.catchBlockFlag){
                flags = (flags | 1);
            };
            body.writeUI8(flags);
            var bodyTryActions:SWFData = new SWFData();
            i = 0;
            while (i < this.tryBody.length) {
                bodyTryActions.writeACTIONRECORD(this.tryBody[i]);
                i++;
            };
            var bodyCatchActions:SWFData = new SWFData();
            i = 0;
            while (i < this.catchBody.length) {
                bodyCatchActions.writeACTIONRECORD(this.catchBody[i]);
                i++;
            };
            var bodyFinallyActions:SWFData = new SWFData();
            i = 0;
            while (i < this.finallyBody.length) {
                bodyFinallyActions.writeACTIONRECORD(this.finallyBody[i]);
                i++;
            };
            body.writeUI16(bodyTryActions.length);
            body.writeUI16(bodyCatchActions.length);
            body.writeUI16(bodyFinallyActions.length);
            if (this.catchInRegisterFlag){
                body.writeUI8(this.catchRegister);
            } else {
                body.writeString(this.catchName);
            };
            body.writeBytes(bodyTryActions);
            body.writeBytes(bodyCatchActions);
            body.writeBytes(bodyFinallyActions);
            write(data, body);
        }
        public function toString(indent:uint=0):String{
            var i:uint;
            var str:String = "[ActionTry] ";
            str = (str + (this.catchInRegisterFlag) ? ("Register: " + this.catchRegister) : ("Name: " + this.catchName));
            if (this.tryBody.length){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "Try:"));
                i = 0;
                while (i < this.tryBody.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this.tryBody[i].toString((indent + 4))));
                    i++;
                };
            };
            if (this.catchBody.length){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "Catch:"));
                i = 0;
                while (i < this.catchBody.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this.catchBody[i].toString((indent + 4))));
                    i++;
                };
            };
            if (this.finallyBody.length){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "Finally:"));
                i = 0;
                while (i < this.finallyBody.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this.finallyBody[i].toString((indent + 4))));
                    i++;
                };
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data.actions.swf7 
