//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf5 {
    import tInspector.com.codeazur.as3swf.data.actions.*;
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class ActionConstantPool extends Action implements IAction {

        public var constants:Vector.<String>;

        public function ActionConstantPool(code:uint, length:uint){
            super(code, length);
            this.constants = new Vector.<String>();
        }
        override public function parse(data:SWFData):void{
            var count:uint = data.readUI16();
            var i:uint;
            while (i < count) {
                this.constants.push(data.readString());
                i++;
            };
        }
        override public function publish(data:SWFData):void{
            var body:SWFData = new SWFData();
            body.writeUI16(this.constants.length);
            var i:uint;
            while (i < this.constants.length) {
                body.writeString(this.constants[i]);
                i++;
            };
            write(data, body);
        }
        public function toString(indent:uint=0):String{
            var str:String = ("[ActionConstantPool] Values: " + this.constants.length);
            var i:uint;
            while (i < this.constants.length) {
                str = (str + (((("\n" + StringUtils.repeat((indent + 4))) + i) + ": ") + StringUtils.simpleEscape(this.constants[i])));
                i++;
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data.actions.swf5 
