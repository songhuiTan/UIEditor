//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.firefox.download {
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.events.*;
    import flash.net.*;
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.text.*;
    import flash.display.*;

    public class LoadedStuffItemRenderer extends Sprite {

        protected var name_tf:TextField;
        protected var _width:Number;
        protected var _height:Number;
        protected var _iconSave:InspectorIconButton;
        protected var _loadedLog:LoadedStuffInfo;
        protected var _paddingLeft:Number = 0;
        private var _background:Boolean;

        public function LoadedStuffItemRenderer(w:Number=200, h:Number=20):void{
            super();
            this._width = w;
            this._height = h;
            this.mouseEnabled = false;
            this.buttonMode = true;
            this.name_tf = InspectorTextField.create("property name", 0xCCCCCC, 12, 0, 0, "left", "left");
            this.name_tf.height = (this._height - 2);
            addChild(this.name_tf);
            this.name_tf.addEventListener(MouseEvent.ROLL_OVER, this.onMouseAct);
            this.name_tf.addEventListener(MouseEvent.ROLL_OUT, this.onMouseAct);
            this.name_tf.addEventListener(MouseEvent.CLICK, this.onMouseAct);
            this.relayout();
        }
        protected function drawBg(bgColor:uint=0x282828, alpha:Number=1):void{
            this.graphics.clear();
            this.graphics.beginFill(bgColor, alpha);
            this.graphics.drawRoundRect((20 + this._paddingLeft), 0, (this.name_tf.textWidth + 4), this._height, 5, 5);
            this.graphics.endFill();
        }
        protected function onMouseAct(evt:MouseEvent):void{
            if (evt.type == MouseEvent.ROLL_OUT){
                this.drawBg(0x282828, (this._background) ? 1 : 0);
            } else {
                if (evt.type == MouseEvent.ROLL_OVER){
                    this.drawBg(0x444444);
                } else {
                    if (evt.type == MouseEvent.CLICK){
                        evt.stopImmediatePropagation();
                        this.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                    };
                };
            };
        }
        protected function relayout():void{
            if (this._iconSave){
                this._iconSave.x = this._paddingLeft;
                this._iconSave.y = 2;
            };
            this.name_tf.x = (20 + this._paddingLeft);
            this.drawBg(0x282828, (this._background) ? 1 : 0);
        }
        protected function getBriefUrl(url:String):String{
            var ret:String;
            if (url.indexOf("?") > 0){
                url = url.slice(0, url.indexOf("?"));
            };
            var pStart:int = (url.indexOf("//") + 2);
            var pEnd:int = (url.indexOf("/", pStart) + 1);
            var eStart:int = (url.lastIndexOf("/") + 1);
            var eEnd:int = url.length;
            ret = ((url.slice(pStart, pEnd) + ".../") + url.slice(eStart, eEnd));
            return (ret);
        }
        private function getBriefContentType(contentType:String):String{
            return ("");
        }
        private function onClickSave(event:MouseEvent):void{
            navigateToURL(new URLRequest(this._loadedLog.url), "_blank");
        }
        public function set data(value:Object):void{
            this._loadedLog = (value as LoadedStuffInfo);
            if (((this._iconSave) && (this.contains(this._iconSave)))){
                this.removeChild(this._iconSave);
                this._iconSave.dispose();
                this._iconSave.removeEventListener(MouseEvent.CLICK, this.onClickSave);
            };
            this._iconSave = new InspectorIconButton(InspectorSymbolIcon.getIconNameByContentType(this._loadedLog.contentType));
            this._iconSave.tip = InspectorLanguageManager.getStr("OpenTip");
            this._iconSave.addEventListener(MouseEvent.CLICK, this.onClickSave);
            addChild(this._iconSave);
        }
        public function set label(val:String):void{
            this.name_tf.htmlText = (("<a href='#'><font color='#ffffff'>" + ((val == null)) ? "" : val) + "</font></a>");
            this.relayout();
        }
        public function get label():String{
            return (this.name_tf.text);
        }
        public function get data(){
            return (this._loadedLog);
        }
        public function set color(value:uint):void{
            this.name_tf.textColor = value;
        }
        public function get color():uint{
            return (this.name_tf.textColor);
        }
        public function set background(val:Boolean):void{
            if (this._background != val){
                this._background = val;
                this.drawBg(0x282828, (this._background) ? 1 : 0);
            };
        }
        public function get background():Boolean{
            return (this._background);
        }
        public function dispose():void{
            this._loadedLog = null;
            this._iconSave = null;
            this.name_tf.removeEventListener(MouseEvent.ROLL_OVER, this.onMouseAct);
            this.name_tf.removeEventListener(MouseEvent.ROLL_OUT, this.onMouseAct);
            this.name_tf.removeEventListener(MouseEvent.CLICK, this.onMouseAct);
        }
        public function set paddingLeft(paddingLeft:uint):void{
            this._paddingLeft = paddingLeft;
            this.relayout();
        }

    }
}//package cn.itamt.utils.inspector.firefox.download 
