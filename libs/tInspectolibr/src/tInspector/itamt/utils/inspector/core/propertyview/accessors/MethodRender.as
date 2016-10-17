//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview.accessors {
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.events.*;
    import flash.text.*;
    import flash.display.*;

    public class MethodRender extends Sprite {

        private var name_tf:TextField;
        private var valueEditor:BasePropertyEditor;
        private var _width:Number;
        private var _height:Number;
        private var _target;
        private var _xml:XML;

        public function MethodRender(w:Number=180, h:Number=20):void{
            super();
            this._width = w;
            this._height = h;
            this.name_tf = InspectorTextField.create("", 0xCCCCCC, 12);
            this.name_tf.height = (this._height - 2);
            this.name_tf.selectable = (this.name_tf.mouseEnabled = (this.name_tf.mouseWheelEnabled = false));
            addChild(this.name_tf);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
        }
        public function get xml():XML{
            return (this._xml);
        }
        public function get propName():String{
            return (this.name_tf.text);
        }
        private function onAdded(evt:Event):void{
            this.relayout();
        }
        public function relayout():void{
            this.name_tf.width = (this.name_tf.textWidth + 4);
            if (this.name_tf.width < 48){
                this.name_tf.width = 48;
            };
            this.name_tf.x = 12;
            if (this.valueEditor){
                this.valueEditor.setSize(((this._width - this.name_tf.width) - 15), this._height);
                this.valueEditor.x = ((this.name_tf.x + this.name_tf.width) + 8);
            };
            this.drawBg();
        }
        private function drawBg():void{
            this.graphics.clear();
            this.graphics.beginFill(0x282828);
            this.graphics.drawRoundRect(0, 0, (this.name_tf.width + 16), this._height, 5, 5);
            this.graphics.endFill();
        }
        public function setXML(target, methodXML:XML):void{
            this._target = target;
            this._xml = methodXML;
            this.name_tf.text = methodXML.@name;
            if (this.valueEditor == null){
                this.valueEditor = new MethodEditor();
                addChildAt(this.valueEditor, 0);
            };
            this.valueEditor.setValue(target);
            this.relayout();
        }
        public function update():void{
            this.valueEditor.setValue(this._target);
        }
        public function resize():void{
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview.accessors 
