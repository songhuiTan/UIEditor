//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.events {
    import flash.events.*;

    public class DisplayItemEvent extends Event {

        public static const EXPAND:String = "expand_childs";
        public static const COLLAPSE:String = "collapse_childs";
        public static const CHANGE:String = "item_change";
        public static const OVER:String = "item_over";
        public static const CLICK:String = "item_click";

        public function DisplayItemEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
            super(type, bubbles, cancelable);
        }
    }
}//package cn.itamt.utils.inspector.events 
