//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.controls.text {
    import flash.text.*;
    import tInspector.msc.display.*;

    public class mTextArea extends mSprite {

        protected var _tf:mTextField;
        protected var _defaultTextFormat:TextFormat;

        public function mTextArea(w:Number=200, h:Number=100, text:String=null){
            super();
            _w = 200;
            _h = 100;
            this._tf = new mTextField();
            this._tf.multiline = true;
            this._tf.wordWrap = true;
            this._tf.border = true;
            this._tf.borderColor = 0;
        }
        public function set text(value:String):void{
            this._tf.text = value;
        }
        public function get text():String{
            return (this._tf.text);
        }
        public function get htmlText():String{
            return (this._tf.htmlText);
        }
        public function set htmlText(value:String):void{
            this._tf.htmlText = value;
        }
        public function setTextFormat(format:TextFormat, beginIndex:int=-1, endIndex:int=-1):void{
            this._tf.setTextFormat(format, beginIndex, endIndex);
        }
        public function set defaultTextFormat(format:TextFormat):void{
            this._defaultTextFormat = format;
            this._tf.defaultTextFormat = this._defaultTextFormat;
        }
        override protected function init():void{
            super.init();
            addChild(this._tf);
        }
        override public function relayout():void{
            this._tf.width = _w;
            this._tf.height = _h;
        }
        override protected function destroy():void{
            this._tf = null;
            super.destroy();
        }
        public function appendText(text:String):void{
            this._tf.appendText(text);
        }
        public function appendHtmlText(text:String):void{
            if (this._tf.htmlText == null){
                this._tf.htmlText = "";
            };
            this._tf.htmlText = (this._tf.htmlText + text);
        }
        public function scrollVBottom():void{
            this._tf.scrollV = this._tf.maxScrollV;
        }
        public function fixDefaultTextFormat():void{
            var tfm:TextFormat = this._defaultTextFormat;
            if (tfm == null){
                return;
            };
            this._tf.defaultTextFormat = this._defaultTextFormat;
        }
        public function clear():void{
            this._tf.text = "";
        }

    }
}//package msc.controls.text 
