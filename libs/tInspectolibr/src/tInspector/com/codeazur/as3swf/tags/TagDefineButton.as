//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import tInspector.com.codeazur.as3swf.data.actions.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class TagDefineButton extends Tag implements ITag {

        public static const TYPE:uint = 7;

        public var buttonId:uint;
        protected var _characters:Vector.<SWFButtonRecord>;
        protected var _actions:Vector.<IAction>;

        public function TagDefineButton(){
            super();
            this._characters = new Vector.<SWFButtonRecord>();
            this._actions = new Vector.<IAction>();
        }
        public function get characters():Vector.<SWFButtonRecord>{
            return (this._characters);
        }
        public function get actions():Vector.<IAction>{
            return (this._actions);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            var record:SWFButtonRecord;
            var action:IAction;
            this.buttonId = data.readUI16();
            while ((record = data.readBUTTONRECORD()) != null) {
                this._characters.push(record);
            };
            while ((action = data.readACTIONRECORD()) != null) {
                this._actions.push(action);
            };
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineButton");
        }
        public function toString(indent:uint=0):String{
            var i:uint;
            var str:String = ((toStringMain(indent) + "ID: ") + this.buttonId);
            if (this._characters.length > 0){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "Characters:"));
                i = 0;
                while (i < this._characters.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this._characters[i].toString()));
                    i++;
                };
            };
            if (this._actions.length > 0){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "Actions:"));
                i = 0;
                while (i < this._actions.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this._actions[i].toString((indent + 4))));
                    i++;
                };
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
