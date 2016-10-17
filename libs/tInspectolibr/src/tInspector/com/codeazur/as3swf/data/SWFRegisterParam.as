//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFRegisterParam {

        public var register:uint;
        public var name:String;

        public function SWFRegisterParam(data:SWFData=null){
            super();
            if (data != null){
                this.parse(data);
            };
        }
        public function parse(data:SWFData):void{
            this.register = data.readUI8();
            this.name = data.readString();
        }
        public function publish(data:SWFData):void{
            data.writeUI8(this.register);
            data.writeString(this.name);
        }
        public function toString():String{
            return (((this.register + ":") + this.name));
        }

    }
}//package com.codeazur.as3swf.data 
