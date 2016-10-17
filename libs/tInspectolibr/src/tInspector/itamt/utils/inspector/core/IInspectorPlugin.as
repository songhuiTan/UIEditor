//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core {
    import flash.display.*;
    import flash.events.IEventDispatcher;

	//silenxiao: add(extends IEventDispatcher)
    public interface IInspectorPlugin extends IEventDispatcher{

        function getPluginId():String;
        function getPluginIcon():DisplayObject;
        function getPluginVersion():String;
        function getPluginName(lang:String):String;
        function contains(child:DisplayObject):Boolean;
        function onRegister(inspector:IInspector):void;
        function onUnRegister(inspector:IInspector):void;
        function onRegisterPlugin(pluginId:String):void;
        function onUnRegisterPlugin(pluginId:String):void;
        function onActive():void;
        function onUnActive():void;
        function onTurnOn():void;
        function onTurnOff():void;
        function onInspect(target:InspectTarget):void;
        function onLiveInspect(target:InspectTarget):void;
        function onStopLiveInspect():void;
        function onStartLiveInspect():void;
        function onUpdate(target:InspectTarget=null):void;
        function onInspectMode(clazz:Class):void;
        function onActivePlugin(pluginId:String):void;
        function onUnActivePlugin(pluginId:String):void;
        function get isActive():Boolean;

    }
}//package cn.itamt.utils.inspector.core 
