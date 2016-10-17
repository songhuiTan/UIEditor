//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview.accessors {
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.events.*;
    import flash.text.*;

    public class PropertyEditor extends BasePropertyEditor {

        protected var value_tf:TextField;

        public function PropertyEditor(){
            super();
            this.value_tf = InspectorTextField.create("", 0xFFFFFF, 12);
            this.value_tf.multiline = false;
            this.value_tf.mouseWheelEnabled = false;
            this.value_tf.height = (_height - 2);
            addChild(this.value_tf);
            this.value_tf.addEventListener(FocusEvent.FOCUS_IN, this.onFocusIn);
            this.value_tf.addEventListener(FocusEvent.FOCUS_OUT, this.onFocusOut);
        }
        protected function onFocusIn(evt:FocusEvent):void{
            this.value_tf.textColor = 0xFFFFFF;
            this.graphics.clear();
            this.graphics.lineStyle(4, 0x222222);
            this.graphics.beginFill(6716929);
            this.graphics.drawRoundRect(0, 0, _width, _height, 5, 5);
            this.graphics.endFill();
        }
        protected function onFocusOut(evt:FocusEvent):void{
            this.value_tf.textColor = 0xFFFFFF;
            this.graphics.clear();
            this.graphics.lineStyle(2, 0x333333);
            this.graphics.drawRoundRect(0, 0, _width, _height, 5, 5);
        }
        override public function relayOut():void{
            super.relayOut();
            this.value_tf.x = 2;
            this.value_tf.width = (_width - 4);
            this.value_tf.height = (_height - 2);
            if (autoSize){
                if ((this.value_tf.textWidth + 4) > this.value_tf.width){
                    _width = (this.value_tf.textWidth + 10);
                    this.relayOut();
                };
            };
        }
        override protected function onWriteOnly():void{
            super.onWriteOnly();
            this.value_tf.textColor = 0xFF0000;
            this.value_tf.text = "write only";
        }
        override protected function onReadOnly():void{
            super.onReadOnly();
            this.value_tf.textColor = 0x999999;
            this.value_tf.removeEventListener(FocusEvent.FOCUS_IN, this.onFocusIn);
            this.value_tf.removeEventListener(FocusEvent.FOCUS_OUT, this.onFocusOut);
        }
        override public function setValue(value):void{
            super.setValue(value);
            if ((((value == null)) || ((value == undefined)))){
                this.value_tf.textColor = 0xFF0000;
                this.value_tf.text = String(value);
                return;
            };
            this.value_tf.text = value.toString();
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview.accessors 
