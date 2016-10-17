﻿//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.events {
    import flash.events.*;

    public class PropertyEvent extends Event {

        public static var UPDATE:String = "update_property";
        public static var INSPECT:String = "inspect_property";
        public static var FAV:String = "add_to_favorites";
        public static var DEL_FAV:String = "remove_from_favorites";

        public function PropertyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
            super(type, bubbles, cancelable);
        }
    }
}//package cn.itamt.utils.inspector.events 
