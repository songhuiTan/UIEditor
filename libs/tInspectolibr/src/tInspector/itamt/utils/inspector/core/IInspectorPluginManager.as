//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core {
    import flash.net.*;

    public interface IInspectorPluginManager {

        function getPluginById(pluginId:String):IInspectorPlugin;
        function getPlugins():Array;
        function getPluginIds():Array;
        function togglePluginById(pluginId:String):void;
        function registerPlugin(plugin:IInspectorPlugin):void;
        function unregisterPlugin(pluginId:String):void;
        function activePlugin(pluginId:String):void;
        function unactivePlugin(pluginId:String):void;
        function loadPlugin(req:URLRequest):void;
        function loadPluginList(req:URLRequest):void;

    }
}//package cn.itamt.utils.inspector.core 
