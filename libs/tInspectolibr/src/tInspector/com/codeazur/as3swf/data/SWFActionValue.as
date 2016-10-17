//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.consts.*;
    import tInspector.com.codeazur.utils.*;

    public class SWFActionValue {

        public var type:uint;
        public var string:String;
        public var number:Number;
        public var register:uint;
        public var boolean:Boolean;
        public var integer:uint;
        public var constant:uint;

        public function SWFActionValue(data:SWFData=null){
            super();
            if (data != null){
                this.parse(data);
            };
        }
        public function parse(data:SWFData):void{
            this.type = data.readUI8();
            switch (this.type){
                case ActionValueType.STRING:
                    this.string = data.readString();
                    break;
                case ActionValueType.FLOAT:
                    this.number = data.readFLOAT();
                    break;
                case ActionValueType.NULL:
                    break;
                case ActionValueType.UNDEFINED:
                    break;
                case ActionValueType.REGISTER:
                    this.register = data.readUI8();
                    break;
                case ActionValueType.BOOLEAN:
                    this.boolean = !((data.readUI8() == 0));
                    break;
                case ActionValueType.DOUBLE:
                    this.number = data.readDOUBLE();
                    break;
                case ActionValueType.INTEGER:
                    this.integer = data.readUI32();
                    break;
                case ActionValueType.CONSTANT_8:
                    this.constant = data.readUI8();
                    break;
                case ActionValueType.CONSTANT_16:
                    this.constant = data.readUI16();
                    break;
                default:
                    throw (new Error(("Unknown ActionValueType: " + this.type)));
            };
        }
        public function publish(data:SWFData):void{
            data.writeUI8(this.type);
            switch (this.type){
                case ActionValueType.STRING:
                    data.writeString(this.string);
                    break;
                case ActionValueType.FLOAT:
                    data.writeFLOAT(this.number);
                    break;
                case ActionValueType.NULL:
                    break;
                case ActionValueType.UNDEFINED:
                    break;
                case ActionValueType.REGISTER:
                    data.writeUI8(this.register);
                    break;
                case ActionValueType.BOOLEAN:
                    data.writeUI8((this.boolean) ? 1 : 0);
                    break;
                case ActionValueType.DOUBLE:
                    data.writeDOUBLE(this.number);
                    break;
                case ActionValueType.INTEGER:
                    data.writeUI32(this.integer);
                    break;
                case ActionValueType.CONSTANT_8:
                    data.writeUI8(this.constant);
                    break;
                case ActionValueType.CONSTANT_16:
                    data.writeUI16(this.constant);
                    break;
                default:
                    throw (new Error(("Unknown ActionValueType: " + this.type)));
            };
        }
        public function toString():String{
            var str:String = "";
            switch (this.type){
                case ActionValueType.STRING:
                    str = (StringUtils.simpleEscape(this.string) + " (string)");
                    break;
                case ActionValueType.FLOAT:
                    str = (this.number + " (number)");
                    break;
                case ActionValueType.NULL:
                    str = "null";
                    break;
                case ActionValueType.UNDEFINED:
                    str = "undefined";
                    break;
                case ActionValueType.REGISTER:
                    str = (this.register + " (register)");
                    break;
                case ActionValueType.BOOLEAN:
                    str = (this.boolean + " (boolean)");
                    break;
                case ActionValueType.DOUBLE:
                    str = (this.number + " (double)");
                    break;
                case ActionValueType.INTEGER:
                    str = (this.integer + " (integer)");
                    break;
                case ActionValueType.CONSTANT_8:
                case ActionValueType.CONSTANT_16:
                    str = (this.constant + " (constant)");
                    break;
                default:
                    str = "unknown";
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data 
