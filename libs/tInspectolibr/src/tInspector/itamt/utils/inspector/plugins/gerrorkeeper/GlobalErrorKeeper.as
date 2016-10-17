//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.gerrorkeeper {
    import tInspector.itamt.utils.inspector.plugins.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.core.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.lang.*;
    import tInspector.itamt.utils.inspector.popup.*;
    import tInspector.itamt.utils.*;

    public class GlobalErrorKeeper extends BaseInspectorPlugin {

        protected var enabled:Boolean = false;
        protected var historyPanel:ErrorListPanel;
        protected var errorPanels:Array;
        protected var errorList:Array;
        protected var iconBtnContainer:Sprite;
        protected var historyBtn:GlobalErrorsHistoryButton;

        public function GlobalErrorKeeper(){
            super();
        }
        override public function getPluginId():String{
            return (InspectorPluginId.GLOBAL_ERROR_KEEPER);
        }
        override public function onRegister(inspector:IInspector):void{
            super.onRegister(inspector);
            _icon = new GlobalErrorKeeperButton();
            this.historyBtn = new GlobalErrorsHistoryButton();
            this.iconBtnContainer = new Sprite();
            this.iconBtnContainer.mouseEnabled = false;
            this.iconBtnContainer.addChild(_icon);
            this.historyBtn.x = _icon.width;
            this.iconBtnContainer.addChild(this.historyBtn);
        }
        override public function contains(child:DisplayObject):Boolean{
            var ep:ErrorInfoPanel;
            if (this.errorPanels){
                for each (ep in this.errorPanels) {
                    if ((((ep == child)) || (ep.contains(child)))){
                        return (true);
                    };
                };
            };
            if (this.historyPanel){
                return ((((this.historyPanel == child)) || (this.historyPanel.contains(child))));
            };
            return (false);
        }
        override public function onTurnOn():void{
            super.onTurnOn();
            if (this.enabled){
                _inspector.pluginManager.activePlugin(InspectorPluginId.GLOBAL_ERROR_KEEPER);
            };
            this.historyBtn.addEventListener(MouseEvent.CLICK, this.onClickHistoryBtn);
        }
        override public function onTurnOff():void{
            _isOn = false;
            this.historyBtn.removeEventListener(MouseEvent.CLICK, this.onClickHistoryBtn);
        }
        override public function onActive():void{
            var i:int;
            super.onActive();
            if (this._inspector.stage.loaderInfo.hasOwnProperty("uncaughtErrorEvents")){
                this.enabled = true;
                i = 0;
                while (i < this._inspector.stage.numChildren) {
                    this.watch(this._inspector.stage.getChildAt(i).loaderInfo);
                    i++;
                };
            } else {
                this.enabled = false;
                this.popupErrorDetail(new ErrorLog(InspectorLanguageManager.getStr("GEK_Unsupported")));
            };
        }
        override public function onUnActive():void{
            var i:int;
            if (this.historyPanel){
                if (this.historyPanel.stage){
                    this.historyPanel.parent.removeChild(this.historyPanel);
                };
                this.historyPanel.removeEventListener(Event.CLOSE, this.onClickClose);
                this.historyPanel.removeEventListener(MouseEvent.CLICK, this.onClickErrorItem);
                this.historyPanel.removeEventListener("clear", this.onClickClear);
                this.historyPanel = null;
            };
            if (this.enabled){
                i = 0;
                while (i < this._inspector.stage.numChildren) {
                    this.unwatch(this._inspector.stage.getChildAt(i).loaderInfo);
                    i++;
                };
            };
            this.enabled = false;
            super.onUnActive();
        }
        public function watch(loaderInfo:LoaderInfo):void{
            if (loaderInfo.hasOwnProperty("uncaughtErrorEvents")){
                IEventDispatcher(loaderInfo["uncaughtErrorEvents"]).addEventListener("uncaughtError", this.uncaughtErrorHandler);
            };
        }
        public function unwatch(loaderInfo:LoaderInfo):void{
            if (loaderInfo.hasOwnProperty("uncaughtErrorEvents")){
                IEventDispatcher(loaderInfo["uncaughtErrorEvents"]).removeEventListener("uncaughtError", this.uncaughtErrorHandler);
            };
        }
        public function popupHistoryPanel():void{
            this.historyPanel = new ErrorListPanel();
            this.historyPanel.setData(this.errorList);
            this.historyPanel.addEventListener(Event.CLOSE, this.onClickClose);
            this.historyPanel.addEventListener("clear", this.onClickClear);
            this.historyPanel.addEventListener(MouseEvent.CLICK, this.onClickErrorItem);
            InspectorPopupManager.popup(this.historyPanel, PopupAlignMode.CENTER);
        }
        public function hideHistoryPanel():void{
            if (this.historyPanel){
                InspectorPopupManager.remove(this.historyPanel);
                this.historyPanel.removeEventListener(Event.CLOSE, this.onClickClose);
                this.historyPanel.removeEventListener(MouseEvent.CLICK, this.onClickErrorItem);
                this.historyPanel.removeEventListener("clear", this.onClickClear);
                this.historyPanel.dispose();
                this.historyPanel = null;
            };
        }
        public function toggleHistoryPanel():void{
            Debug.trace(("[GlobalErrorKeeper][toggleHistoryPanel]" + InspectorPopupManager.contains(this.historyPanel)));
            if (InspectorPopupManager.contains(this.historyPanel)){
                this.hideHistoryPanel();
            } else {
                this.popupHistoryPanel();
            };
        }
        public function clearAllErrors():void{
            if (this.errorList){
                while (this.errorList.length) {
                    this.removeErrorLog(this.errorList[0]);
                };
            };
            Debug.trace(("[GlobalErrorKeeper][clearAllErrors]" + this.errorList.length));
        }
        public function removeErrorLog(errorLog:ErrorLog):void{
            if (this.errorList == null){
                return;
            };
            var t:int = this.errorList.indexOf(errorLog);
            if (t < 0){
                Debug.trace("[GlobalErrorKeeper][removeErrorLog]nono, i can not find it.");
                return;
            };
            this.errorList.splice(t, 1);
            Debug.trace(("[GlobalErrorKeeper][removeErrorLog]" + this.errorList.length));
            this.removePopupErrorDetail(errorLog);
            if (this.historyPanel){
                this.historyPanel.update();
            };
        }
        public function addErrorLog(errorLog:ErrorLog):void{
            if (this.errorList == null){
                this.errorList = [];
            };
            if (this.errorList.indexOf(errorLog) < 0){
                this.errorList.push(errorLog);
                if (this.historyPanel){
                    this.historyPanel.update();
                };
            };
            this.popupErrorDetail(errorLog);
        }
        override public function getPluginIcon():DisplayObject{
            return (this.iconBtnContainer);
        }
        private function onClickClose(evt:Event):void{
            var i:int;
            if ((evt.target is ErrorInfoPanel)){
                InspectorPopupManager.remove((evt.target as ErrorInfoPanel));
                if (this.errorPanels){
                    i = this.errorPanels.indexOf(evt.target);
                    this.errorPanels.splice(i, 1);
                };
                (evt.target as ErrorInfoPanel).removeEventListener(Event.CLOSE, this.onClickClose);
            } else {
                if (evt.target == this.historyPanel){
                    this.hideHistoryPanel();
                };
            };
        }
        private function uncaughtErrorHandler(evt:ErrorEvent):void{
            evt.preventDefault();
            var evtError:* = evt["error"];
            var errorLog:ErrorLog = new ErrorLog(evtError);
            this.addErrorLog(errorLog);
        }
        private function onClickErrorItem(event:MouseEvent):void{
            var item:ErrorLogItemRenderer;
            if ((event.target is ErrorLogItemRenderer)){
                item = (event.target as ErrorLogItemRenderer);
                this.popupErrorDetail((item.data as ErrorLog));
            };
        }
        private function popupErrorDetail(errorLog:ErrorLog):void{
            var panel:ErrorInfoPanel;
            var hasExist:Boolean;
            if (this.errorPanels == null){
                this.errorPanels = [];
            };
            for each (panel in this.errorPanels) {
                if (panel.errorLog == errorLog){
                    hasExist = true;
                    break;
                };
            };
            if (!(hasExist)){
                panel = new ErrorInfoPanel(errorLog, "错误");
                this.errorPanels.push(panel);
                panel.addEventListener(Event.CLOSE, this.onClickClose);
            };
            InspectorPopupManager.popup(panel, PopupAlignMode.CENTER);
        }
        private function removePopupErrorDetail(errorLog:ErrorLog):void{
            var panel:ErrorInfoPanel;
            if (this.errorPanels == null){
                return;
            };
            var i:int;
            while (i < this.errorPanels.length) {
                panel = this.errorPanels[i];
                if (panel.errorLog == errorLog){
                    this.errorPanels.splice(i, 1);
                    panel.removeEventListener(Event.CLOSE, this.onClickClose);
                    InspectorPopupManager.remove(panel);
                    break;
                };
                i++;
            };
        }
        private function onClickHistoryBtn(evt:MouseEvent):void{
            this.toggleHistoryPanel();
        }
        private function onClickClear(event:Event):void{
            this.clearAllErrors();
        }

    }
}//package cn.itamt.utils.inspector.plugins.gerrorkeeper 
