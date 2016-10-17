//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import flash.display.*;

    public class ResizerButton extends SimpleButton {

        public function ResizerButton(w:Number=10, h:Number=10){
            super(this.buildBlockShape(w, h), this.buildBlockShape(w, h), this.buildBlockShape(w, h), this.buildBlockShape(w, h));
        }
        private function buildBlockShape(w:Number, h:Number, color:uint=0x464646):Shape{
            var sp:Shape = new Shape();
            sp.graphics.lineStyle(1, 0x666666, 1, false, "normal", CapsStyle.NONE, JointStyle.MITER);
            sp.graphics.beginFill(color);
            sp.graphics.moveTo(0, 0);
            sp.graphics.lineTo(-(w), 0);
            sp.graphics.lineTo(0, -(h));
            sp.graphics.lineTo(0, 0);
            sp.graphics.moveTo((-(w) / 2), 0);
            sp.graphics.moveTo(0, (-(h) / 2));
            sp.graphics.endFill();
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.ui 
