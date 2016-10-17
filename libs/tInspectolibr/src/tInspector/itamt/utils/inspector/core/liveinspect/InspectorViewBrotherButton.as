﻿//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.liveinspect {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class InspectorViewBrotherButton extends InspectorButton {

        public function InspectorViewBrotherButton():void{
            super();
            _tip = InspectorLanguageManager.getStr("InspectBrother");
        }
        override protected function buildOverState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
                graphics.lineStyle(3, 0x99CC00);
                graphics.moveTo(4.8, 6.9);
                graphics.lineTo(4.8, 16.2);
                graphics.moveTo(10.4, 9.8);
                graphics.lineTo(12.1, 11.5);
                graphics.lineTo(10.4, 13.2);
                graphics.moveTo(18.4, 6.9);
                graphics.lineTo(18.4, 16.2);
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
                graphics.moveTo(4.8, 6.9);
                graphics.lineTo(4.8, 16.2);
                graphics.moveTo(10.4, 9.8);
                graphics.lineTo(12.1, 11.5);
                graphics.lineTo(10.4, 13.2);
                graphics.moveTo(18.4, 6.9);
                graphics.lineTo(18.4, 16.2);
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
                graphics.moveTo(4.8, 6.9);
                graphics.lineTo(4.8, 16.2);
                graphics.moveTo(10.4, 9.8);
                graphics.lineTo(12.1, 11.5);
                graphics.lineTo(10.4, 13.2);
                graphics.moveTo(18.4, 6.9);
                graphics.lineTo(18.4, 16.2);
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
                graphics.moveTo(4.8, 6.9);
                graphics.lineTo(4.8, 16.2);
                graphics.moveTo(10.4, 9.8);
                graphics.lineTo(12.1, 11.5);
                graphics.lineTo(10.4, 13.2);
                graphics.moveTo(18.4, 6.9);
                graphics.lineTo(18.4, 16.2);
            };
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.core.liveinspect 
