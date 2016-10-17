﻿//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.display.*;

    public class InspectorViewRefreshButton extends InspectorButton {

        public function InspectorViewRefreshButton(){
            super();
            _tip = InspectorLanguageManager.getStr("Refresh");
        }
        override protected function buildDownState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(4.5, 10);
            g.curveTo(4.5, 4.5, 10, 4.5);
            g.curveTo(15.5, 4.5, 15.5, 10);
            g.curveTo(15.5, 15.5, 10, 15.5);
            return (sp);
        }
        override protected function buildUpState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 0);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(4.5, 10);
            g.curveTo(4.5, 4.5, 10, 4.5);
            g.curveTo(15.5, 4.5, 15.5, 10);
            g.curveTo(15.5, 15.5, 10, 15.5);
            return (sp);
        }
        override protected function buildOverState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0x99CC00);
            g.moveTo(4.5, 10);
            g.curveTo(4.5, 4.5, 10, 4.5);
            g.curveTo(15.5, 4.5, 15.5, 10);
            g.curveTo(15.5, 15.5, 10, 15.5);
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
            g.lineStyle(3, 0);
            g.moveTo(4.5, 10);
            g.curveTo(4.5, 4.5, 10, 4.5);
            g.curveTo(15.5, 4.5, 15.5, 10);
            g.curveTo(15.5, 15.5, 10, 15.5);
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.ui 
