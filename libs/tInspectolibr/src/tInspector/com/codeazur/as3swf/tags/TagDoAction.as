//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.actions.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class TagDoAction extends Tag implements ITag {

        public static const TYPE:uint = 12;

        protected var _actions:Vector.<IAction>;

        public function TagDoAction(){
            super();
            this._actions = new Vector.<IAction>();
        }
        public function get actions():Vector.<IAction>{
            return (this._actions);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            var action:IAction;
            while ((action = data.readACTIONRECORD()) != null) {
                this._actions.push(action);
            };
        }
        public function publish(data:SWFData, version:uint):void{
            var body:SWFData = new SWFData();
            var i:uint;
            while (i < this._actions.length) {
                body.writeACTIONRECORD(this._actions[i]);
                i++;
            };
            body.writeUI8(0);
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DoAction");
        }
        override public function get version():uint{
            return (3);
        }
        public function toString(indent:uint=0):String{
            var str:String = toStringMain(indent);
            var i:uint;
            while (i < this._actions.length) {
                str = (str + ((((("\n" + StringUtils.repeat((indent + 2))) + "[") + i) + "] ") + this._actions[i].toString((indent + 2))));
                i++;
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
