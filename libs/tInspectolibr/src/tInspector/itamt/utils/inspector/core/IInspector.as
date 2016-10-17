//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core {
    import flash.display.*;

    public interface IInspector {

        function get isOn():Boolean;
        function get root():DisplayObjectContainer;
        function get stage():Stage;
        function turnOn(... _args):void;
        function turnOff():void;
        function getCurInspectTarget():InspectTarget;
        function get isLiveInspecting():Boolean;
        function toggleTurn():void;
        function startLiveInspect():void;
        function stopLiveInspect():void;
        function inspect(ele:DisplayObject):void;
        function liveInspect(ele:DisplayObject, checkIsInspectorView:Boolean=true):void;
        function updateInsectorView():void;
        function isInspectView(target:DisplayObject):Boolean;
        function get pluginManager():IInspectorPluginManager;

    }
}//package cn.itamt.utils.inspector.core 
