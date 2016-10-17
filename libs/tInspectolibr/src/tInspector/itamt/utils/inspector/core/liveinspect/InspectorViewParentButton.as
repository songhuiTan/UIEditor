//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.liveinspect {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class InspectorViewParentButton extends InspectorButton {

        public function InspectorViewParentButton():void{
            super();
            _tip = InspectorLanguageManager.getStr("InspectParent");
        }
        override protected function buildOverState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0x99CC00);
                graphics.moveTo(5.2, 4.9);
                graphics.lineTo(17.8, 4.9);
                graphics.moveTo(13.2, 12.4);
                graphics.lineTo(11.5, 10.7);
                graphics.lineTo(9.8, 12.4);
                graphics.moveTo(6.9, 18.6);
                graphics.lineTo(16.1, 18.6);
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
                graphics.moveTo(5.2, 4.9);
                graphics.lineTo(17.8, 4.9);
                graphics.moveTo(13.2, 12.4);
                graphics.lineTo(11.5, 10.7);
                graphics.lineTo(9.8, 12.4);
                graphics.moveTo(6.9, 18.6);
                graphics.lineTo(16.1, 18.6);
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
                graphics.moveTo(5.2, 4.9);
                graphics.lineTo(17.8, 4.9);
                graphics.moveTo(13.2, 12.4);
                graphics.lineTo(11.5, 10.7);
                graphics.lineTo(9.8, 12.4);
                graphics.moveTo(6.9, 18.6);
                graphics.lineTo(16.1, 18.6);
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
                graphics.moveTo(5.2, 4.9);
                graphics.lineTo(17.8, 4.9);
                graphics.moveTo(13.2, 12.4);
                graphics.lineTo(11.5, 10.7);
                graphics.lineTo(9.8, 12.4);
                graphics.moveTo(6.9, 18.6);
                graphics.lineTo(16.1, 18.6);
            };
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.core.liveinspect 
