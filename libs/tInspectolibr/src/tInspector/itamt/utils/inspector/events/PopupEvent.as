//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.events {
    import flash.display.*;
    import flash.events.*;

    public class PopupEvent extends Event {

        public static const ADD:String = "add_popup";
        public static const REMOVE:String = "remove_popup";

        public var popup:DisplayObject;

        public function PopupEvent(type:String, popup:DisplayObject, bubbles:Boolean=false, cancelable:Boolean=false){
            super(type, bubbles, cancelable);
            this.popup = popup;
        }
    }
}//package cn.itamt.utils.inspector.events 
