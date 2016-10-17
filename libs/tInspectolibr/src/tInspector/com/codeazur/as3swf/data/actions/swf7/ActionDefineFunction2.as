//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf7 {
    import tInspector.com.codeazur.as3swf.data.actions.*;
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class ActionDefineFunction2 extends Action implements IAction {

        public var functionName:String;
        public var functionParams:Vector.<SWFRegisterParam>;
        public var functionBody:Vector.<IAction>;
        public var registerCount:uint;
        public var preloadParent:Boolean;
        public var preloadRoot:Boolean;
        public var preloadSuper:Boolean;
        public var preloadArguments:Boolean;
        public var preloadThis:Boolean;
        public var preloadGlobal:Boolean;
        public var suppressSuper:Boolean;
        public var suppressArguments:Boolean;
        public var suppressThis:Boolean;

        public function ActionDefineFunction2(code:uint, length:uint){
            super(code, length);
            this.functionParams = new Vector.<SWFRegisterParam>();
            this.functionBody = new Vector.<IAction>();
        }
        override public function parse(data:SWFData):void{
            this.functionName = data.readString();
            var numParams:uint = data.readUI16();
            this.registerCount = data.readUI8();
            var flags1:uint = data.readUI8();
            this.preloadParent = !(((flags1 & 128) == 0));
            this.preloadRoot = !(((flags1 & 64) == 0));
            this.suppressSuper = !(((flags1 & 32) == 0));
            this.preloadSuper = !(((flags1 & 16) == 0));
            this.suppressArguments = !(((flags1 & 8) == 0));
            this.preloadArguments = !(((flags1 & 4) == 0));
            this.suppressThis = !(((flags1 & 2) == 0));
            this.preloadThis = !(((flags1 & 1) == 0));
            var flags2:uint = data.readUI8();
            this.preloadGlobal = !(((flags2 & 1) == 0));
            var i:uint;
            while (i < numParams) {
                this.functionParams.push(data.readREGISTERPARAM());
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
            body.writeUI8(this.registerCount);
            var flags1:uint;
            if (this.preloadParent){
                flags1 = (flags1 | 128);
            };
            if (this.preloadRoot){
                flags1 = (flags1 | 64);
            };
            if (this.suppressSuper){
                flags1 = (flags1 | 32);
            };
            if (this.preloadSuper){
                flags1 = (flags1 | 16);
            };
            if (this.suppressArguments){
                flags1 = (flags1 | 8);
            };
            if (this.preloadArguments){
                flags1 = (flags1 | 4);
            };
            if (this.suppressThis){
                flags1 = (flags1 | 2);
            };
            if (this.preloadThis){
                flags1 = (flags1 | 1);
            };
            body.writeUI8(flags1);
            var flags2:uint = data.readUI8();
            if (this.preloadGlobal){
                flags2 = (flags2 | 1);
            };
            body.writeUI8(flags2);
            i = 0;
            while (i < this.functionParams.length) {
                body.writeREGISTERPARAM(this.functionParams[i]);
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
            var str:String = (((("[ActionDefineFunction2] " + ((((this.functionName == null)) || ((this.functionName.length == 0)))) ? "<anonymous>" : this.functionName) + "(") + this.functionParams.join(", ")) + "), ");
            var a:Array = [];
            if (this.preloadParent){
                a.push("preloadParent");
            };
            if (this.preloadRoot){
                a.push("preloadRoot");
            };
            if (this.preloadSuper){
                a.push("preloadSuper");
            };
            if (this.preloadArguments){
                a.push("preloadArguments");
            };
            if (this.preloadThis){
                a.push("preloadThis");
            };
            if (this.preloadGlobal){
                a.push("preloadGlobal");
            };
            if (this.suppressSuper){
                a.push("suppressSuper");
            };
            if (this.suppressArguments){
                a.push("suppressArguments");
            };
            if (this.suppressThis){
                a.push("suppressThis");
            };
            if (a.length == 0){
                a.push("none");
            };
            str = (str + ("Flags: " + a.join(",")));
            var i:uint;
            while (i < this.functionBody.length) {
                str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this.functionBody[i].toString((indent + 4))));
                i++;
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data.actions.swf7 
