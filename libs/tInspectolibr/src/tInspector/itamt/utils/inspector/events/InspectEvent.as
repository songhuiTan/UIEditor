//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.events {
    import flash.display.*;
    import flash.events.*;

    public class InspectEvent extends Event {

        public static const TURN_ON:String = "turn on";
        public static const TURN_OFF:String = "turn off";
        public static const RELOAD:String = "reload_swf";
        public static const LIVE_INSPECT:String = "live_inspect";
        public static const INSPECT:String = "inspect";
        public static const REFRESH:String = "refresh";

        private var _inspectTarget:DisplayObject;

        public function InspectEvent(type:String, inspectTarget:DisplayObject, bubbles:Boolean=false, cancelable:Boolean=false):void{
            this._inspectTarget = inspectTarget;
            super(type, bubbles, cancelable);
        }
        public function get inspectTarget():DisplayObject{
            return (this._inspectTarget);
        }

    }
}//package cn.itamt.utils.inspector.events 
