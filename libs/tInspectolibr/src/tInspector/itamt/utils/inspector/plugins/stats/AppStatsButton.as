//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.stats {
    import tInspector.itamt.utils.inspector.lang.*;
    import tInspector.itamt.utils.inspector.plugins.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class AppStatsButton extends InspectorButton {

        public function AppStatsButton(){
            super();
            _tip = InspectorLanguageManager.getStr(InspectorPluginId.APPSTATS_VIEW);
        }
        override protected function buildDownState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(3.75, 11.6);
            g.curveTo(5, 5.1, 7.45, 5.05);
            g.curveTo(9.9, 5, 11.25, 11.55);
            g.curveTo(12.5, 17.6, 15.15, 17.5);
            g.curveTo(17.85, 17.3, 19.3, 10.5);
            return (sp);
        }
        override protected function buildUpState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 0);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(3.75, 11.6);
            g.curveTo(5, 5.1, 7.45, 5.05);
            g.curveTo(9.9, 5, 11.25, 11.55);
            g.curveTo(12.5, 17.6, 15.15, 17.5);
            g.curveTo(17.85, 17.3, 19.3, 10.5);
            return (sp);
        }
        override protected function buildOverState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0x99CC00);
            g.moveTo(3.75, 11.6);
            g.curveTo(5, 5.1, 7.45, 5.05);
            g.curveTo(9.9, 5, 11.25, 11.55);
            g.curveTo(12.5, 17.6, 15.15, 17.5);
            g.curveTo(17.85, 17.3, 19.3, 10.5);
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
            g.moveTo(3.75, 11.6);
            g.curveTo(5, 5.1, 7.45, 5.05);
            g.curveTo(9.9, 5, 11.25, 11.55);
            g.curveTo(12.5, 17.6, 15.15, 17.5);
            g.curveTo(17.85, 17.3, 19.3, 10.5);
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.plugins.stats 
