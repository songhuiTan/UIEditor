//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class TagDefineButton2 extends Tag implements ITag {

        public static const TYPE:uint = 34;

        public var buttonId:uint;
        public var trackAsMenu:Boolean;
        protected var _characters:Vector.<SWFButtonRecord>;
        protected var _condActions:Vector.<SWFButtonCondAction>;

        public function TagDefineButton2(){
            super();
            this._characters = new Vector.<SWFButtonRecord>();
            this._condActions = new Vector.<SWFButtonCondAction>();
        }
        public function get characters():Vector.<SWFButtonRecord>{
            return (this._characters);
        }
        public function get condActions():Vector.<SWFButtonCondAction>{
            return (this._condActions);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            var record:SWFButtonRecord;
            var condAction:SWFButtonCondAction;
            this.buttonId = data.readUI16();
            this.trackAsMenu = !(((data.readUI8() & 1) == 0));
            var actionOffset:uint = data.readUI16();
            while ((record = data.readBUTTONRECORD(2)) != null) {
                this._characters.push(record);
            };
            if (actionOffset != 0){
                while (true) {
                    condAction = data.readBUTTONCONDACTION();
                    this._condActions.push(condAction);
                    if (condAction.condActionSize == 0){
                        break;
                    };
                };
            };
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineButton2");
        }
        public function toString(indent:uint=0):String{
            var i:uint;
            var str:String = ((((toStringMain(indent) + "ID: ") + this.buttonId) + ", TrackAsMenu: ") + this.trackAsMenu);
            if (this._characters.length > 0){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "Characters:"));
                i = 0;
                while (i < this._characters.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this._characters[i].toString()));
                    i++;
                };
            };
            if (this._condActions.length > 0){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "CondActions:"));
                i = 0;
                while (i < this._condActions.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this._condActions[i].toString((indent + 4))));
                    i++;
                };
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
