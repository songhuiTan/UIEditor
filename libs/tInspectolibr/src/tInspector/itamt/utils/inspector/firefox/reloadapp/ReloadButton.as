//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.firefox.reloadapp {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class ReloadButton extends InspectorButton {

        public function ReloadButton():void{
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
                graphics.moveTo(15.35, 11.9);
                graphics.lineTo(15.3, 12.35);
                graphics.lineTo(15.2, 12.8);
                graphics.lineTo(15.05, 13.45);
                graphics.lineTo(13.9, 15.1);
                graphics.curveTo(12.45, 16.55, 10.4, 16.55);
                graphics.curveTo(8.3, 16.6, 6.8, 15.1);
                graphics.curveTo(5.35, 13.65, 5.4, 11.55);
                graphics.curveTo(5.4, 9.5, 6.8, 8.05);
                graphics.curveTo(7.8, 7.05, 9.1, 6.7);
                graphics.lineTo(9.6, 6.6);
                graphics.lineTo(10.4, 6.55);
                graphics.lineTo(11.1, 6.6);
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
                graphics.moveTo(15.35, 11.9);
                graphics.lineTo(15.3, 12.35);
                graphics.lineTo(15.2, 12.8);
                graphics.lineTo(15.05, 13.45);
                graphics.lineTo(13.9, 15.1);
                graphics.curveTo(12.45, 16.55, 10.4, 16.55);
                graphics.curveTo(8.3, 16.6, 6.8, 15.1);
                graphics.curveTo(5.35, 13.65, 5.4, 11.55);
                graphics.curveTo(5.4, 9.5, 6.8, 8.05);
                graphics.curveTo(7.8, 7.05, 9.1, 6.7);
                graphics.lineTo(9.6, 6.6);
                graphics.lineTo(10.4, 6.55);
                graphics.lineTo(11.1, 6.6);
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
                graphics.moveTo(15.35, 11.9);
                graphics.lineTo(15.3, 12.35);
                graphics.lineTo(15.2, 12.8);
                graphics.lineTo(15.05, 13.45);
                graphics.lineTo(13.9, 15.1);
                graphics.curveTo(12.45, 16.55, 10.4, 16.55);
                graphics.curveTo(8.3, 16.6, 6.8, 15.1);
                graphics.curveTo(5.35, 13.65, 5.4, 11.55);
                graphics.curveTo(5.4, 9.5, 6.8, 8.05);
                graphics.curveTo(7.8, 7.05, 9.1, 6.7);
                graphics.lineTo(9.6, 6.6);
                graphics.lineTo(10.4, 6.55);
                graphics.lineTo(11.1, 6.6);
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
                graphics.moveTo(15.35, 11.9);
                graphics.lineTo(15.3, 12.35);
                graphics.lineTo(15.2, 12.8);
                graphics.lineTo(15.05, 13.45);
                graphics.lineTo(13.9, 15.1);
                graphics.curveTo(12.45, 16.55, 10.4, 16.55);
                graphics.curveTo(8.3, 16.6, 6.8, 15.1);
                graphics.curveTo(5.35, 13.65, 5.4, 11.55);
                graphics.curveTo(5.4, 9.5, 6.8, 8.05);
                graphics.curveTo(7.8, 7.05, 9.1, 6.7);
                graphics.lineTo(9.6, 6.6);
                graphics.lineTo(10.4, 6.55);
                graphics.lineTo(11.1, 6.6);
            };
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.firefox.reloadapp 
