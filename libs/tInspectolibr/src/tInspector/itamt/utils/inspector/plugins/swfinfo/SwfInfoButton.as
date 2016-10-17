//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.swfinfo {
    import tInspector.itamt.utils.inspector.lang.*;
    import tInspector.itamt.utils.inspector.plugins.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class SwfInfoButton extends InspectorButton {

        public function SwfInfoButton(){
            super();
            _tip = InspectorLanguageManager.getStr(InspectorPluginId.SWFINFO_VIEW);
        }
        override protected function buildDownState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(17, 5.5);
            g.curveTo(14.7, 5.5, 12.95, 7.05);
            g.curveTo(11.1, 8.75, 11.05, 11.45);
            g.lineTo(11.05, 12);
            g.lineTo(16.4, 11.85);
            g.moveTo(11.05, 12);
            g.curveTo(10.95, 14.15, 10, 15.5);
            g.curveTo(8.7, 17.55, 6, 17.55);
            return (sp);
        }
        override protected function buildUpState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 0);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(17, 5.5);
            g.curveTo(14.7, 5.5, 12.95, 7.05);
            g.curveTo(11.1, 8.75, 11.05, 11.45);
            g.lineTo(11.05, 12);
            g.lineTo(16.4, 11.85);
            g.moveTo(11.05, 12);
            g.curveTo(10.95, 14.15, 10, 15.5);
            g.curveTo(8.7, 17.55, 6, 17.55);
            return (sp);
        }
        override protected function buildOverState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0x99CC00);
            g.moveTo(17, 5.5);
            g.curveTo(14.7, 5.5, 12.95, 7.05);
            g.curveTo(11.1, 8.75, 11.05, 11.45);
            g.lineTo(11.05, 12);
            g.lineTo(16.4, 11.85);
            g.moveTo(11.05, 12);
            g.curveTo(10.95, 14.15, 10, 15.5);
            g.curveTo(8.7, 17.55, 6, 17.55);
            return (sp);
        }
        override protected function buildHitState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            return (sp);
        }
        override protected function buildUnenabledState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 0);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(17, 5.5);
            g.curveTo(14.7, 5.5, 12.95, 7.05);
            g.curveTo(11.1, 8.75, 11.05, 11.45);
            g.lineTo(11.05, 12);
            g.lineTo(16.4, 11.85);
            g.moveTo(11.05, 12);
            g.curveTo(10.95, 14.15, 10, 15.5);
            g.curveTo(8.7, 17.55, 6, 17.55);
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.plugins.swfinfo 
