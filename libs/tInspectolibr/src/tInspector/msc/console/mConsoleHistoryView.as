//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.console {
    import tInspector.msc.controls.*;
    import flash.events.*;
    import tInspector.msc.controls.text.*;

    public class mConsoleHistoryView extends mTextArea {

        private var _scroller:mSimpleSlider;

        public function mConsoleHistoryView(w:Number=200, h:Number=100, text:String=null){
            super(w, h, text);
            this._scroller = new mSimpleSlider(10, _h, 0, 1);
        }
        override protected function init():void{
            super.init();
            this._scroller.alpha = 0.5;
            addChild(this._scroller);
            this._scroller.addEventListener(Event.CHANGE, this.onSliderScroll);
            _tf.addEventListener(Event.SCROLL, this.onTextScroll);
        }
        override public function relayout():void{
            super.relayout();
            this._scroller.resize(10, _h);
            this._scroller.x = (_w - this._scroller.width);
        }
        private function onSliderScroll(evt:Event):void{
            _tf.scrollV = (this._scroller.value * _tf.maxScrollV);
        }
        private function onTextScroll(evt:Event):void{
            this._scroller.value = (_tf.scrollV / _tf.maxScrollV);
        }

    }
}//package msc.console 
