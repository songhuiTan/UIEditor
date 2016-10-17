//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.data.actions.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class TagDoInitAction extends TagDoAction implements ITag {

        public static const TYPE:uint = 59;

        public var spriteId:uint;

        public function TagDoInitAction(){
            super();
        }
        override public function parse(data:SWFData, length:uint, version:uint):void{
            var action:IAction;
            this.spriteId = data.readUI16();
            while ((action = data.readACTIONRECORD()) != null) {
                _actions.push(action);
            };
        }
        override public function publish(data:SWFData, version:uint):void{
            var body:SWFData = new SWFData();
            body.writeUI16(this.spriteId);
            var i:uint;
            while (i < _actions.length) {
                body.writeACTIONRECORD(_actions[i]);
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
            return ("DoInitAction");
        }
        override public function get version():uint{
            return (6);
        }
        override public function toString(indent:uint=0):String{
            var str:String = (((toStringMain(indent) + "SpriteID: ") + this.spriteId) + ", ");
            ("Records: " + _actions.length);
            var i:uint;
            while (i < _actions.length) {
                str = (str + ((((("\n" + StringUtils.repeat((indent + 2))) + "[") + i) + "] ") + _actions[i].toString((indent + 2))));
                i++;
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 
