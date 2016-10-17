//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.events.*;
    import flash.display.*;

    public class InspectorViewFavoriteButton extends InspectorButton {

        private var _normalMode:Boolean = true;

        public function InspectorViewFavoriteButton(normal:Boolean=true){
            super();
            this._normalMode = normal;
            _tip = InspectorLanguageManager.getStr("MarkProperty");
            this.addEventListener(MouseEvent.CLICK, this.onToggleMode, false, 0, true);
            this.update();
        }
        public function get normalMode():Boolean{
            return (this._normalMode);
        }
        public function set normalMode(val:Boolean):void{
            this._normalMode = val;
            this.update();
        }
        private function onToggleMode(evt:MouseEvent):void{
            this._normalMode = !(this._normalMode);
            this.update();
        }
        private function update():void{
            var bmp:Bitmap;
            if (this._normalMode){
                bmp = new Bitmap(InspectorSymbolIcon.getIcon(InspectorSymbolIcon.FAVORITE));
                _tip = InspectorLanguageManager.getStr("MarkProperty");
            } else {
                bmp = new Bitmap(InspectorSymbolIcon.getIcon(InspectorSymbolIcon.DELETE));
                _tip = InspectorLanguageManager.getStr("DelMark");
            };
            this.upState = (this.downState = (this.overState = (this.hitTestState = bmp)));
        }

    }
}//package cn.itamt.utils.inspector.ui 
