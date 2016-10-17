//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.controlbar {
    import flash.events.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.popup.*;
    import tInspector.itamt.utils.inspector.ui.*;
    import tInspector.itamt.utils.inspector.core.*;
    import tInspector.itamt.utils.inspector.lang.*;

    public class ControlBar extends Sprite implements IInspectorPlugin {

        private var _onOffBtn:InspectorOnOffButton;
        private var _inspector:IInspector;
        private var _active:Boolean;
        private var _id:String = "ControlBar";

        public function ControlBar(){
            super();
        }
        private function onClickBtn(evt:MouseEvent):void{
            switch (evt.target){
                case this._onOffBtn:
                    if (this._inspector.isOn){
                        this._inspector.turnOff();
                    } else {
                        this._inspector.turnOn();
                        if (!(this._active)){
                            this._inspector.pluginManager.activePlugin(this.getPluginId());
                        };
                    };
                    break;
            };
        }
        private function keepTopest(event:Event):void{
            if (this.parent){
                if (this.parent.getChildIndex(this) != (this.parent.numChildren - 1)){
                    this.parent.setChildIndex(this, (this.parent.numChildren - 1));
                };
            };
        }
        public function getPluginId():String{
            return (this._id);
        }
        public function getPluginIcon():DisplayObject{
            return (null);
        }
        public function getPluginVersion():String{
            return ("1.0");
        }
        public function getPluginName(lang:String):String{
            if (lang == "cn"){
                return ("操作栏");
            };
            return ("tInspector control bar");
        }
        override public function contains(child:DisplayObject):Boolean{
            return ((((this == child)) || (super.contains(child))));
        }
        public function onRegister(inspector:IInspector):void{
            this._inspector = inspector;
            this.addChild((this._onOffBtn = new InspectorOnOffButton()));
            this.addEventListener(MouseEvent.CLICK, this.onClickBtn);
            InspectorPopupManager.popup(this, PopupAlignMode.TL);
            InspectorStageReference.addEventListener(Event.ENTER_FRAME, this.keepTopest);
        }
        public function onUnRegister(inspector:IInspector):void{
            this.removeEventListener(MouseEvent.CLICK, this.onClickBtn);
            InspectorPopupManager.remove(this);
        }
        public function onRegisterPlugin(pluginId:String):void{
        }
        public function onUnRegisterPlugin(pluginId:String):void{
        }
        public function onActive():void{
            this._active = true;
        }
        public function onUnActive():void{
            this._active = false;
        }
        public function onTurnOn():void{
            var plugin:IInspectorPlugin;
            var icon:DisplayObject;
            var arr:Array = this._inspector.pluginManager.getPlugins();
            var i:int;
            while (i < arr.length) {
                plugin = (arr[i] as IInspectorPlugin);
                icon = plugin.getPluginIcon();
                if ((icon is InspectorButton)){
                    (icon as InspectorButton).tip = plugin.getPluginName(InspectorLanguageManager.getLanguage());
                };
                this.addChild(arr[i].getPluginIcon());
                i++;
            };
        }
        public function onTurnOff():void{
            var plugin:IInspectorPlugin;
            var arr:Array = this._inspector.pluginManager.getPlugins();
            for each (plugin in arr) {
                this.removeChild(plugin.getPluginIcon());
            };
        }
        public function onInspect(target:InspectTarget):void{
        }
        public function onLiveInspect(target:InspectTarget):void{
        }
        public function onStopLiveInspect():void{
        }
        public function onStartLiveInspect():void{
        }
        public function onUpdate(target:InspectTarget=null):void{
        }
        public function onInspectMode(clazz:Class):void{
        }
        public function onActivePlugin(pluginId:String):void{
            var btn:InspectorButton = (this._inspector.pluginManager.getPluginById(pluginId) as InspectorButton);
            if (btn){
                btn.active = true;
            };
        }
        public function onUnActivePlugin(pluginId:String):void{
            var btn:InspectorButton = (this._inspector.pluginManager.getPluginById(pluginId) as InspectorButton);
            if (btn){
                btn.active = false;
            };
        }
        public function get isActive():Boolean{
            return (this._active);
        }
        override public function addChild(child:DisplayObject):DisplayObject{
            if (((!((child == null))) && (!(this.contains(child))))){
                if (numChildren > 0){
                    child.x = (getChildAt((numChildren - 1)).x + getChildAt((numChildren - 1)).width);
                };
                this.graphics.clear();
                this.graphics.beginFill(0, 0.5);
                this.graphics.drawRoundRectComplex(0, 0, (child.x + child.width), child.height, 0, 0, 6, 6);
                this.graphics.endFill();
                return (super.addChild(child));
            };
            return (null);
        }
        override public function removeChild(child:DisplayObject):DisplayObject{
            var t:int;
            var i:int;
            var last:DisplayObject;
            if (((!((child == null))) && (this.contains(child)))){
                t = this.getChildIndex(child);
                i = (t + 1);
                while (i < this.numChildren) {
                    this.getChildAt(t).x = (this.getChildAt(t).x - child.width);
                    i++;
                };
                super.removeChild(child);
                if (this.numChildren){
                    last = this.getChildAt((this.numChildren - 1));
                    this.graphics.clear();
                    this.graphics.beginFill(0, 0.5);
                    this.graphics.drawRoundRectComplex(0, 0, (last.x + last.width), last.height, 0, 0, 6, 6);
                    this.graphics.endFill();
                };
                return (child);
            };
            return (null);
        }

    }
}//package cn.itamt.utils.inspector.plugins.controlbar 
