//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.firefox.download {
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    
    import tInspector.itamt.utils.inspector.core.*;
    import tInspector.itamt.utils.inspector.lang.*;
    import tInspector.itamt.utils.inspector.plugins.*;
    import tInspector.itamt.utils.inspector.popup.*;

    public class DownloadAll implements IInspectorPlugin {

        private var _actived:Boolean;
        private var _icon:DownloadAllButton;
        private var _inspector:IInspector;
        private var _panel:DownloadAllPanel;
        private var _loadeds:Array;
        private var _itemPanel:DownloadedStuffInfoPanel;

        public function DownloadAll(){
            super();
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
        }
        public function getPluginId():String{
            return (InspectorPluginId.DOWNLOAD_ALL);
        }
        public function getPluginIcon():DisplayObject{
            if (this._icon == null){
                this._icon = new DownloadAllButton();
            };
            return (this._icon);
        }
        public function getPluginVersion():String{
            return ("1.0");
        }
        public function getPluginName(lang:String):String{
            if (lang == "cn"){
                return ("资源下载");
            };
            return ("download stuff");
        }
        public function contains(child:DisplayObject):Boolean{
            if (((this._itemPanel) && (this._itemPanel.contains(child)))){
                return (true);
            };
            return (((this._panel) && (this._panel.contains(child))));
        }
        public function onRegister(inspector:IInspector):void{
            this._inspector = inspector;
            if (this._inspector.root){
                if (this._loadeds == null){
                    this._loadeds = new Array();
                    this._loadeds.push(new LoadedStuffInfo(this._inspector.root.loaderInfo.url, this._inspector.root.loaderInfo.contentType));
                };
                this._inspector.root.addEventListener("allComplete", this.allCompleteHandler);
            };
        }
        public function onUnRegister(inspector:IInspector):void{
            this._loadeds = null;
        }
        public function onRegisterPlugin(pluginId:String):void{
        }
        public function onUnRegisterPlugin(pluginId:String):void{
        }
        public function onActive():void{
            this._actived = true;
            this._icon.active = true;
            this._panel = new DownloadAllPanel(InspectorLanguageManager.getStr(InspectorPluginId.DOWNLOAD_ALL));
            this._panel.setData(this._loadeds);
            this._panel.addEventListener(Event.CLOSE, this.unactiveThisPlugin);
            this._panel.addEventListener("clear", this.onClickClear);
            this._panel.addEventListener(MouseEvent.CLICK, this.onClickLoadedItem);
            InspectorPopupManager.popup(this._panel, PopupAlignMode.CENTER);
        }
        public function onUnActive():void{
            this._actived = false;
            this._icon.active = false;
            this._panel.removeEventListener(Event.CLOSE, this.unactiveThisPlugin);
            this._panel.removeEventListener("clear", this.onClickClear);
            this._panel.removeEventListener(MouseEvent.CLICK, this.onClickLoadedItem);
            InspectorPopupManager.remove(this._panel);
            this._panel.dispose();
            this._panel = null;
            if (this._itemPanel){
                this.removeLoadedStuffInfoPanel();
            };
        }
        public function onTurnOn():void{
            if (this._icon){
                this._icon.addEventListener(MouseEvent.CLICK, this.toggleThisPlugin);
            };
        }
        public function onTurnOff():void{
            if (this._icon){
                this._icon.removeEventListener(MouseEvent.CLICK, this.toggleThisPlugin);
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
        }
        public function onUnActivePlugin(pluginId:String):void{
        }
        public function get isActive():Boolean{
            return (this._actived);
        }
        private function toggleThisPlugin(event:MouseEvent):void{
            if (this.isActive){
                this._inspector.pluginManager.unactivePlugin(this.getPluginId());
            } else {
                this._inspector.pluginManager.activePlugin(this.getPluginId());
            };
        }
        private function unactiveThisPlugin(event:Event):void{
            this._inspector.pluginManager.unactivePlugin(this.getPluginId());
        }
        private function onClickClear(event:Event):void{
            this._loadeds = null;
            if (this._panel){
                this._panel.update();
            };
        }
        private function allCompleteHandler(evt:Event):void{
            var stuff:LoadedStuffInfo;
            var loaderInfo:LoaderInfo = (evt.target as LoaderInfo);
            if (loaderInfo){
                if (loaderInfo.url){
                    for each (stuff in this._loadeds) {
                        if ((((stuff.url == loaderInfo.url)) && ((stuff.contentType == loaderInfo.contentType)))){
                            return;
                        };
                    };
                    this._loadeds.push(new LoadedStuffInfo(loaderInfo.url, loaderInfo.contentType));
                    if (this.isActive){
                        if (this._panel){
                            this._panel.update();
                        };
                    };
                };
            };
        }
        private function onClickLoadedItem(event:MouseEvent):void{
            var stuff:LoadedStuffInfo;
            if ((event.target is LoadedStuffItemRenderer)){
                stuff = ((event.target as LoadedStuffItemRenderer).data as LoadedStuffInfo);
                if (this._itemPanel){
                    this.removeLoadedStuffInfoPanel(stuff);
                };
                this.popupLoadedStuffInfoPanel(stuff);
            };
        }
        private function popupLoadedStuffInfoPanel(info:LoadedStuffInfo):void{
            this._itemPanel = new DownloadedStuffInfoPanel();
            this._itemPanel.onInspect(info);
            this._itemPanel.addEventListener(Event.CLOSE, this.onClickCloseItemPanel, false, 0, true);
            InspectorPopupManager.popup(this._itemPanel, PopupAlignMode.CENTER);
        }
        private function onClickCloseItemPanel(event:Event):void{
            this.removeLoadedStuffInfoPanel();
        }
        private function removeLoadedStuffInfoPanel(info:LoadedStuffInfo=null):void{
            InspectorPopupManager.remove(this._itemPanel);
            this._itemPanel.dispose();
            this._itemPanel = null;
        }
		
		public function dispatchEvent(event:Event):Boolean {
			return false;
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void{
		}
		
		public function hasEventListener(type:String):Boolean {
			return false;
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
		}
		public function willTrigger(type:String):Boolean{
			return false;
		}

    }
}//package cn.itamt.utils.inspector.firefox.download 
