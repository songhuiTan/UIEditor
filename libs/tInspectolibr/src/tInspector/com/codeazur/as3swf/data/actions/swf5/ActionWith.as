//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf5 {
    import tInspector.com.codeazur.as3swf.data.actions.*;
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class ActionWith extends Action implements IAction {

        public var withBody:Vector.<IAction>;

        public function ActionWith(code:uint, length:uint){
            super(code, length);
            this.withBody = new Vector.<IAction>();
        }
        override public function parse(data:SWFData):void{
            var codeSize:uint = data.readUI16();
            var bodyEndPosition:uint = (data.position + codeSize);
            while (data.position < bodyEndPosition) {
                this.withBody.push(data.readACTIONRECORD());
            };
        }
        override public function publish(data:SWFData):void{
            var body:SWFData = new SWFData();
            var bodyActions:SWFData = new SWFData();
            var i:uint;
            while (i < this.withBody.length) {
                bodyActions.writeACTIONRECORD(this.withBody[i]);
                i++;
            };
            body.writeUI16(bodyActions.length);
            body.writeBytes(bodyActions);
            write(data, body);
        }
        public function toString(indent:uint=0):String{
            var str:String = "[ActionWith]";
            var i:uint;
            while (i < this.withBody.length) {
                str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this.withBody[i].toString((indent + 4))));
                i++;
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data.actions.swf5 
