//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class PropertiesViewButton extends InspectorButton {

        public function PropertiesViewButton():void{
            super();
            _tip = InspectorLanguageManager.getStr("InspectInfo");
        }
        override protected function buildOverState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0x99CC00);
                graphics.moveTo(5.2, 9.2);
                graphics.curveTo(11.5, 2, 17.8, 9.2);
                graphics.moveTo(5.2, 13.8);
                graphics.curveTo(11.5, 21, 17.8, 13.8);
                graphics.moveTo(10.9, 11.5);
                graphics.lineTo(12, 11.5);
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
                graphics.moveTo(5.2, 9.2);
                graphics.curveTo(11.5, 2, 17.8, 9.2);
                graphics.moveTo(5.2, 13.8);
                graphics.curveTo(11.5, 21, 17.8, 13.8);
                graphics.moveTo(10.9, 11.5);
                graphics.lineTo(12, 11.5);
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
                graphics.moveTo(5.2, 9.2);
                graphics.curveTo(11.5, 2, 17.8, 9.2);
                graphics.moveTo(5.2, 13.8);
                graphics.curveTo(11.5, 21, 17.8, 13.8);
                graphics.moveTo(10.9, 11.5);
                graphics.lineTo(12, 11.5);
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
                graphics.moveTo(5.2, 9.2);
                graphics.curveTo(11.5, 2, 17.8, 9.2);
                graphics.moveTo(5.2, 13.8);
                graphics.curveTo(11.5, 21, 17.8, 13.8);
                graphics.moveTo(10.9, 11.5);
                graphics.lineTo(12, 11.5);
            };
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview 
