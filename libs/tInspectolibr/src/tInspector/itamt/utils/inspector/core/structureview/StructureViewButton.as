//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.structureview {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class StructureViewButton extends InspectorButton {

        public function StructureViewButton(){
            super();
            _tip = InspectorLanguageManager.getStr("ViewStructure");
        }
        override protected function buildOverState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.lineStyle();
                graphics.beginFill(0, 1);
                graphics.moveTo(23, 5.75);
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
                graphics.curveTo(23, 3.4, 23, 5.75);
                graphics.endFill();
                graphics.lineStyle(3, 0x99CC00);
                graphics.moveTo(5.4, 11.6);
                graphics.lineTo(10.25, 11.6);
                graphics.lineTo(10.25, 6.4);
                graphics.lineTo(17.6, 6.4);
                graphics.moveTo(17.6, 11.6);
                graphics.lineTo(10.25, 11.6);
                graphics.lineTo(10.25, 16.65);
                graphics.lineTo(17.05, 16.65);
            };
            return (sp);
        }
        override protected function buildDownState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.lineStyle();
                graphics.beginFill(0, 1);
                graphics.moveTo(23, 5.75);
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
                graphics.curveTo(23, 3.4, 23, 5.75);
                graphics.endFill();
                graphics.lineStyle(3, 0xFFFFFF);
                graphics.moveTo(5.4, 11.6);
                graphics.lineTo(10.25, 11.6);
                graphics.lineTo(10.25, 6.4);
                graphics.lineTo(17.6, 6.4);
                graphics.moveTo(17.6, 11.6);
                graphics.lineTo(10.25, 11.6);
                graphics.lineTo(10.25, 16.65);
                graphics.lineTo(17.05, 16.65);
            };
            return (sp);
        }
        override protected function buildUpState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.lineStyle();
                graphics.beginFill(0, 0);
                graphics.moveTo(23, 5.75);
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
                graphics.curveTo(23, 3.4, 23, 5.75);
                graphics.endFill();
                graphics.lineStyle(3, 0xFFFFFF);
                graphics.moveTo(5.4, 11.6);
                graphics.lineTo(10.25, 11.6);
                graphics.lineTo(10.25, 6.4);
                graphics.lineTo(17.6, 6.4);
                graphics.moveTo(17.6, 11.6);
                graphics.lineTo(10.25, 11.6);
                graphics.lineTo(10.25, 16.65);
                graphics.lineTo(17.05, 16.65);
            };
            return (sp);
        }
        override protected function buildUnenabledState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.lineStyle();
                graphics.beginFill(0, 0);
                graphics.moveTo(23, 5.75);
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
                graphics.curveTo(23, 3.4, 23, 5.75);
                graphics.endFill();
                graphics.lineStyle(3, 0);
                graphics.moveTo(5.4, 11.6);
                graphics.lineTo(10.25, 11.6);
                graphics.lineTo(10.25, 6.4);
                graphics.lineTo(17.6, 6.4);
                graphics.moveTo(17.6, 11.6);
                graphics.lineTo(10.25, 11.6);
                graphics.lineTo(10.25, 16.65);
                graphics.lineTo(17.05, 16.65);
            };
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.core.structureview 
