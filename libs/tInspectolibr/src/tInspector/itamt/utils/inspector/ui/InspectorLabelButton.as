//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import flash.display.*;
    import flash.text.*;

    public class InspectorLabelButton extends InspectorButton {

        protected var _label:String = "按钮";
        protected var _minW:Number = 52;
        protected var _minH:Number = 21;

        public function InspectorLabelButton(label:String="按钮", active:Boolean=false):void{
            this._label = label;
            _active = active;
            super();
        }
        override public function set active(value:Boolean):void{
            _active = value;
            this.update();
        }
        override public function get active():Boolean{
            return (_active);
        }
        public function set label(val:String):void{
            this._label = val;
            this.update();
        }
        public function get label():String{
            return (this._label);
        }
        private function update():void{
            this.downState = this.buildDownState();
            this.upState = this.buildUpState();
            this.overState = this.buildOverState();
            this.hitTestState = this.buildDownState();
        }
        override protected function buildDownState():DisplayObject{
            var state:Sprite = new Sprite();
            var tf:TextField = InspectorTextField.create(this._label, (_active) ? 0x232323 : 0x666666);
            tf.autoSize = "left";
            var w:Number = ((tf.width < this._minW)) ? this._minW : tf.width;
            var h:Number = ((tf.height < this._minH)) ? this._minH : tf.height;
            state.graphics.beginFill((_active) ? 0xCCCCCC : 0x282828);
            state.graphics.drawRoundRect(0, 0, w, h, 4, 4);
            state.graphics.endFill();
            tf.x = ((state.width / 2) - (tf.width / 2));
            tf.y = ((state.height / 2) - (tf.height / 2));
            state.addChild(tf);
            return (state);
        }
        override protected function buildUpState():DisplayObject{
            var state:Sprite = new Sprite();
            var tf:TextField = InspectorTextField.create(this._label, 0x666666);
            tf.autoSize = "left";
            var w:Number = ((tf.width < this._minW)) ? this._minW : tf.width;
            var h:Number = ((tf.height < this._minH)) ? this._minH : tf.height;
            state.graphics.beginFill((_active) ? 0xCCCCCC : 0x282828);
            state.graphics.drawRoundRect(0, 0, w, h, 4, 4);
            state.graphics.endFill();
            tf.x = ((state.width / 2) - (tf.width / 2));
            tf.y = ((state.height / 2) - (tf.height / 2));
            state.addChild(tf);
            return (state);
        }
        override protected function buildOverState():DisplayObject{
            var state:Sprite = new Sprite();
            var tf:TextField = InspectorTextField.create(this._label, 0x666666);
            tf.autoSize = "left";
            var w:Number = ((tf.width < this._minW)) ? this._minW : tf.width;
            var h:Number = ((tf.height < this._minH)) ? this._minH : tf.height;
            state.graphics.beginFill(0xCCCCCC);
            state.graphics.drawRoundRect(0, 0, w, h, 4, 4);
            state.graphics.endFill();
            tf.x = ((state.width / 2) - (tf.width / 2));
            tf.y = ((state.height / 2) - (tf.height / 2));
            state.addChild(tf);
            return (state);
        }

    }
}//package cn.itamt.utils.inspector.ui 
