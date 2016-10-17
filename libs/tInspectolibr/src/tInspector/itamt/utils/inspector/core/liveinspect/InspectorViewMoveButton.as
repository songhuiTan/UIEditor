//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.liveinspect {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class InspectorViewMoveButton extends InspectorButton {

        public function InspectorViewMoveButton():void{
            super();
            _tip = InspectorLanguageManager.getStr("LiveMove");
        }
        override protected function buildOverState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0x99CC00);
                graphics.moveTo(11.5, 4.2);
                graphics.lineTo(13.2, 5.9);
                graphics.moveTo(11.5, 4.2);
                graphics.lineTo(9.8, 5.9);
                graphics.moveTo(17.1, 9.8);
                graphics.lineTo(18.8, 11.5);
                graphics.lineTo(17.1, 13.2);
                graphics.moveTo(9.8, 17.1);
                graphics.lineTo(11.5, 18.8);
                graphics.lineTo(13.2, 17.1);
                graphics.moveTo(5.9, 13.2);
                graphics.lineTo(4.2, 11.5);
                graphics.lineTo(5.9, 9.8);
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
                graphics.moveTo(11.5, 4.2);
                graphics.lineTo(13.2, 5.9);
                graphics.moveTo(11.5, 4.2);
                graphics.lineTo(9.8, 5.9);
                graphics.moveTo(17.1, 9.8);
                graphics.lineTo(18.8, 11.5);
                graphics.lineTo(17.1, 13.2);
                graphics.moveTo(9.8, 17.1);
                graphics.lineTo(11.5, 18.8);
                graphics.lineTo(13.2, 17.1);
                graphics.moveTo(5.9, 13.2);
                graphics.lineTo(4.2, 11.5);
                graphics.lineTo(5.9, 9.8);
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
                graphics.moveTo(11.5, 4.2);
                graphics.lineTo(13.2, 5.9);
                graphics.moveTo(11.5, 4.2);
                graphics.lineTo(9.8, 5.9);
                graphics.moveTo(17.1, 9.8);
                graphics.lineTo(18.8, 11.5);
                graphics.lineTo(17.1, 13.2);
                graphics.moveTo(9.8, 17.1);
                graphics.lineTo(11.5, 18.8);
                graphics.lineTo(13.2, 17.1);
                graphics.moveTo(5.9, 13.2);
                graphics.lineTo(4.2, 11.5);
                graphics.lineTo(5.9, 9.8);
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
                graphics.moveTo(11.5, 4.2);
                graphics.lineTo(13.2, 5.9);
                graphics.moveTo(11.5, 4.2);
                graphics.lineTo(9.8, 5.9);
                graphics.moveTo(17.1, 9.8);
                graphics.lineTo(18.8, 11.5);
                graphics.lineTo(17.1, 13.2);
                graphics.moveTo(9.8, 17.1);
                graphics.lineTo(11.5, 18.8);
                graphics.lineTo(13.2, 17.1);
                graphics.moveTo(5.9, 13.2);
                graphics.lineTo(4.2, 11.5);
                graphics.lineTo(5.9, 9.8);
            };
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.core.liveinspect 
