//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import flash.display.*;
    import flash.geom.*;
    import flash.filters.*;

    public class InspectorIconButton extends InspectorButton {

        private var bmd:BitmapData;

        public function InspectorIconButton(icon:String){
            this.bmd = InspectorSymbolIcon.getIcon(icon);
            super();
        }
        override protected function buildUpState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0xFFFFFF, 0);
            g.drawRoundRect(0, 0, 16, 16, 10, 10);
            g.endFill();
            g.beginBitmapFill(this.bmd, new Matrix(1, 0, 0, 1, ((16 - this.bmd.width) / 2), ((16 - this.bmd.height) / 2)), false);
            g.drawRect(((16 - this.bmd.width) / 2), ((16 - this.bmd.height) / 2), this.bmd.width, this.bmd.height);
            g.endFill();
            return (sp);
        }
        override protected function buildOverState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0xCCCCCC, 0);
            g.drawRoundRect(0, 0, 16, 16, 10, 10);
            g.endFill();
            g.beginBitmapFill(this.bmd, new Matrix(1, 0, 0, 1, ((16 - this.bmd.width) / 2), ((16 - this.bmd.height) / 2)), false);
            g.drawRect(((16 - this.bmd.width) / 2), ((16 - this.bmd.height) / 2), this.bmd.width, this.bmd.height);
            g.endFill();
            sp.filters = [new ColorMatrixFilter([0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0.3086, 0.6094, 0.082, 0, 0, 0, 0, 0, 1, 0])];
            return (sp);
        }
        override protected function buildDownState():DisplayObject{
            var sp:* = new Shape();
            var _local2 = sp;
            with (_local2) {
                graphics.beginFill(0xCCCCCC, 0);
                graphics.drawRoundRect(0, 0, 16, 16, 10, 10);
                graphics.endFill();
            };
            var g:* = sp.graphics;
            g.beginBitmapFill(this.bmd, new Matrix(1, 0, 0, 1, ((16 - this.bmd.width) / 2), ((16 - this.bmd.height) / 2)), false);
            g.drawRect(((16 - this.bmd.width) / 2), ((16 - this.bmd.height) / 2), this.bmd.width, this.bmd.height);
            g.endFill();
            return (sp);
        }
        public function dispose():void{
            this.bmd = null;
        }

    }
}//package cn.itamt.utils.inspector.ui 
