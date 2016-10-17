//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.display {
    import flash.events.*;
    import flash.display.*;

    public class mSprite extends Sprite {

        protected var _inited:Boolean;
        protected var _w:Number;
        protected var _h:Number;

        public function mSprite(){
            super();
            addEventListener(Event.ADDED_TO_STAGE, this.onAdded, false, 0, true);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved, false, 0, true);
        }
        private function onAdded(evt:Event):void{
            if (this._inited){
                return;
            };
            this.init();
            this.relayout();
        }
        private function onRemoved(evt:Event):void{
            this.destroy();
        }
        public function setPos(x:Number, y:Number):void{
            this.x = x;
            this.y = y;
        }
        public function relayout():void{
        }
        public function setSize(w:Number=NaN, h:Number=NaN):void{
            if ((((this._w == w)) && ((this._h == h)))){
                return;
            };
            this._w = (isNaN(w)) ? this._w : w;
            this._h = (isNaN(h)) ? this._h : h;
            this.relayout();
        }
        protected function init():void{
            this._inited = true;
        }
        protected function destroy():void{
            this._inited = false;
        }

    }
}//package msc.display 
