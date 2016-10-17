//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.display.*;
    import flash.geom.*;

    public class InspectorViewBugButton extends InspectorButton {

        public function InspectorViewBugButton(){
            super();
            _tip = InspectorLanguageManager.getStr("SubmmitBug");
        }
        override protected function buildUpState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0xFFFFFF, 0);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            var bmd:BitmapData = InspectorSymbolIcon.getIcon(InspectorSymbolIcon.BUG);
            g.beginBitmapFill(bmd, new Matrix(1, 0, 0, 1, ((23 - bmd.width) / 2), ((23 - bmd.height) / 2)), false);
            g.drawRect(((23 - bmd.width) / 2), ((23 - bmd.height) / 2), bmd.width, bmd.height);
            g.endFill();
            return (sp);
        }
        override protected function buildOverState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0xCCCCCC, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            var bmd:BitmapData = InspectorSymbolIcon.getIcon(InspectorSymbolIcon.BUG);
            g.beginBitmapFill(bmd, new Matrix(1, 0, 0, 1, ((23 - bmd.width) / 2), ((23 - bmd.height) / 2)), false);
            g.drawRect(((23 - bmd.width) / 2), ((23 - bmd.height) / 2), bmd.width, bmd.height);
            g.endFill();
            return (sp);
        }
        override protected function buildDownState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0xCCCCCC, 0);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
            };
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.ui 
