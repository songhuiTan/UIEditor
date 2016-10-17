//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.liveinspect {
    import flash.display.*;
    import tInspector.itamt.utils.inspector.lang.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class LiveInspectButton extends InspectorViewFullButton {

        public function LiveInspectButton(){
            super();
        }
        override protected function buildOverState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0x99CC00);
            g.moveTo(17.15, 17.15);
            g.lineTo(5.45, 5.45);
            g.curveTo(4.95, 5.95, 4.95, 6.95);
            g.lineTo(6.35, 13.15);
            g.moveTo(4.95, 4.95);
            g.lineTo(5.45, 5.45);
            g.curveTo(5.95, 4.95, 6.95, 4.95);
            g.lineTo(13.05, 6.6);
            return (sp);
        }
        override protected function buildDownState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(17.15, 17.15);
            g.lineTo(5.45, 5.45);
            g.curveTo(4.95, 5.95, 4.95, 6.95);
            g.lineTo(6.35, 13.15);
            g.moveTo(4.95, 4.95);
            g.lineTo(5.45, 5.45);
            g.curveTo(5.95, 4.95, 6.95, 4.95);
            g.lineTo(13.05, 6.6);
            return (sp);
        }
        override protected function buildUpState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 0);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(17.15, 17.15);
            g.lineTo(5.45, 5.45);
            g.curveTo(4.95, 5.95, 4.95, 6.95);
            g.lineTo(6.35, 13.15);
            g.moveTo(4.95, 4.95);
            g.lineTo(5.45, 5.45);
            g.curveTo(5.95, 4.95, 6.95, 4.95);
            g.lineTo(13.05, 6.6);
            return (sp);
        }
        override protected function buildOverState2():Shape{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0x99CC00);
            g.moveTo(17.15, 17.15);
            g.lineTo(5.45, 5.45);
            g.curveTo(4.95, 5.95, 4.95, 6.95);
            g.lineTo(6.35, 13.15);
            g.moveTo(4.95, 4.95);
            g.lineTo(5.45, 5.45);
            g.curveTo(5.95, 4.95, 6.95, 4.95);
            g.lineTo(13.05, 6.6);
            return (sp);
        }
        override protected function buildDownState2():Shape{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(17.15, 17.15);
            g.lineTo(5.45, 5.45);
            g.curveTo(4.95, 5.95, 4.95, 6.95);
            g.lineTo(6.35, 13.15);
            g.moveTo(4.95, 4.95);
            g.lineTo(5.45, 5.45);
            g.curveTo(5.95, 4.95, 6.95, 4.95);
            g.lineTo(13.05, 6.6);
            return (sp);
        }
        override protected function buildUpState2():Shape{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 0);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(17.15, 17.15);
            g.lineTo(5.45, 5.45);
            g.curveTo(4.95, 5.95, 4.95, 6.95);
            g.lineTo(6.35, 13.15);
            g.moveTo(4.95, 4.95);
            g.lineTo(5.45, 5.45);
            g.curveTo(5.95, 4.95, 6.95, 4.95);
            g.lineTo(13.05, 6.6);
            return (sp);
        }
        override protected function updateStates():void{
            super.updateStates();
            if (_normalMode){
                _tip = InspectorLanguageManager.getStr("StartMouseInspect");
            } else {
                _tip = InspectorLanguageManager.getStr("StopMouseInspect");
            };
        }

    }
}//package cn.itamt.utils.inspector.core.liveinspect 
