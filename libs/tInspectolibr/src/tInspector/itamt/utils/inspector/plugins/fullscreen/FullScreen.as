//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.fullscreen {
    import flash.events.*;
    import tInspector.itamt.utils.inspector.core.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.plugins.*;

    public class FullScreen extends BaseInspectorPlugin {

        public function FullScreen(){
            super();
        }
        private function onFullScreen(event:FullScreenEvent):void{
            if (event.fullScreen){
                super.onActive();
            } else {
                super.onUnActive();
            };
        }
        override public function onRegister(inspector:IInspector):void{
            super.onRegister(inspector);
            _icon = new FullScreenButton();
        }
        override public function onUnRegister(inspector:IInspector):void{
            super.onUnRegister(inspector);
        }
        override public function onTurnOn():void{
            super.onTurnOn();
            if (_inspector.stage.displayState == StageDisplayState.FULL_SCREEN){
                this.onActive();
            };
            _inspector.stage.addEventListener(FullScreenEvent.FULL_SCREEN, this.onFullScreen);
        }
        override public function onTurnOff():void{
            super.onTurnOff();
            _inspector.stage.removeEventListener(FullScreenEvent.FULL_SCREEN, this.onFullScreen);
        }
        override public function onActive():void{
            super.onActive();
            if (_inspector.stage.displayState != StageDisplayState.FULL_SCREEN){
                _inspector.stage.displayState = StageDisplayState.FULL_SCREEN;
            };
        }
        override public function onUnActive():void{
            super.onUnActive();
            if (_inspector.stage.displayState == StageDisplayState.FULL_SCREEN){
                _inspector.stage.displayState = StageDisplayState.NORMAL;
            };
        }
        override public function getPluginId():String{
            return (InspectorPluginId.FULL_SCREEN);
        }

    }
}//package cn.itamt.utils.inspector.plugins.fullscreen 
