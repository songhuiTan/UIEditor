//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.firefox.download {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class DownloadAllButton extends InspectorButton {

        public function DownloadAllButton():void{
            super();
            _tip = InspectorLanguageManager.getStr("ReloadSwf");
        }
        override protected function buildOverState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0x99CC00);
                graphics.moveTo(5, 18.75);
                graphics.lineTo(18, 18.75);
                graphics.moveTo(11.5, 3.9);
                graphics.lineTo(11.5, 12.85);
                graphics.moveTo(6.65, 9.15);
                graphics.lineTo(11.5, 14.7);
                graphics.lineTo(16.4, 9.15);
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
                graphics.moveTo(5, 18.75);
                graphics.lineTo(18, 18.75);
                graphics.moveTo(11.5, 3.9);
                graphics.lineTo(11.5, 12.85);
                graphics.moveTo(6.65, 9.15);
                graphics.lineTo(11.5, 14.7);
                graphics.lineTo(16.4, 9.15);
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
                graphics.moveTo(5, 18.75);
                graphics.lineTo(18, 18.75);
                graphics.moveTo(11.5, 3.9);
                graphics.lineTo(11.5, 12.85);
                graphics.moveTo(6.65, 9.15);
                graphics.lineTo(11.5, 14.7);
                graphics.lineTo(16.4, 9.15);
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
                graphics.moveTo(5, 18.75);
                graphics.lineTo(18, 18.75);
                graphics.moveTo(11.5, 3.9);
                graphics.lineTo(11.5, 12.85);
                graphics.moveTo(6.65, 9.15);
                graphics.lineTo(11.5, 14.7);
                graphics.lineTo(16.4, 9.15);
            };
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.firefox.download 
