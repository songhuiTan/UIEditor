//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core {
    import flash.display.*;
    import flash.events.*;
    
    import tInspector.itamt.utils.inspector.lang.*;
    import tInspector.itamt.utils.inspector.output.*;
    import tInspector.itamt.utils.inspector.ui.*;

	//silenxiao: add(extends EventDispatcher)
    public class BaseInspectorPlugin extends EventDispatcher implements IInspectorPlugin {

        protected var viewContainer:Sprite;
        protected var _inspector:IInspector;
        protected var target:InspectTarget;
        protected var _outputerManager:InspectorOutPuterManager;
        protected var _actived:Boolean;
        protected var _isOn:Boolean;
        protected var _icon:InspectorButton;

        public function BaseInspectorPlugin(){
            super();
        }
        public function get isActive():Boolean{
            return (this._actived);
        }
        public function set outputerManager(value:InspectorOutPuterManager):void{
            this._outputerManager = value;
        }
        public function get outputerManager():InspectorOutPuterManager{
            return (this._outputerManager);
        }
        public function contains(child:DisplayObject):Boolean{
            if (this.viewContainer){
                return ((((this.viewContainer == child)) || (this.viewContainer.contains(child))));
            };
            return (false);
        }
        public function onRegister(inspector:IInspector):void{
            var tg:InspectTarget;
            this._inspector = inspector;
            if (this._inspector.isOn){
                this.onTurnOn();
                tg = this._inspector.getCurInspectTarget();
                if (tg){
                    if (this._inspector.isLiveInspecting){
                        this.onLiveInspect(tg);
                    } else {
                        this.onInspect(tg);
                    };
                };
            };
        }
        public function onUnRegister(inspector:IInspector):void{
            this.onTurnOff();
            if (this._icon){
                this._icon = null;
            };
        }
        public function onRegisterPlugin(pluginId:String):void{
        }
        public function onUnRegisterPlugin(pluginId:String):void{
        }
        public function getPluginName(lang:String):String{
            return (InspectorLanguageManager.getStr(this.getPluginId()));
        }
        public function onActive():void{
            if (this._actived){
                return;
            };
            this._actived = true;
            if (this._icon){
                this._icon.active = true;
            };
        }
        public function onUnActive():void{
            this._actived = false;
            if (this._icon){
                this._icon.active = false;
            };
        }
        public function onTurnOn():void{
            if (this._isOn){
                return;
            };
            this._isOn = true;
            if (this._icon){
                this._icon.addEventListener(MouseEvent.CLICK, this.onClickPluginIcon);
            };
        }
        public function onTurnOff():void{
            this._isOn = false;
            if (this._icon){
                this._icon.removeEventListener(MouseEvent.CLICK, this.onClickPluginIcon);
            };
            if (this._actived){
                this.onUnActive();
            };
        }
        public function onInspect(target:InspectTarget):void{
        }
        public function onLiveInspect(target:InspectTarget):void{
        }
        public function onUpdate(target:InspectTarget=null):void{
        }
        public function onInspectMode(clazz:Class):void{
        }
        public function onActivePlugin(pluginId:String):void{
        }
        public function onUnActivePlugin(pluginId:String):void{
        }
        public function onStopLiveInspect():void{
        }
        public function onStartLiveInspect():void{
        }
        public function getPluginId():String{
            return (null);
        }
        public function getPluginVersion():String{
            return ("1.0");
        }
        public function getPluginIcon():DisplayObject{
            return (this._icon);
        }
        private function onClickPluginIcon(event:MouseEvent):void{
            if (!(this.isActive)){
                this._inspector.pluginManager.activePlugin(this.getPluginId());
            } else {
                this._inspector.pluginManager.unactivePlugin(this.getPluginId());
            };
        }

    }
}//package cn.itamt.utils.inspector.core 
