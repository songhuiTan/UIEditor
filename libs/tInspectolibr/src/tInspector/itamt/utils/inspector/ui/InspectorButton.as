//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import flash.utils.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.events.*;
    import flash.display.*;

    public class InspectorButton extends SimpleButton {

        protected var _active:Boolean = false;
        private var _timer:Timer;
        protected var _tip:String = "tip";

        public function InspectorButton():void{
            super();
            this.downState = this.buildDownState();
            this.upState = this.buildUpState();
            this.overState = this.buildOverState();
            this.hitTestState = this.buildHitState();
            this._timer = new Timer(1000);
            addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            addEventListener(MouseEvent.MOUSE_DOWN, this.removeTip);
            addEventListener(MouseEvent.CLICK, this.removeTip);
            this.tabEnabled = false;
        }
        public function get tip():String{
            return (this._tip);
        }
        public function set tip(value:String):void{
            this._tip = value;
        }
        public function set active(value:Boolean):void{
            this._active = value;
            if (!(this.active)){
                this.downState = this.buildDownState();
                this.upState = this.buildUpState();
                this.overState = this.buildOverState();
                this.hitTestState = this.buildHitState();
            } else {
                this.downState = this.buildUpState();
                this.upState = this.buildOverState();
                this.overState = this.buildDownState();
                this.hitTestState = this.buildHitState();
            };
        }
        public function get active():Boolean{
            return (this._active);
        }
        private function onRollOver(evt:MouseEvent):void{
            this._timer.addEventListener(TimerEvent.TIMER, this.onTimerShowTip);
            addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            dispatchEvent(new TipEvent(TipEvent.EVT_SHOW_TIP, this.tip));
        }
        private function onTimerShowTip(evt:TimerEvent):void{
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimerShowTip);
            this._timer.addEventListener(TimerEvent.TIMER, this.onTimerRemoveTip);
            dispatchEvent(new TipEvent(TipEvent.EVT_SHOW_TIP, this.tip));
        }
        private function onTimerRemoveTip(evt:TimerEvent=null):void{
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimerRemoveTip);
            this._timer.removeEventListener(TimerEvent.TIMER, this.onTimerShowTip);
            this._timer.reset();
            this._timer.stop();
            dispatchEvent(new TipEvent(TipEvent.EVT_REMOVE_TIP, this.tip));
        }
        private function onRollOut(evt:MouseEvent):void{
            removeEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            this.onTimerRemoveTip();
        }
        private function removeTip(evt:MouseEvent):void{
            this.onTimerRemoveTip();
        }
        override public function set enabled(val:Boolean):void{
            if (!(val)){
                this.downState = (this.upState = (this.overState = (this.hitTestState = this.buildUnenabledState())));
            } else {
                this.downState = this.buildDownState();
                this.upState = this.buildUpState();
                this.overState = this.buildOverState();
                this.hitTestState = this.buildHitState();
            };
            super.enabled = val;
        }
        protected function buildDownState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
            };
            return (sp);
        }
        protected function buildUpState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
            };
            return (sp);
        }
        protected function buildOverState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
            };
            return (sp);
        }
        protected function buildHitState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
            };
            return (sp);
        }
        protected function buildUnenabledState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
            };
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.ui 
