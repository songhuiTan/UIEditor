//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.controls {
    import flash.display.*;
    import flash.events.*;

    public class mSimpleSlider extends Sprite {

        private var _w:Number;
        private var _h:Number;
        private var _totalVal:Number;
        private var _block:SimpleButton;
        private var _value:Number;
        private var inited:Boolean;
        private var _pMouseY:Number;

        public function mSimpleSlider(w:Number=15, h:Number=260, val:Number=0, totalVal:Number=100){
            super();
            this._w = w;
            this._h = h;
            this._value = ((((val < 0)) ? 0 : val > totalVal)) ? totalVal : val;
            this._totalVal = totalVal;
            this._block = new SimpleButton(this.buildBlockShape(this._w, (this._h / 3), 0x4D4D4D), this.buildBlockShape(this._w, (this._h / 3), 0xFFFFFF), this.buildBlockShape(this._w, (this._h / 3), 0xFFFFFF), this.buildBlockShape(this._w, (this._h / 3), 0x4D4D4D));
            this._block.y = ((this._value / this._totalVal) * (this._h - this._block.height));
            addChild(this._block);
            this.relayout();
            addEventListener(Event.ADDED_TO_STAGE, this.onAdd);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemove);
        }
        public function set value(val:Number):void{
            this._value = val;
            this._block.y = ((this._value / this._totalVal) * (this._h - this._block.height));
        }
        public function get value():Number{
            return (this._value);
        }
        private function onAdd(evt:Event):void{
            if (this.inited){
                return;
            };
            this.inited = true;
            this._block.addEventListener(MouseEvent.MOUSE_DOWN, this.onDownBlock);
            this.stage.addEventListener(MouseEvent.MOUSE_UP, this.onUpBlock);
        }
        private function onRemove(evt:Event):void{
            this.inited = false;
            this._block.removeEventListener(MouseEvent.MOUSE_DOWN, this.onDownBlock);
            this.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onUpBlock);
            this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onDrag);
        }
        public function resize(w:Number, h:Number):void{
            this._w = w;
            this._h = h;
            this.relayout();
            this._block.y = ((this._value / this._totalVal) * (this._h - this._block.height));
        }
        public function relayout():void{
            graphics.clear();
            graphics.beginFill(0x232323);
            graphics.drawRoundRect(0, 0, this._w, this._h, 5, 5);
            graphics.endFill();
            this._block.upState = this.buildBlockShape(this._w, (this._h / 3), 0x4D4D4D);
            this._block.downState = this.buildBlockShape(this._w, (this._h / 3), 0xFFFFFF);
            this._block.overState = this.buildBlockShape(this._w, (this._h / 3), 0xFFFFFF);
            this._block.hitTestState = this.buildBlockShape(this._w, (this._h / 3), 0x4D4D4D);
        }
        private function onDownBlock(evt:MouseEvent):void{
            this._pMouseY = this._block.mouseY;
            this.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onDrag);
        }
        private function onUpBlock(evt:MouseEvent):void{
            this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onDrag);
        }
        private function onDrag(evt:MouseEvent):void{
            var ty:Number = (this.mouseY - this._pMouseY);
            if (ty < 0){
                ty = 0;
            };
            if (ty > (this._h - this._block.height)){
                ty = (this._h - this._block.height);
            };
            this._block.y = ty;
            var t:Number = ((this._block.y * this._totalVal) / (this._h - this._block.height));
            if (this._value != t){
                this._value = t;
                this.dispatchEvent(new Event(Event.CHANGE));
            };
        }
        private function buildBlockShape(w:Number, h:Number, color:uint):Shape{
            var sp:Shape = new Shape();
            sp.graphics.beginFill(color);
            sp.graphics.drawRoundRect(0, 0, w, h, 5, 5);
            sp.graphics.endFill();
            return (sp);
        }
        public function dispose():void{
        }
        override public function dispatchEvent(evt:Event):Boolean{
            if (((hasEventListener(evt.type)) || (evt.bubbles))){
                return (super.dispatchEvent(evt));
            };
            return (false);
        }

    }
}//package msc.controls 
