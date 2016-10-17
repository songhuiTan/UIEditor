//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.liveinspect {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class InspectorViewCloseButton extends InspectorButton {

        public function InspectorViewCloseButton():void{
            super();
            _tip = InspectorLanguageManager.getStr("Close");
        }
        override protected function buildOverState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0xFF0000);
                graphics.moveTo(8.7, 8.7);
                graphics.lineTo(14.2, 14.2);
                graphics.moveTo(8.7, 14.2);
                graphics.lineTo(14.2, 8.7);
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
                graphics.moveTo(8.7, 8.7);
                graphics.lineTo(14.2, 14.2);
                graphics.moveTo(8.7, 14.2);
                graphics.lineTo(14.2, 8.7);
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
                graphics.lineStyle(3, 0xFF0000);
                graphics.moveTo(8.7, 8.7);
                graphics.lineTo(14.2, 14.2);
                graphics.moveTo(8.7, 14.2);
                graphics.lineTo(14.2, 8.7);
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
                graphics.lineStyle(3, 0);
                graphics.moveTo(8.7, 8.7);
                graphics.lineTo(14.2, 14.2);
                graphics.moveTo(8.7, 14.2);
                graphics.lineTo(14.2, 8.7);
            };
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.core.liveinspect 
