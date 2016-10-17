//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import flash.display.*;
    import flash.text.*;
    import flash.filters.*;
    import tInspector.itamt.utils.inspector.lang.*;
    import tInspector.msc.events.*;
    import flash.geom.*;
    import tInspector.msc.console.*;

    public class InspectSearchBar extends mCmdTextInput {

        protected var icon:Shape;

        public function InspectSearchBar(){
            super();
            this.mouseEnabled = false;
        }
        override protected function init():void{
            super.init();
            this.icon = new Shape();
            this.drawIcon();
            addChild(this.icon);
            this.drawBg();
            clearWhenEnter = true;
            var tfm:TextFormat = new TextFormat();
            tfm.font = "Verdana";
            tfm.leftMargin = (tfm.rightMargin = 3);
            this._tf.textColor = 0xFFFFFF;
            this._tf.border = false;
            this._tf.defaultTextFormat = tfm;
            tfm.size = 10;
            this._matchText.border = false;
            this._matchText.textColor = 0x99CC00;
            this._matchText.background = true;
            this._matchText.backgroundColor = 0;
            this._matchText.alpha = 1;
            this._matchText.defaultTextFormat = tfm;
            this._matchText.filters = [new DropShadowFilter(0, 0, 0, 1, 8, 8)];
        }
        override protected function setMatchText(matchArr:Array=null):void{
            var match:String;
            var t:int;
            var tfm:TextFormat;
            _matchText.text = "";
            if (matchArr){
                for each (match in matchArr) {
                    _matchText.appendText((match + "\n"));
                };
                if (matchArr.length > 0){
                    t = _matchText.length;
                    _matchText.appendText(("\n" + InspectorLanguageManager.getStr("SearchBtnHelp")));
                    tfm = new TextFormat(null, null, 0xCCCCCC);
                    tfm.leading = 5;
                    _matchText.setTextFormat(tfm, t, _matchText.length);
                };
            };
            this.relayout();
        }
        override protected function selectMatchWord(index:int):void{
            var word:String = _matchArr[index];
            var beginIndex:int = _matchText.text.search(new RegExp((("\\b" + word) + "\\b")));
            _matchText.setTextFormat(new TextFormat(null, null, null, false, null, false));
            _matchText.setTextFormat(new TextFormat(null, null, null, false, null, true), beginIndex, (beginIndex + word.length));
            dispatchEvent(new mTextEvent(mTextEvent.SELECT, word));
        }
        override public function relayout():void{
            if (!(_inited)){
                return;
            };
            this.drawBg();
            this._tf.x = ((this.icon.x + this.icon.width) + 5);
            this._tf.height = _h;
            this._tf.width = (((_w - this.icon.width) - this.icon.x) - 5);
            if (this._matchText){
                this._matchText.y = ((this._tf.y - this._matchText.height) - 5);
            };
        }
        private function drawIcon():void{
            var _local2 = this.icon;
            with (_local2) {
                graphics.clear();
                graphics.lineStyle();
                graphics.beginFill(0x282828);
                graphics.moveTo(16, 0);
                graphics.curveTo(21, 0, 21, 5);
                graphics.lineTo(21, 16);
                graphics.curveTo(21, 21, 16, 21);
                graphics.lineTo(5, 21);
                graphics.curveTo(0, 21, 0, 16);
                graphics.lineTo(0, 5);
                graphics.curveTo(0, 0, 5, 0);
                graphics.lineTo(16, 0);
                graphics.endFill();
                graphics.lineStyle(3, 0xFFFFFF);
                graphics.moveTo(16.4, 16.6);
                graphics.lineTo(11.65, 11.85);
                graphics.lineTo(11.65, 11.9);
                graphics.curveTo(10.45, 13, 8.75, 13);
                graphics.curveTo(7.1, 13, 5.85, 11.75);
                graphics.curveTo(4.65, 10.55, 4.65, 8.85);
                graphics.curveTo(4.65, 7.1, 5.85, 5.95);
                graphics.curveTo(7.1, 4.65, 8.75, 4.65);
                graphics.curveTo(10.5, 4.65, 11.75, 5.95);
                graphics.curveTo(13, 7.1, 13, 8.85);
                graphics.curveTo(13, 10.55, 11.75, 11.75);
                graphics.lineTo(11.65, 11.85);
                graphics.lineTo(10.65, 10.8);
            };
            this.icon.y = -1.5;
        }
        private function drawBg():void{
            graphics.clear();
            graphics.lineStyle(4, 0x282828);
            graphics.beginGradientFill("linear", [8560641, 6716929], [1, 1], [0, 0xFF], new Matrix(0, 0, 0, 0, 100, 0));
            graphics.drawRoundRect((this.icon.width + 5), 0, (_w - this.icon.width), _h, 5);
            graphics.endFill();
        }
        public function getWordDict():String{
            return (_dictionary);
        }
        public function setWordDict(dict:String):void{
            _dictionary = dict;
        }

    }
}//package cn.itamt.utils.inspector.ui 
