//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview.accessors {
    import flash.events.*;
    import tInspector.itamt.utils.inspector.events.*;
    import flash.text.*;

    public class StringPropertyEditor extends PropertyEditor {

        public function StringPropertyEditor(){
            super();
        }
        override protected function onFocusIn(evt:FocusEvent):void{
            super.onFocusIn(evt);
            this.addEventListener(KeyboardEvent.KEY_UP, this.onPressEnter);
        }
        override protected function onFocusOut(evt:FocusEvent):void{
            super.onFocusOut(evt);
            this.removeEventListener(KeyboardEvent.KEY_UP, this.onPressEnter);
        }
        protected function onPressEnter(evt:KeyboardEvent):void{
            if (evt.keyCode == 13){
                dispatchEvent(new PropertyEvent(PropertyEvent.UPDATE, true, true));
            };
        }
        override protected function onReadWrite():void{
            super.onReadWrite();
            value_tf.type = TextFieldType.INPUT;
        }
        override public function setValue(value):void{
            super.setValue(value);
            if (value == null){
                value_tf.textColor = 0xFF0000;
                value_tf.text = "null";
            } else {
                value_tf.text = value;
            };
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview.accessors 
