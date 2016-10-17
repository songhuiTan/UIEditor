//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.gerrorkeeper {
    import tInspector.itamt.utils.inspector.lang.*;
    import tInspector.itamt.utils.inspector.plugins.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class GlobalErrorKeeperButton extends InspectorButton {

        public function GlobalErrorKeeperButton(){
            super();
            _tip = InspectorLanguageManager.getStr(InspectorPluginId.GLOBAL_ERROR_KEEPER);
        }
        override public function set active(value:Boolean):void{
            _active = value;
            if (!(active)){
                this.downState = this.buildDownState();
                this.upState = this.buildUpState();
                this.overState = this.buildOverState();
                this.hitTestState = this.buildHitState();
                _tip = InspectorLanguageManager.getStr("GEK_Disabled");
            } else {
                this.downState = this.buildUpState();
                this.upState = this.buildActiveState();
                this.overState = this.buildDownState();
                this.hitTestState = this.buildHitState();
                _tip = InspectorLanguageManager.getStr("GEK_Enabled");
            };
        }
        override protected function buildDownState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(11.5, 17.1);
            g.lineTo(11.5, 18.25);
            g.moveTo(11.55, 4.8);
            g.lineTo(11.55, 12.45);
            return (sp);
        }
        override protected function buildUpState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 0);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0xFFFFFF);
            g.moveTo(11.5, 17.1);
            g.lineTo(11.5, 18.25);
            g.moveTo(11.55, 4.8);
            g.lineTo(11.55, 12.45);
            return (sp);
        }
        protected function buildActiveState():Shape{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 0);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0x99CC00);
            g.moveTo(11.5, 17.1);
            g.lineTo(11.5, 18.25);
            g.moveTo(11.55, 4.8);
            g.lineTo(11.55, 12.45);
            return (sp);
        }
        override protected function buildOverState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.beginFill(0, 1);
            g.drawRoundRect(0, 0, 23, 23, 10, 10);
            g.endFill();
            g.lineStyle(3, 0x99CC00);
            g.moveTo(11.5, 17.1);
            g.lineTo(11.5, 18.25);
            g.moveTo(11.55, 4.8);
            g.lineTo(11.55, 12.45);
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
            g.moveTo(11.5, 17.1);
            g.lineTo(11.5, 18.25);
            g.moveTo(11.55, 4.8);
            g.lineTo(11.55, 12.45);
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.plugins.gerrorkeeper 
