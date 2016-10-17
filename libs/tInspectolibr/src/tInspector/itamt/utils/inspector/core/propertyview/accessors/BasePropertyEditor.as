//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview.accessors {
    import flash.display.*;

    public class BasePropertyEditor extends Sprite {

        protected var _width:Number = 30;
        protected var _height:Number = 20;
        protected var _readable:Boolean = true;
        protected var _value;
        public var autoSize:Boolean = true;

        public function BasePropertyEditor(){
            super();
        }
        public function setSize(w:Number, h:Number):void{
            this._width = w;
            this._height = h;
            this.relayOut();
        }
        public function relayOut():void{
            this.graphics.clear();
            this.graphics.lineStyle(2, 0x333333);
            this.graphics.drawRoundRect(0, 0, this._width, this._height, 5, 5);
        }
        protected function onWriteOnly():void{
        }
        protected function onReadOnly():void{
        }
        protected function onReadWrite():void{
        }
        public function get readable():Boolean{
            return (this._readable);
        }
        public function setValue(value):void{
            this._value = value;
        }
        public function setAccessType(access:String, exclude:Boolean=false):void{
            if (access == "writeonly"){
                this._readable = false;
                this.onWriteOnly();
            } else {
                if (access == "readonly"){
                    this._readable = true;
                    this.onReadOnly();
                } else {
                    if (access == "readwrite"){
                        this._readable = true;
                        if (!(exclude)){
                            this.onReadWrite();
                        } else {
                            this.onReadOnly();
                        };
                    };
                };
            };
        }
        public function getValue(){
            return (this._value);
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview.accessors 
