//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core {
    import flash.utils.*;
    import tInspector.itamt.utils.*;
    import flash.net.*;
    import flash.events.*;
    import flash.display.*;
    import flash.system.*;

    public class InspectorPluginManager extends EventDispatcher implements IInspectorPluginManager {

        private var _plugins:Dictionary;
        private var _pluginOrders:Array;
        private var _pluginList:XML;
        private var _inspector:IInspector;

        public function InspectorPluginManager(inspector:IInspector){
            super();
            this._inspector = inspector;
        }
        public function registerPlugin(plugin:IInspectorPlugin):void{
            var item:IInspectorPlugin;
            var t:String;
            if (this._plugins == null){
                this._plugins = new Dictionary();
            };
            if (plugin == null){
                throw (new Error("registerPlugin with a null plugin."));
            };
            var id:String = plugin.getPluginId();
            if (id == null){
                throw (new Error("registerPlugin:getPluginId() return null"));
            };
            if (this._pluginOrders == null){
                this._pluginOrders = [];
            };
            var i:int = this._pluginOrders.indexOf(id);
            if (i >= 0){
                this._pluginOrders.splice(i, 1);
            };
            this._pluginOrders.push(id);
            if (plugin != this._plugins[id]){
                plugin.onRegister(this._inspector);
                for (t in this._plugins) {
                    plugin.onRegisterPlugin(t);
                };
                this._plugins[id] = plugin;
            };
            for each (item in this._plugins) {
                item.onRegisterPlugin(id);
            };
        }
        public function unregisterPlugin(id:String):void{
            var item:IInspectorPlugin;
            if (this._plugins == null){
                this._plugins = new Dictionary();
            };
            var view:IInspectorPlugin = this._plugins[id];
            if (view != null){
                view.onUnRegister(this._inspector);
                for each (item in this._plugins) {
                    item.onUnRegisterPlugin(id);
                };
				delete this._plugins[id];
            };
        }
        public function activePlugin(id:String):void{
            var item:IInspectorPlugin;
            if (this._plugins == null){
                return;
            };
            var view:IInspectorPlugin = this._plugins[id];
            if (view){
                if (!(view.isActive)){
                    view.onActive();
                };
                if (this._inspector.getCurInspectTarget() != null){
                    if (!(this._inspector.isLiveInspecting)){
                        view.onInspect(this._inspector.getCurInspectTarget());
                    } else {
                        view.onLiveInspect(this._inspector.getCurInspectTarget());
                    };
                };
                for each (item in this._plugins) {
                    item.onActivePlugin(id);
                };
            } else {
                trace((id + "没有注册，不能开启。使用Inspector.registerView来注册功能，然后再调用Inspector.activePlugin"));
            };
        }
        public function unactivePlugin(id:String):void{
            var view:IInspectorPlugin;
            Debug.trace("[Inspector][unactiveView]");
            if (this._plugins[id] != null){
                (this._plugins[id] as IInspectorPlugin).onUnActive();
            };
            for each (view in this._plugins) {
                if (view.isActive){
                    view.onUnActivePlugin(id);
                };
            };
        }
        public function togglePluginById(id:String):void{
            var view:IInspectorPlugin = this._plugins[id];
            if (view.isActive){
                view.onUnActive();
            } else {
                view.onActive();
            };
        }
        public function getPluginById(viewId:String):IInspectorPlugin{
            if (this._plugins == null){
                return (null);
            };
            return (this._plugins[viewId]);
        }
        public function getPlugins():Array{
            var arr:Array = [];
            var ids:Array = this.getPluginIds();
            var i:int;
            while (i < ids.length) {
                arr.push(this.getPluginById(ids[i]));
                i++;
            };
            return (arr);
        }
        public function getPluginIds():Array{
            return (this._pluginOrders.slice());
        }
        public function loadPlugin(req:URLRequest):void{
            Debug.trace(("[InspectorPluginManager][loadPlugin]" + req.url));
            var loader:URLLoader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.BINARY;
            loader.load(req);
            loader.addEventListener(Event.COMPLETE, this.onPluginBytesLoad);
        }
        public function loadPluginList(req:URLRequest):void{
            Debug.trace(("[InspectorPluginManager][loadPlugin]" + req.url));
            var loader:URLLoader = new URLLoader();
            loader.load(req);
            loader.addEventListener(Event.COMPLETE, this.onPluginListLoad);
        }
        private function onPluginListLoad(event:Event):void{
            this._pluginList = new XML((event.target as URLLoader).data);
        }
        private function onPluginBytesLoad(event:Event):void{
            var loader:Loader = new Loader();
            loader.loadBytes((event.target as URLLoader).data, new LoaderContext(false, new ApplicationDomain(ApplicationDomain.currentDomain)));
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onPluginLoad);
        }
        private function onPluginLoad(evt:Event):void{
            var plugin:IInspectorPlugin;
            var loaderInfo:LoaderInfo = (evt.target as LoaderInfo);
            if ((loaderInfo.content is IInspectorPlugin)){
                plugin = (loaderInfo.content as IInspectorPlugin);
                this.registerPlugin(plugin);
            } else {
                Debug.trace((("[InspectorPluginManager][onPluginLoad]" + loaderInfo.url) + " is NOT an IInspectorPlugin."));
            };
        }

    }
}//package cn.itamt.utils.inspector.core 
