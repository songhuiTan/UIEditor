//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview.accessors {
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.events.*;
    import flash.display.*;

    public class EnumValueItemRenderer extends Sprite {

        private var valueBtn:ToggleBooleanButton;
        public var editor:BasePropertyEditor;
        protected var _width:Number;
        protected var _height:Number;

        public function EnumValueItemRenderer(editor:BasePropertyEditor):void{
            super();
            this.editor = editor;
            this.addChild(editor);
            this.mouseChildren = false;
            this.buttonMode = true;
            this.valueBtn = new ToggleBooleanButton();
            this.valueBtn.mouseEnabled = false;
            addChild(this.valueBtn);
            this._width = ((this.editor.width + this.valueBtn.width) + 5);
            this._height = Math.max(this.editor.height, (this.valueBtn.height + 3));
            this.addEventListener(MouseEvent.ROLL_OVER, this.onMouseAct);
            this.addEventListener(MouseEvent.ROLL_OUT, this.onMouseAct);
            this.addEventListener(MouseEvent.CLICK, this.onMouseAct);
            this.relayout();
        }
        protected function drawBg(bgColor:uint=0x282828):void{
            this.graphics.clear();
            this.graphics.beginFill(bgColor);
            this.graphics.drawRoundRect(0, 0, this._width, this._height, 5, 5);
            this.graphics.endFill();
        }
        protected function onMouseAct(evt:MouseEvent):void{
            if (evt.type == MouseEvent.ROLL_OUT){
                this.drawBg(0x282828);
            } else {
                if (evt.type == MouseEvent.ROLL_OVER){
                    this.drawBg(0x444444);
                } else {
                    if (evt.type == MouseEvent.CLICK){
                        this.valueBtn.value = !(this.valueBtn.value);
                        this.dispatchEvent(new Event((this.valueBtn.value) ? Event.SELECT : Event.CANCEL));
                    };
                };
            };
        }
        protected function relayout():void{
            this.valueBtn.x = 5;
            this.valueBtn.y = 3;
            this.editor.x = (this.valueBtn.x + this.valueBtn.width);
            this.drawBg();
        }
        public function set selected(value:Boolean):void{
            this.valueBtn.value = value;
        }
        public function get selected():Boolean{
            return (this.valueBtn.value);
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview.accessors 
