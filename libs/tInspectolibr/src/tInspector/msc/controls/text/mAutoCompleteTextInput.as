//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.controls.text {
    import flash.events.*;
    import tInspector.msc.input.*;
    import tInspector.msc.events.*;
    import flash.text.*;

    public class mAutoCompleteTextInput extends mTextInput {

        protected var _dictionary:String = "";
        protected var _matchArr:Array;
        protected var _matchText:mTextField;
        protected var _curWordStr:String;
        protected var _curSelectMatchIndex:int;
        public var clearWhenEnter:Boolean = false;

        public function mAutoCompleteTextInput(){
            super();
        }
        override protected function init():void{
            super.init();
            this._matchText = new mTextField();
            this._matchText.selectable = (this._matchText.mouseEnabled = (this._matchText.mouseWheelEnabled = false));
            this._matchText.textColor = 0x999999;
            this._matchText.autoSize = "left";
            this._tf.addEventListener(Event.CHANGE, this.onTextChange);
            this._tf.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.onKeyFocusChange);
        }
        override protected function destroy():void{
            this._tf.removeEventListener(Event.CHANGE, this.onTextChange);
            this._tf.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, this.onKeyFocusChange);
            this._matchArr = null;
            this._matchText = null;
            super.destroy();
        }
        override public function relayout():void{
            super.relayout();
            if (this._matchText){
                this._matchText.y = (-(this._matchText.height) - 2);
            };
        }
        override protected function onKeyUp(evt:KeyboardEvent):void{
            var str:String;
            if (evt.keyCode == KeyCode.ENTER){
                if (this._curSelectMatchIndex != -1){
                    str = this._tf.text.slice(0, (this._tf.text.lastIndexOf(" ") + 1));
                    this._tf.text = (str + this._matchArr[this._curSelectMatchIndex]);
                    this._tf.setSelection(this._tf.text.length, this._tf.text.length);
                    this._tf.dispatchEvent(new Event(Event.CHANGE));
                } else {
                    dispatchEvent(new mTextEvent(mTextEvent.ENTER, _tf.text, true, true));
                    if (this.clearWhenEnter){
                        clear();
                    };
                };
            };
        }
        protected function onTextChange(evt:Event):void{
            var t:int = this.text.lastIndexOf(" ");
            this._curSelectMatchIndex = -1;
            this._curWordStr = ((t >= 0)) ? this.text.slice((t + 1)) : this.text;
            if (!(this._curWordStr.length)){
                if (this._matchText.parent){
                    this._matchText.parent.removeChild(this._matchText);
                };
                return;
            };
            this._matchArr = this.getMatchStrArray(this._curWordStr);
            if (this._matchArr == null){
                if (this._matchText.parent){
                    this._matchText.parent.removeChild(this._matchText);
                };
            } else {
                this.setMatchText(this._matchArr);
                addChildAt(this._matchText, 0);
                this.relayout();
            };
        }
        protected function setMatchText(matchArr:Array=null):void{
            this._matchText.text = "";
            if (matchArr){
                this._matchText.text = matchArr.toString();
            };
        }
        protected function onKeyFocusChange(evt:FocusEvent):void{
            if (evt.keyCode == KeyCode.TAB){
                if (((this._matchArr) && (this._matchArr.length))){
                    this._curSelectMatchIndex = (((this._curSelectMatchIndex + 1))>=this._matchArr.length) ? 0 : (this._curSelectMatchIndex + 1);
                    this.selectMatchWord(this._curSelectMatchIndex);
                    evt.preventDefault();
                };
            };
        }
        protected function selectMatchWord(index:int):void{
            var word:String = this._matchArr[index];
            var beginIndex:int = this._matchText.text.search(new RegExp((("\\b" + word) + "\\b")));
            this._matchText.setTextFormat(new TextFormat(null, null, null, false, null, false));
            this._matchText.setTextFormat(new TextFormat(null, null, null, true, null, true), beginIndex, (beginIndex + word.length));
            dispatchEvent(new mTextEvent(mTextEvent.SELECT, word));
        }
        protected function getMatchStrArray(str:String):Array{
            var reg:RegExp = new RegExp((("\\b" + str) + "[^\\s]*"), "gi");
            return (this._dictionary.match(reg));
        }
        public function addToDictionary(value:String):void{
            var reg:RegExp = new RegExp((("\\b" + value) + "\\b"), "");
            if (reg.test(this._dictionary)){
                return;
            };
            this._dictionary = (this._dictionary + (this._dictionary.length) ? (" " + value) : value);
        }

    }
}//package msc.controls.text 
