//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.console {
    import flash.text.*;
    import tInspector.msc.events.*;
    import tInspector.msc.input.*;
    import flash.events.*;
    import tInspector.msc.controls.text.*;

    public class mCmdTextInput extends mAutoCompleteTextInput {

        private var _history:Array;
        private var _selectHistoryIndex:int = -1;

        override public function get height():Number{
            return (this._tf.height);
        }
        override protected function init():void{
            super.init();
            clearWhenEnter = true;
            this._matchText.textColor = 0xFFFFFF;
            this._matchText.multiline = true;
            this._matchText.border = true;
            this._matchText.borderColor = 0;
            this._matchText.background = true;
            this._matchText.backgroundColor = 0x666666;
            this._matchText.alpha = 0.5;
            var tfm:TextFormat = new TextFormat();
            tfm.font = "Verdana";
            tfm.leftMargin = (tfm.rightMargin = 3);
            this._matchText.defaultTextFormat = tfm;
            this.addEventListener(mTextEvent.ENTER, this.onEnterText);
        }
        override protected function destroy():void{
            this.removeEventListener(mTextEvent.ENTER, this.onEnterText);
            super.destroy();
        }
        override protected function setMatchText(matchArr:Array=null):void{
            var match:String;
            _matchText.text = "";
            if (matchArr){
                for each (match in matchArr) {
                    _matchText.appendText((match + "\n"));
                };
            };
            this.relayout();
        }
        override protected function onKeyUp(evt:KeyboardEvent):void{
            super.onKeyUp(evt);
            if (evt.keyCode == KeyCode.UP){
                if (((this._history) && (this._history.length))){
                    evt.preventDefault();
                    this.text = this._history[((this._selectHistoryIndex <= 0)) ? 0 : --this._selectHistoryIndex];
                    this._tf.setSelection(this.text.length, this.text.length);
                };
            } else {
                if (evt.keyCode == KeyCode.DOWN){
                    if (((this._history) && (this._history.length))){
                        evt.preventDefault();
                        this.text = this._history[((this._selectHistoryIndex >= (this._history.length - 1))) ? (this._history.length - 1) : ++this._selectHistoryIndex];
                        this._tf.setSelection(this.text.length, this.text.length);
                    };
                };
            };
        }
        private function onEnterText(evt:mTextEvent):void{
            if (evt.text == ""){
                return;
            };
            if (this._history == null){
                this._history = [];
            };
            var t:int = this._history.indexOf(evt.text);
            if (t >= 0){
                this._history.slice(t, 1);
            };
            this._history.push(evt.text);
            this._selectHistoryIndex = this._history.length;
        }

    }
}//package msc.console 
