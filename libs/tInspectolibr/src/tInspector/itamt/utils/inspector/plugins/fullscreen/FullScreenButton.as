//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.fullscreen {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class FullScreenButton extends InspectorButton {

        public function FullScreenButton():void{
            super();
            _tip = InspectorLanguageManager.getStr("FullScreen");
        }
        override protected function buildOverState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0x99CC00);
                graphics.moveTo(15.15, 5.25);
                graphics.lineTo(18.3, 5.25);
                graphics.lineTo(18.3, 8.4);
                graphics.moveTo(5.1, 8.4);
                graphics.lineTo(5.1, 5.25);
                graphics.lineTo(8.25, 5.25);
                graphics.moveTo(8.25, 18.45);
                graphics.lineTo(5.1, 18.45);
                graphics.lineTo(5.1, 15.5);
                graphics.moveTo(18.3, 15.5);
                graphics.lineTo(18.3, 18.45);
                graphics.lineTo(15.15, 18.45);
            };
            return (sp);
        }
        override protected function buildDownState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0xFFFFFF);
                graphics.moveTo(15.15, 5.25);
                graphics.lineTo(18.3, 5.25);
                graphics.lineTo(18.3, 8.4);
                graphics.moveTo(5.1, 8.4);
                graphics.lineTo(5.1, 5.25);
                graphics.lineTo(8.25, 5.25);
                graphics.moveTo(8.25, 18.45);
                graphics.lineTo(5.1, 18.45);
                graphics.lineTo(5.1, 15.5);
                graphics.moveTo(18.3, 15.5);
                graphics.lineTo(18.3, 18.45);
                graphics.lineTo(15.15, 18.45);
            };
            return (sp);
        }
        override protected function buildUpState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 0);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0xFFFFFF);
                graphics.moveTo(15.15, 5.25);
                graphics.lineTo(18.3, 5.25);
                graphics.lineTo(18.3, 8.4);
                graphics.moveTo(5.1, 8.4);
                graphics.lineTo(5.1, 5.25);
                graphics.lineTo(8.25, 5.25);
                graphics.moveTo(8.25, 18.45);
                graphics.lineTo(5.1, 18.45);
                graphics.lineTo(5.1, 15.5);
                graphics.moveTo(18.3, 15.5);
                graphics.lineTo(18.3, 18.45);
                graphics.lineTo(15.15, 18.45);
            };
            return (sp);
        }
        override protected function buildUnenabledState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 0);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0xFFFFFF);
                graphics.moveTo(15.15, 5.25);
                graphics.lineTo(18.3, 5.25);
                graphics.lineTo(18.3, 8.4);
                graphics.moveTo(5.1, 8.4);
                graphics.lineTo(5.1, 5.25);
                graphics.lineTo(8.25, 5.25);
                graphics.moveTo(8.25, 18.45);
                graphics.lineTo(5.1, 18.45);
                graphics.lineTo(5.1, 15.5);
                graphics.moveTo(18.3, 15.5);
                graphics.lineTo(18.3, 18.45);
                graphics.lineTo(15.15, 18.45);
            };
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.plugins.fullscreen 
