//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.events.*;
    import flash.display.*;

    public class InspectorViewResizeButton extends InspectorButton {

        private var _normalMode:Boolean = true;

        public function InspectorViewResizeButton(){
            super();
            _tip = InspectorLanguageManager.getStr("MinimizePanel");
            this.addEventListener(MouseEvent.CLICK, this.onToggleMode, false, 0, true);
            this.updateStates();
        }
        override protected function buildOverState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0xFF0000);
                graphics.moveTo(10, 13);
                graphics.lineTo(16, 13);
            };
            return (sp);
        }
        override protected function buildDownState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0xFFFFFF);
                graphics.moveTo(10, 13);
                graphics.lineTo(16, 13);
            };
            return (sp);
        }
        override protected function buildUpState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 0);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0xFF0000);
                graphics.moveTo(10, 13);
                graphics.lineTo(16, 13);
            };
            return (sp);
        }
        protected function buildOverState2():Shape{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0xFF0000);
                graphics.drawRect(8, 8, 7, 7);
            };
            return (sp);
        }
        protected function buildDownState2():Shape{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0xFFFFFF);
                graphics.drawRect(8, 8, 7, 7);
            };
            return (sp);
        }
        protected function buildUpState2():Shape{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 0);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0xFF0000);
                graphics.drawRect(8, 8, 7, 7);
            };
            return (sp);
        }
        public function get normalMode():Boolean{
            return (this._normalMode);
        }
        private function onToggleMode(evt:MouseEvent):void{
            this._normalMode = !(this._normalMode);
            this.updateStates();
        }
        private function updateStates():void{
            if (this._normalMode){
                this.downState = this.buildDownState();
                this.upState = this.buildUpState();
                this.overState = this.buildOverState();
                this.hitTestState = buildHitState();
                _tip = InspectorLanguageManager.getStr("MinimizePanel");
            } else {
                this.downState = this.buildDownState2();
                this.upState = this.buildUpState2();
                this.overState = this.buildOverState2();
                this.hitTestState = buildHitState();
                _tip = InspectorLanguageManager.getStr("RestorePanel");
            };
        }
        override public function set enabled(val:Boolean):void{
            if (!(val)){
                this.downState = (this.upState = (this.overState = (this.hitTestState = buildUnenabledState())));
            } else {
                this.updateStates();
            };
            super.enabled = val;
        }

    }
}//package cn.itamt.utils.inspector.ui 
