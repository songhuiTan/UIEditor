//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.inspectfilter {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class FilterManagerButton extends InspectorButton {

        public function FilterManagerButton(){
            super();
            _tip = InspectorLanguageManager.getStr("SetFilterClass");
        }
        override protected function buildOverState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.lineStyle();
                graphics.beginFill(0);
                graphics.moveTo(21.35, 1.75);
                graphics.curveTo(23, 3.4, 23, 5.75);
                graphics.lineTo(23, 17.25);
                graphics.curveTo(23, 19.6, 21.35, 21.35);
                graphics.curveTo(19.6, 23, 17.25, 23);
                graphics.lineTo(5.75, 23);
                graphics.curveTo(3.4, 23, 1.75, 21.35);
                graphics.curveTo(0, 19.6, 0, 17.25);
                graphics.lineTo(0, 5.75);
                graphics.curveTo(0, 3.4, 1.75, 1.75);
                graphics.curveTo(3.4, 0, 5.75, 0);
                graphics.lineTo(17.25, 0);
                graphics.curveTo(19.6, 0, 21.35, 1.75);
                graphics.beginFill(0x99CC00);
                graphics.moveTo(13.15, 9.8);
                graphics.curveTo(13.9, 10.5, 13.9, 11.5);
                graphics.curveTo(13.9, 12.5, 13.15, 13.2);
                graphics.curveTo(12.45, 13.9, 11.5, 13.9);
                graphics.curveTo(10.55, 13.9, 9.8, 13.2);
                graphics.curveTo(9.1, 12.5, 9.1, 11.5);
                graphics.curveTo(9.1, 10.5, 9.8, 9.8);
                graphics.curveTo(10.55, 9.1, 11.5, 9.1);
                graphics.curveTo(12.45, 9.1, 13.15, 9.8);
                graphics.endFill();
                graphics.lineStyle(3, 0x99CC00);
                graphics.moveTo(15, 5.3);
                graphics.lineTo(7.6, 5.3);
                graphics.curveTo(4.15, 5.3, 4.15, 8.75);
                graphics.lineTo(4.15, 13.95);
                graphics.curveTo(4.15, 17.4, 7.6, 17.4);
                graphics.lineTo(15, 17.4);
                graphics.curveTo(18.45, 17.4, 18.45, 13.95);
                graphics.lineTo(18.45, 8.75);
                graphics.curveTo(18.45, 5.3, 15, 5.3);
            };
            return (sp);
        }
        override protected function buildDownState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.lineStyle();
                graphics.beginFill(0);
                graphics.moveTo(21.35, 1.75);
                graphics.curveTo(23, 3.4, 23, 5.75);
                graphics.lineTo(23, 17.25);
                graphics.curveTo(23, 19.6, 21.35, 21.35);
                graphics.curveTo(19.6, 23, 17.25, 23);
                graphics.lineTo(5.75, 23);
                graphics.curveTo(3.4, 23, 1.75, 21.35);
                graphics.curveTo(0, 19.6, 0, 17.25);
                graphics.lineTo(0, 5.75);
                graphics.curveTo(0, 3.4, 1.75, 1.75);
                graphics.curveTo(3.4, 0, 5.75, 0);
                graphics.lineTo(17.25, 0);
                graphics.curveTo(19.6, 0, 21.35, 1.75);
                graphics.beginFill(0xFFFFFF);
                graphics.moveTo(13.15, 9.8);
                graphics.curveTo(13.9, 10.5, 13.9, 11.5);
                graphics.curveTo(13.9, 12.5, 13.15, 13.2);
                graphics.curveTo(12.45, 13.9, 11.5, 13.9);
                graphics.curveTo(10.55, 13.9, 9.8, 13.2);
                graphics.curveTo(9.1, 12.5, 9.1, 11.5);
                graphics.curveTo(9.1, 10.5, 9.8, 9.8);
                graphics.curveTo(10.55, 9.1, 11.5, 9.1);
                graphics.curveTo(12.45, 9.1, 13.15, 9.8);
                graphics.endFill();
                graphics.lineStyle(3, 0xFFFFFF);
                graphics.moveTo(15, 5.3);
                graphics.lineTo(7.6, 5.3);
                graphics.curveTo(4.15, 5.3, 4.15, 8.75);
                graphics.lineTo(4.15, 13.95);
                graphics.curveTo(4.15, 17.4, 7.6, 17.4);
                graphics.lineTo(15, 17.4);
                graphics.curveTo(18.45, 17.4, 18.45, 13.95);
                graphics.lineTo(18.45, 8.75);
                graphics.curveTo(18.45, 5.3, 15, 5.3);
            };
            return (sp);
        }
        override protected function buildUpState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.lineStyle();
                graphics.beginFill(0, 0);
                graphics.moveTo(21.35, 1.75);
                graphics.curveTo(23, 3.4, 23, 5.75);
                graphics.lineTo(23, 17.25);
                graphics.curveTo(23, 19.6, 21.35, 21.35);
                graphics.curveTo(19.6, 23, 17.25, 23);
                graphics.lineTo(5.75, 23);
                graphics.curveTo(3.4, 23, 1.75, 21.35);
                graphics.curveTo(0, 19.6, 0, 17.25);
                graphics.lineTo(0, 5.75);
                graphics.curveTo(0, 3.4, 1.75, 1.75);
                graphics.curveTo(3.4, 0, 5.75, 0);
                graphics.lineTo(17.25, 0);
                graphics.curveTo(19.6, 0, 21.35, 1.75);
                graphics.beginFill(0xFFFFFF);
                graphics.moveTo(13.15, 9.8);
                graphics.curveTo(13.9, 10.5, 13.9, 11.5);
                graphics.curveTo(13.9, 12.5, 13.15, 13.2);
                graphics.curveTo(12.45, 13.9, 11.5, 13.9);
                graphics.curveTo(10.55, 13.9, 9.8, 13.2);
                graphics.curveTo(9.1, 12.5, 9.1, 11.5);
                graphics.curveTo(9.1, 10.5, 9.8, 9.8);
                graphics.curveTo(10.55, 9.1, 11.5, 9.1);
                graphics.curveTo(12.45, 9.1, 13.15, 9.8);
                graphics.endFill();
                graphics.lineStyle(3, 0xFFFFFF);
                graphics.moveTo(15, 5.3);
                graphics.lineTo(7.6, 5.3);
                graphics.curveTo(4.15, 5.3, 4.15, 8.75);
                graphics.lineTo(4.15, 13.95);
                graphics.curveTo(4.15, 17.4, 7.6, 17.4);
                graphics.lineTo(15, 17.4);
                graphics.curveTo(18.45, 17.4, 18.45, 13.95);
                graphics.lineTo(18.45, 8.75);
                graphics.curveTo(18.45, 5.3, 15, 5.3);
            };
            return (sp);
        }
        override protected function buildUnenabledState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.lineStyle();
                graphics.beginFill(0, 0);
                graphics.moveTo(21.35, 1.75);
                graphics.curveTo(23, 3.4, 23, 5.75);
                graphics.lineTo(23, 17.25);
                graphics.curveTo(23, 19.6, 21.35, 21.35);
                graphics.curveTo(19.6, 23, 17.25, 23);
                graphics.lineTo(5.75, 23);
                graphics.curveTo(3.4, 23, 1.75, 21.35);
                graphics.curveTo(0, 19.6, 0, 17.25);
                graphics.lineTo(0, 5.75);
                graphics.curveTo(0, 3.4, 1.75, 1.75);
                graphics.curveTo(3.4, 0, 5.75, 0);
                graphics.lineTo(17.25, 0);
                graphics.curveTo(19.6, 0, 21.35, 1.75);
                graphics.beginFill(0);
                graphics.moveTo(13.15, 9.8);
                graphics.curveTo(13.9, 10.5, 13.9, 11.5);
                graphics.curveTo(13.9, 12.5, 13.15, 13.2);
                graphics.curveTo(12.45, 13.9, 11.5, 13.9);
                graphics.curveTo(10.55, 13.9, 9.8, 13.2);
                graphics.curveTo(9.1, 12.5, 9.1, 11.5);
                graphics.curveTo(9.1, 10.5, 9.8, 9.8);
                graphics.curveTo(10.55, 9.1, 11.5, 9.1);
                graphics.curveTo(12.45, 9.1, 13.15, 9.8);
                graphics.endFill();
                graphics.lineStyle(3, 0);
                graphics.moveTo(15, 5.3);
                graphics.lineTo(7.6, 5.3);
                graphics.curveTo(4.15, 5.3, 4.15, 8.75);
                graphics.lineTo(4.15, 13.95);
                graphics.curveTo(4.15, 17.4, 7.6, 17.4);
                graphics.lineTo(15, 17.4);
                graphics.curveTo(18.45, 17.4, 18.45, 13.95);
                graphics.lineTo(18.45, 8.75);
                graphics.curveTo(18.45, 5.3, 15, 5.3);
            };
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.core.inspectfilter 
