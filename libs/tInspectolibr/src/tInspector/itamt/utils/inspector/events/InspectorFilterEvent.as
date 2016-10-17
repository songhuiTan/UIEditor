﻿//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.events {
    import flash.events.*;

    public class InspectorFilterEvent extends Event {

        public static const CHANGE:String = "inspector_change_filter";
        public static const APPLY:String = "inspector_apply_filter";
        public static const KILL:String = "inspector_kill_filter";
        public static const RESTORE:String = "inspector_restore_filter";

        public var filter:Class;

        public function InspectorFilterEvent(type:String, filter:Class, bubbles:Boolean=false, cancelable:Boolean=false){
            this.filter = filter;
            super(type, bubbles, cancelable);
        }
    }
}//package cn.itamt.utils.inspector.events 
