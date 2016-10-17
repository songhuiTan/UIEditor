//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.gerrorkeeper {
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.events.*;
    import tInspector.itamt.utils.*;
    import flash.text.*;
    import flash.display.*;

    public class ErrorLogItemRenderer extends Sprite {

        protected var name_tf:TextField;
        protected var _width:Number;
        protected var _height:Number;
        protected var _errorLog:ErrorLog;

        public function ErrorLogItemRenderer(w:Number=200, h:Number=20):void{
            super();
            this._width = w;
            this._height = h;
            this.mouseChildren = false;
            this.buttonMode = true;
            this.name_tf = InspectorTextField.create("property name", 0xCCCCCC, 12, 0, 0, "left", "left");
            this.name_tf.height = (this._height - 2);
            addChild(this.name_tf);
            this.addEventListener(MouseEvent.ROLL_OVER, this.onMouseAct);
            this.addEventListener(MouseEvent.ROLL_OUT, this.onMouseAct);
            this.addEventListener(MouseEvent.CLICK, this.onMouseAct);
            this.relayout();
        }
        protected function drawBg(bgColor:uint=0x282828):void{
            this.graphics.clear();
            this.graphics.beginFill(bgColor);
            this.graphics.drawRoundRect(0, 0, ((this.name_tf.x + this.name_tf.textWidth) + 16), this._height, 5, 5);
            this.graphics.endFill();
        }
        protected function onMouseAct(evt:MouseEvent):void{
            if (evt.type == MouseEvent.ROLL_OUT){
                this.drawBg(0x282828);
            } else {
                if (evt.type == MouseEvent.ROLL_OVER){
                    this.drawBg(0x444444);
                } else {
                    if (evt.type == MouseEvent.CLICK){
                    };
                };
            };
        }
        protected function relayout():void{
            this.drawBg();
        }
        public function set data(value:Object):void{
            this._errorLog = (value as ErrorLog);
            this.label = ((("[" + TimeFormat.toTimeFormat(this._errorLog.date.getHours(), this._errorLog.date.getMinutes(), this._errorLog.date.getSeconds())) + "]") + this._errorLog.message);
        }
        public function set label(val:String):void{
            this.name_tf.text = ((val == null)) ? "" : val;
            this.relayout();
        }
        public function get label():String{
            return (this.name_tf.text);
        }
        public function get data(){
            return (this._errorLog);
        }
        public function set color(value:uint):void{
            this.name_tf.textColor = value;
        }
        public function get color():uint{
            return (this.name_tf.textColor);
        }

    }
}//package cn.itamt.utils.inspector.plugins.gerrorkeeper 
