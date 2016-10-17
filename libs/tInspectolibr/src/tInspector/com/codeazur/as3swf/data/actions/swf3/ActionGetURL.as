//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf3 {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.actions.*;

    public class ActionGetURL extends Action implements IAction {

        public var urlString:String;
        public var targetString:String;

        public function ActionGetURL(code:uint, length:uint){
            super(code, length);
        }
        override public function parse(data:SWFData):void{
            this.urlString = data.readString();
            this.targetString = data.readString();
        }
        override public function publish(data:SWFData):void{
            var body:SWFData = new SWFData();
            body.writeString(this.urlString);
            body.writeString(this.targetString);
            write(data, body);
        }
        public function toString(indent:uint=0):String{
            return (((("[ActionGetURL] URL: " + this.urlString) + ", Target: ") + this.targetString));
        }

    }
}//package com.codeazur.as3swf.data.actions.swf3 
