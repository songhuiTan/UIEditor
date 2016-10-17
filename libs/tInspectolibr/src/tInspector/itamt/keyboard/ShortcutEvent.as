//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.keyboard {
    import flash.events.*;

    public class ShortcutEvent extends Event {

        public static const DOWN:String = "shortcut_down";
        public static const UP:String = "shortcut_UP";

        public var shortcut:Shortcut;

        public function ShortcutEvent(shortcut:Shortcut, type:String, bubbles:Boolean=false, cancelabe:Boolean=true):void{
            super(type, bubbles, cancelabe);
            this.shortcut = shortcut;
        }
    }
}//package cn.itamt.keyboard 
