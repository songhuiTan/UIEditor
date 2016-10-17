//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.actions.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class SWFClipActionRecord {

        public var eventFlags:SWFClipEventFlags;
        public var keyCode:uint;
        protected var _actions:Vector.<IAction>;

        public function SWFClipActionRecord(data:SWFData=null, version:uint=0){
            super();
            this._actions = new Vector.<IAction>();
            if (data != null){
                this.parse(data, version);
            };
        }
        public function get actions():Vector.<IAction>{
            return (this._actions);
        }
        public function parse(data:SWFData, version:uint):void{
            var action:IAction;
            this.eventFlags = data.readCLIPEVENTFLAGS(version);
            data.readUI32();
            if (this.eventFlags.keyPressEvent){
                this.keyCode = data.readUI8();
            };
            while ((action = data.readACTIONRECORD()) != null) {
                this._actions.push(action);
            };
        }
        public function toString(indent:uint=0):String{
            var str:String = ("ClipActionRecords " + this.eventFlags.toString());
            if (this.keyCode > 0){
                str = (str + (", KeyCode: " + this.keyCode));
            };
            str = (str + ":");
            var i:uint;
            while (i < this._actions.length) {
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + this._actions[i].toString((indent + 2))));
                i++;
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data 
