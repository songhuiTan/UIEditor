//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.controlbar {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.geom.*;

    public class InspectorOnOffButton extends InspectorButton {

        public function InspectorOnOffButton(){
            super();
            _tip = InspectorLanguageManager.getStr("InspectorOnOff");
        }
        override protected function buildUpState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0xFFFFFF, 0);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            var bmd:BitmapData = InspectorSymbolIcon.getIcon(InspectorSymbolIcon.LOGO);
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
            var bmd:BitmapData = InspectorSymbolIcon.getIcon(InspectorSymbolIcon.LOGO);
            g.beginBitmapFill(bmd, new Matrix(1, 0, 0, 1, ((23 - bmd.width) / 2), ((23 - bmd.height) / 2)), false);
            g.drawRect(((23 - bmd.width) / 2), ((23 - bmd.height) / 2), bmd.width, bmd.height);
            g.endFill();
            return (sp);
        }
        override protected function buildDownState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0xCCCCCC, 1);
                graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
                graphics.endFill();
            };
            var g:* = sp.graphics;
            var bmd:* = InspectorSymbolIcon.getIcon(InspectorSymbolIcon.LOGO);
            g.beginBitmapFill(bmd, new Matrix(1, 0, 0, 1, ((23 - bmd.width) / 2), ((23 - bmd.height) / 2)), false);
            g.drawRect(((23 - bmd.width) / 2), ((23 - bmd.height) / 2), bmd.width, bmd.height);
            g.endFill();
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.plugins.controlbar 
