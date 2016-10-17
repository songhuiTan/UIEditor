//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.events {
    import flash.events.*;

    public class TipEvent extends Event {

        public static const EVT_SHOW_TIP:String = "show_tip";
        public static const EVT_REMOVE_TIP:String = "remove_tip";

        public var tip:String;

        public function TipEvent(type:String, tip:String="this is a tip", bubbles:Boolean=true, cancelable:Boolean=false){
            super(type, bubbles, cancelable);
            this.tip = tip;
        }
    }
}//package cn.itamt.utils.inspector.events 
