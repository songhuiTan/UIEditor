//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.actions.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class SWFButtonCondAction {

        public var condActionSize:uint;
        public var condIdleToOverDown:Boolean;
        public var condOutDownToIdle:Boolean;
        public var condOutDownToOverDown:Boolean;
        public var condOverDownToOutDown:Boolean;
        public var condOverDownToOverUp:Boolean;
        public var condOverUpToOverDown:Boolean;
        public var condOverUpToIdle:Boolean;
        public var condIdleToOverUp:Boolean;
        public var condOverDownToIdle:Boolean;
        public var condKeyPress:uint;
        protected var _actions:Vector.<IAction>;

        public function SWFButtonCondAction(data:SWFData=null){
            super();
            this._actions = new Vector.<IAction>();
            if (data != null){
                this.parse(data);
            };
        }
        public function get actions():Vector.<IAction>{
            return (this._actions);
        }
        public function parse(data:SWFData):void{
            var action:IAction;
            this.condActionSize = data.readUI16();
            var flags:uint = ((data.readUI8() << 8) | data.readUI8());
            this.condIdleToOverDown = !(((flags & 0x8000) == 0));
            this.condOutDownToIdle = !(((flags & 0x4000) == 0));
            this.condOutDownToOverDown = !(((flags & 0x2000) == 0));
            this.condOverDownToOutDown = !(((flags & 0x1000) == 0));
            this.condOverDownToOverUp = !(((flags & 0x0800) == 0));
            this.condOverUpToOverDown = !(((flags & 0x0400) == 0));
            this.condOverUpToIdle = !(((flags & 0x0200) == 0));
            this.condIdleToOverUp = !(((flags & 0x0100) == 0));
            this.condOverDownToIdle = !(((flags & 1) == 0));
            this.condKeyPress = ((flags & 0xFF) >> 1);
            while ((action = data.readACTIONRECORD()) != null) {
                this._actions.push(action);
            };
        }
        public function toString(indent:uint=0):String{
            var a:Array = [];
            if (this.condIdleToOverDown){
                a.push("idleToOverDown");
            };
            if (this.condOutDownToIdle){
                a.push("outDownToIdle");
            };
            if (this.condOutDownToOverDown){
                a.push("outDownToOverDown");
            };
            if (this.condOverDownToOutDown){
                a.push("overDownToOutDown");
            };
            if (this.condOverDownToOverUp){
                a.push("overDownToOverUp");
            };
            if (this.condOverUpToOverDown){
                a.push("overUpToOverDown");
            };
            if (this.condOverUpToIdle){
                a.push("overUpToIdle");
            };
            if (this.condIdleToOverUp){
                a.push("idleToOverUp");
            };
            if (this.condOverDownToIdle){
                a.push("overDownToIdle");
            };
            var str:String = ((("Cond: (" + a.join(",")) + "), KeyPress: ") + this.condKeyPress);
            var i:uint;
            while (i < this._actions.length) {
                str = (str + ((((("\n" + StringUtils.repeat((indent + 2))) + "[") + i) + "] ") + this._actions[i].toString((indent + 2))));
                i++;
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data 
