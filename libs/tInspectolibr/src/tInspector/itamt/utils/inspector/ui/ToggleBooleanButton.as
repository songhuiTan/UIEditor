//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import flash.events.*;
    import flash.display.*;

    public class ToggleBooleanButton extends SimpleButton {

        private var _value:Boolean;

        public function ToggleBooleanButton(value:Boolean=true){
            super();
            this.tabEnabled = false;
            this._value = value;
            this.updateMode();
            addEventListener(MouseEvent.CLICK, this.onClick);
        }
        public function set value(v:Boolean):void{
            this._value = v;
            this.updateMode();
        }
        public function get value():Boolean{
            return (this._value);
        }
        private function updateMode():void{
            var sp:Shape = new Shape();
            if (this._value){
                sp.graphics.lineStyle(3, 0x282828);
                sp.graphics.beginFill(6716929);
                sp.graphics.drawCircle(7, 7, 7);
                sp.graphics.endFill();
            } else {
                sp.graphics.lineStyle(3, 0x282828);
                sp.graphics.beginFill(0x222222);
                sp.graphics.drawCircle(7, 7, 7);
                sp.graphics.endFill();
            };
            this.downState = (this.overState = (this.upState = (this.hitTestState = sp)));
        }
        private function onClick(evt:MouseEvent):void{
            this._value = !(this._value);
            this.updateMode();
            dispatchEvent(new Event(Event.CHANGE));
        }

    }
}//package cn.itamt.utils.inspector.ui 
