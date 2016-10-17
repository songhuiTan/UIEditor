//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.keyboard {
    import flash.events.*;
    import flash.display.*;

    public class ShortcutManager extends EventDispatcher {

        protected var _stage:Stage;
        protected var _downKeys:Array;
        protected var _typeKeys:Array;
        protected var _shortcuts:Array;
        private var running:Boolean;

        public function ShortcutManager():void{
            super();
            this._downKeys = new Array(0xFF);
            this._shortcuts = [];
            this._typeKeys = [];
        }
        public function setStage(stage:Stage):void{
            if (this._stage != stage){
                if (this._stage == null){
                    this._stage = stage;
                    this._stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
                    this._stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
                };
            };
        }
        public function start():void{
            if (!(this.running)){
                this.running = true;
                this._stage.addEventListener(Event.ENTER_FRAME, this.checkShortcutTyped);
            };
        }
        public function stop():void{
            this.running = false;
            this._stage.removeEventListener(Event.ENTER_FRAME, this.checkShortcutTyped);
        }
        private function onKeyDown(evt:KeyboardEvent):void{
            if (!(this._downKeys[evt.keyCode])){
                this._downKeys[evt.keyCode] = true;
                this._typeKeys.push(evt.keyCode);
            };
        }
        private function onKeyUp(evt:KeyboardEvent):void{
            this._downKeys[evt.keyCode] = false;
            var t:int = this._typeKeys.indexOf(evt.keyCode);
            if (t > -1){
                this._typeKeys.splice(t, 1);
            };
        }
        protected function checkShortcutTyped(evt:Event=null):void{
            var shortcut:Shortcut = this.checkShortcutExist(this._typeKeys);
            if (shortcut){
                this.dispatchEvent(new ShortcutEvent(shortcut, ShortcutEvent.DOWN));
            };
        }
        public function checkShortcutExist(keys:Array):Shortcut{
            var shortcut:Shortcut;
            var i:int = this._shortcuts.length;
            while (i-- > 0) {
                shortcut = this._shortcuts[i];
                if (shortcut.equalKeys(keys)){
                    return (shortcut);
                };
            };
            return (null);
        }
        public function registerShortcut(st:Shortcut):void{
            if (this._shortcuts.indexOf(st) >= 0){
                return;
            };
            this._shortcuts.push(st);
        }
        public function unregisterShorcut(st:Shortcut):void{
            var t:int = this._shortcuts.indexOf(st);
            if (t > -1){
                this._shortcuts.splice(t, 1);
            };
        }
        public function unregisterKeys(keys:Array):void{
            var shortcut:Shortcut = this.checkShortcutExist(keys);
            if (shortcut){
                this.unregisterShorcut(shortcut);
            };
        }

    }
}//package cn.itamt.keyboard 
