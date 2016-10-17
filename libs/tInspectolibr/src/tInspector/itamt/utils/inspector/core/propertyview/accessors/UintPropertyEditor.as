//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview.accessors {
    import tInspector.itamt.utils.inspector.events.*;
    import flash.events.*;

    public class UintPropertyEditor extends NumberPropertyEditor {

        private var value:uint;

        public function UintPropertyEditor(){
            super();
            this.value_tf.restrict = "A-Fa-f0-9#";
        }
        override protected function onPressEnter(evt:KeyboardEvent):void{
            var color:String;
            if (evt.keyCode == 13){
                color = value_tf.text;
                if (color.indexOf("#") > -1){
                    color = color.replace(/^\s+|\s+$/g, "");
                    color = color.replace(/#/g, "");
                };
                this.value = parseInt(color, 16);
                dispatchEvent(new PropertyEvent(PropertyEvent.UPDATE, true, true));
            };
        }
        override public function setValue(value):void{
            super.setValue(value);
        }
        protected function colorToString(color:uint):String{
            var colorText:String = color.toString(16);
            while (colorText.length < 6) {
                colorText = ("0" + colorText);
            };
            return (colorText);
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview.accessors 
