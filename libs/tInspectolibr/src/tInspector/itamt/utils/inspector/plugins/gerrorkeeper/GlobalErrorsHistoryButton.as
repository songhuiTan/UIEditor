//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.gerrorkeeper {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class GlobalErrorsHistoryButton extends InspectorButton {

        public function GlobalErrorsHistoryButton(){
            super();
            _tip = InspectorLanguageManager.getStr("GEK_History");
        }
        override public function set active(value:Boolean):void{
            _active = value;
            if (!(active)){
                this.downState = this.buildDownState();
                this.upState = this.buildUpState();
                this.overState = this.buildOverState();
                this.hitTestState = this.buildHitState();
            } else {
                this.downState = this.buildUpState();
                this.upState = this.buildActiveState();
                this.overState = this.buildDownState();
                this.hitTestState = this.buildHitState();
            };
        }
        override protected function buildDownState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(4.4, 5.3);
            g.lineTo(11.9, 5.3);
            g.moveTo(4.4, 11.3);
            g.lineTo(11.9, 11.3);
            g.moveTo(4.4, 17.75);
            g.lineTo(11.9, 17.75);
            g.moveTo(17.2, 17.75);
            g.lineTo(18.35, 17.75);
            g.moveTo(17.2, 11.3);
            g.lineTo(18.35, 11.3);
            g.moveTo(17.2, 5.3);
            g.lineTo(18.35, 5.3);
            return (sp);
        }
        override protected function buildUpState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 0);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(4.4, 5.3);
            g.lineTo(11.9, 5.3);
            g.moveTo(4.4, 11.3);
            g.lineTo(11.9, 11.3);
            g.moveTo(4.4, 17.75);
            g.lineTo(11.9, 17.75);
            g.moveTo(17.2, 17.75);
            g.lineTo(18.35, 17.75);
            g.moveTo(17.2, 11.3);
            g.lineTo(18.35, 11.3);
            g.moveTo(17.2, 5.3);
            g.lineTo(18.35, 5.3);
            return (sp);
        }
        protected function buildActiveState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 0);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0x99CC00);
            g.moveTo(4.4, 5.3);
            g.lineTo(11.9, 5.3);
            g.moveTo(4.4, 11.3);
            g.lineTo(11.9, 11.3);
            g.moveTo(4.4, 17.75);
            g.lineTo(11.9, 17.75);
            g.moveTo(17.2, 17.75);
            g.lineTo(18.35, 17.75);
            g.moveTo(17.2, 11.3);
            g.lineTo(18.35, 11.3);
            g.moveTo(17.2, 5.3);
            g.lineTo(18.35, 5.3);
            return (sp);
        }
        override protected function buildOverState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0x99CC00);
            g.moveTo(4.4, 5.3);
            g.lineTo(11.9, 5.3);
            g.moveTo(4.4, 11.3);
            g.lineTo(11.9, 11.3);
            g.moveTo(4.4, 17.75);
            g.lineTo(11.9, 17.75);
            g.moveTo(17.2, 17.75);
            g.lineTo(18.35, 17.75);
            g.moveTo(17.2, 11.3);
            g.lineTo(18.35, 11.3);
            g.moveTo(17.2, 5.3);
            g.lineTo(18.35, 5.3);
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
            g.moveTo(4.4, 5.3);
            g.lineTo(11.9, 5.3);
            g.moveTo(4.4, 11.3);
            g.lineTo(11.9, 11.3);
            g.moveTo(4.4, 17.75);
            g.lineTo(11.9, 17.75);
            g.moveTo(17.2, 17.75);
            g.lineTo(18.35, 17.75);
            g.moveTo(17.2, 11.3);
            g.lineTo(18.35, 11.3);
            g.moveTo(17.2, 5.3);
            g.lineTo(18.35, 5.3);
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.plugins.gerrorkeeper 
