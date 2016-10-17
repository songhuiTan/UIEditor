//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview.accessors {
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.events.*;

    public class ObjectPropertyEditor extends PropertyEditor {

        protected var inspectBtn:InspectorButton;

        public function ObjectPropertyEditor(){
            super();
            this.inspectBtn = new InspectorButton();
            this.inspectBtn.upState = (this.inspectBtn.overState = (this.inspectBtn.downState = (this.inspectBtn.hitTestState = new Bitmap(InspectorSymbolIcon.getIcon(InspectorSymbolIcon.INSPECT)))));
            this.inspectBtn.tip = InspectorLanguageManager.getStr("InspectInfo");
            this.inspectBtn.visible = false;
            this.inspectBtn.addEventListener(MouseEvent.CLICK, this.onClickInspect);
            addChild(this.inspectBtn);
            this.addEventListener(MouseEvent.ROLL_OVER, this.onMouseRoll);
            this.addEventListener(MouseEvent.ROLL_OUT, this.onMouseRoll);
        }
        private function onMouseRoll(evt:MouseEvent):void{
            if (evt.type == MouseEvent.ROLL_OUT){
                this.inspectBtn.visible = false;
            } else {
                if (evt.type == MouseEvent.ROLL_OVER){
                    this.inspectBtn.visible = true;
                };
            };
        }
        private function onClickInspect(evt:MouseEvent):void{
            this.dispatchEvent(new PropertyEvent(PropertyEvent.INSPECT, true, true));
        }
        override public function relayOut():void{
            this.graphics.clear();
            this.graphics.lineStyle(2, 0x333333);
            this.graphics.drawRoundRect(0, 0, _width, _height, 5, 5);
            value_tf.x = 2;
            value_tf.width = (_width - 4);
            value_tf.height = (_height - 2);
            this.inspectBtn.x = -10;
            this.inspectBtn.y = ((_height / 2) - (this.inspectBtn.height / 2));
            if (autoSize){
                if ((value_tf.textWidth + 4) > value_tf.width){
                    _width = (value_tf.textWidth + 10);
                    this.relayOut();
                };
            };
        }
        override protected function onFocusIn(evt:FocusEvent):void{
            this.value_tf.textColor = 0xFFFFFF;
            this.graphics.clear();
            this.graphics.lineStyle(4, 0x222222);
            this.graphics.beginFill(6716929);
            this.graphics.drawRoundRect(0, 0, _width, _height, 5, 5);
            this.graphics.endFill();
        }
        override protected function onFocusOut(evt:FocusEvent):void{
            this.value_tf.textColor = 0xFFFFFF;
            this.graphics.clear();
            this.graphics.lineStyle(2, 0x333333);
            this.graphics.drawRoundRect(0, 0, _width, _height, 5, 5);
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview.accessors 
