//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.controls.text {
    import flash.text.*;
    import flash.events.*;
    import tInspector.msc.input.*;
    import tInspector.msc.events.*;
    import tInspector.msc.display.*;

    public class mTextInput extends mSprite {

        protected var _tf:mTextField;

        public function mTextInput(){
            super();
            _w = 200;
            _h = 18;
        }
        public function set text(value:String):void{
            this._tf.text = value;
        }
        public function get text():String{
            return (this._tf.text);
        }
        public function get textField():TextField{
            return (this._tf);
        }
        public function setTextFormat(format:TextFormat, beginIndex:int=-1, endIndex:int=-1):void{
            this._tf.setTextFormat(format, beginIndex, endIndex);
        }
        public function set defaultTextFormat(format:TextFormat):void{
            this._tf.defaultTextFormat = format;
        }
        override protected function init():void{
            super.init();
            this._tf = new mTextField();
            this._tf.text = "";
            this._tf.type = TextFieldType.INPUT;
            this._tf.border = true;
            this._tf.borderColor = 0;
            this._tf.height = _h;
            this._tf.width = _w;
            this._tf.multiline = false;
            this.addChild(this._tf);
            this._tf.addEventListener(FocusEvent.FOCUS_IN, this.onFocusIn);
            this._tf.addEventListener(FocusEvent.FOCUS_OUT, this.onFocusOut);
        }
        override public function relayout():void{
            this._tf.width = _w;
            this._tf.height = _h;
        }
        override protected function destroy():void{
            this._tf.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            this._tf.removeEventListener(FocusEvent.FOCUS_IN, this.onFocusIn);
            this._tf.removeEventListener(FocusEvent.FOCUS_OUT, this.onFocusOut);
            this._tf = null;
            super.destroy();
        }
        protected function onKeyUp(evt:KeyboardEvent):void{
            if (evt.keyCode == KeyCode.ENTER){
                dispatchEvent(new mTextEvent(mTextEvent.ENTER, this._tf.text, true, true));
            };
        }
        private function onFocusIn(evt:FocusEvent):void{
            this._tf.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        }
        private function onFocusOut(evt:FocusEvent):void{
            this._tf.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
        }
        public function clear():void{
            this._tf.text = "";
            this._tf.dispatchEvent(new Event(Event.CHANGE));
        }

    }
}//package msc.controls.text 
