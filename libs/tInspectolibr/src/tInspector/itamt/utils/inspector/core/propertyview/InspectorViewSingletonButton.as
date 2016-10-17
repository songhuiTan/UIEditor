//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview {
    import flash.display.*;
    import tInspector.itamt.utils.inspector.lang.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class InspectorViewSingletonButton extends InspectorViewFullButton {

        public function InspectorViewSingletonButton(){
            super();
        }
        override protected function buildOverState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0x99CC00, 1, false, "normal", CapsStyle.SQUARE, JointStyle.MITER);
            g.drawRect(6, 6, 9, 9);
            return (sp);
        }
        override protected function buildDownState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF, 1, false, "normal", CapsStyle.SQUARE, JointStyle.MITER);
            g.drawRect(6, 6, 9, 9);
            return (sp);
        }
        override protected function buildUpState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 0);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF, 1, false, "normal", CapsStyle.SQUARE, JointStyle.MITER);
            g.drawRect(6, 6, 9, 9);
            return (sp);
        }
        override protected function buildOverState2():Shape{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0x99CC00);
            g.drawRect(5, 5, 6, 6);
            g.drawRect(9, 9, 6, 6);
            return (sp);
        }
        override protected function buildDownState2():Shape{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.drawRect(5, 5, 6, 6);
            g.drawRect(9, 9, 6, 6);
            return (sp);
        }
        override protected function buildUpState2():Shape{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 0);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.drawRect(5, 5, 6, 6);
            g.drawRect(9, 9, 6, 6);
            return (sp);
        }
        override protected function updateStates():void{
            super.updateStates();
            if (_normalMode){
                _tip = InspectorLanguageManager.getStr("SingletonMode");
            } else {
                _tip = InspectorLanguageManager.getStr("MultipleMode");
            };
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview 
