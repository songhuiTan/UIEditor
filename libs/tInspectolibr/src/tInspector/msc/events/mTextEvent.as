//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.events {

    public class mTextEvent extends mEvent {

        public static const ENTER:String = "m_text_enter";
        public static const SELECT:String = "m_text_select";

        public var text:String;

        public function mTextEvent(type:String, text:String=null, bubbles:Boolean=false, cancelable:Boolean=false){
            super(type, bubbles, cancelable);
            this.text = text;
        }
    }
}//package msc.events 
