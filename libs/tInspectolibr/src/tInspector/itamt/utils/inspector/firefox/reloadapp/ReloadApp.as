//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.firefox.reloadapp {
    import flash.external.*;
    import tInspector.itamt.utils.inspector.firefox.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.core.*;
    import tInspector.itamt.utils.inspector.plugins.*;

    public class ReloadApp extends BaseInspectorPlugin {

        public function ReloadApp(){
            super();
        }
        private function onClickReload(event:MouseEvent):void{
            if (ExternalInterface.available){
                ExternalInterface.call("fInspectorReloadSwf", FlashPlayerEnvironment.swfId);
            };
        }
        override public function onRegister(inspector:IInspector):void{
            super.onRegister(inspector);
            _icon = new ReloadButton();
        }
        override public function onUnRegister(inspector:IInspector):void{
            super.onUnRegister(inspector);
        }
        override public function onTurnOn():void{
            super.onTurnOn();
            _icon.addEventListener(MouseEvent.CLICK, this.onClickReload);
        }
        override public function onTurnOff():void{
            _icon.removeEventListener(MouseEvent.CLICK, this.onClickReload);
            super.onTurnOff();
        }
        override public function getPluginId():String{
            return (InspectorPluginId.RELOAD_APP);
        }

    }
}//package cn.itamt.utils.inspector.firefox.reloadapp 
