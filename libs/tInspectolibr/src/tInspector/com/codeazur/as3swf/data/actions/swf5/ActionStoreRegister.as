//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf5 {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.actions.*;

    public class ActionStoreRegister extends Action implements IAction {

        public var registerNumber:uint;

        public function ActionStoreRegister(code:uint, length:uint){
            super(code, length);
        }
        override public function parse(data:SWFData):void{
            this.registerNumber = data.readUI8();
        }
        override public function publish(data:SWFData):void{
            var body:SWFData = new SWFData();
            body.writeUI8(this.registerNumber);
            write(data, body);
        }
        public function toString(indent:uint=0):String{
            return (("[ActionStoreRegister] RegisterNumber: " + this.registerNumber));
        }

    }
}//package com.codeazur.as3swf.data.actions.swf5 
