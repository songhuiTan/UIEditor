//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import flash.events.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.lang.*;

    public class InspectorViewFullButton extends InspectorButton {

        protected var _normalMode:Boolean = true;

        public function InspectorViewFullButton(){
            super();
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
                graphics.lineStyle(3, 0x99CC00);
                graphics.moveTo(6, 5);
                graphics.lineTo(15, 5);
                graphics.moveTo(6, 10);
                graphics.lineTo(15, 10);
                graphics.moveTo(6, 15);
                graphics.lineTo(15, 15);
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
                graphics.moveTo(6, 5);
                graphics.lineTo(15, 5);
                graphics.moveTo(6, 10);
                graphics.lineTo(15, 10);
                graphics.moveTo(6, 15);
                graphics.lineTo(15, 15);
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
                graphics.lineStyle(3, 0xFFFFFF);
                graphics.moveTo(6, 5);
                graphics.lineTo(15, 5);
                graphics.moveTo(6, 10);
                graphics.lineTo(15, 10);
                graphics.moveTo(6, 15);
                graphics.lineTo(15, 15);
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
                graphics.lineStyle(3, 0x99CC00);
                graphics.moveTo(6, 6);
                graphics.lineTo(15, 6);
                graphics.moveTo(6, 13);
                graphics.lineTo(15, 13);
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
                graphics.moveTo(6, 6);
                graphics.lineTo(15, 6);
                graphics.moveTo(6, 13);
                graphics.lineTo(15, 13);
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
                graphics.lineStyle(3, 0xFFFFFF);
                graphics.moveTo(6, 6);
                graphics.lineTo(15, 6);
                graphics.moveTo(6, 13);
                graphics.lineTo(15, 13);
            };
            return (sp);
        }
        public function get normalMode():Boolean{
            return (this._normalMode);
        }
        public function set normalMode(bool:Boolean):void{
            this._normalMode = bool;
            this.updateStates();
        }
        private function onToggleMode(evt:MouseEvent):void{
            this._normalMode = !(this._normalMode);
            this.updateStates();
        }
        protected function updateStates():void{
            if (this._normalMode){
                this.downState = this.buildDownState();
                this.upState = this.buildUpState();
                this.overState = this.buildOverState();
                this.hitTestState = buildHitState();
                _tip = InspectorLanguageManager.getStr("ViewFullProperties");
            } else {
                this.downState = this.buildDownState2();
                this.upState = this.buildUpState2();
                this.overState = this.buildOverState2();
                this.hitTestState = buildHitState();
                _tip = InspectorLanguageManager.getStr("ViewMarkedProperties");
            };
        }
        override public function set enabled(val:Boolean):void{
            super.enabled = val;
            if (!(val)){
                this.downState = (this.upState = (this.overState = (this.hitTestState = this.buildUnenabledState())));
            } else {
                this.updateStates();
            };
        }
        override protected function buildUnenabledState():DisplayObject{
            var sp:* = new Shape();
            if (this._normalMode){
                var _local2 = sp;
                with (_local2) {
                    graphics.beginFill(0, 0);
                    graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                    graphics.endFill();
                    graphics.lineStyle(3, 0);
                    graphics.moveTo(6, 5);
                    graphics.lineTo(15, 5);
                    graphics.moveTo(6, 10);
                    graphics.lineTo(15, 10);
                    graphics.moveTo(6, 15);
                    graphics.lineTo(15, 15);
                };
            } else {
                _local2 = sp;
                with (_local2) {
                    graphics.beginFill(0, 0);
                    graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                    graphics.endFill();
                    graphics.lineStyle(3, 0);
                    graphics.moveTo(6, 6);
                    graphics.lineTo(15, 6);
                    graphics.moveTo(6, 13);
                    graphics.lineTo(15, 13);
                };
            };
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.ui 
