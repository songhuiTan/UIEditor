//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview.accessors {
    import flash.system.*;
    import flash.events.*;

    public class NumberPropertyEditor extends StringPropertyEditor {

        public function NumberPropertyEditor(){
            super();
            this.value_tf.restrict = ".0-9\\-";
        }
        override protected function onFocusIn(evt:FocusEvent):void{
            super.onFocusIn(evt);
            if (Capabilities.hasIME){
                IME.enabled = false;
            };
        }
        override protected function onFocusOut(evt:FocusEvent):void{
            super.onFocusOut(evt);
            if (Capabilities.hasIME){
                IME.enabled = true;
            };
        }
        override public function getValue(){
            return (Number(value_tf.text));
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview.accessors 
