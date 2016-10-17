//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.firefox {
    import flash.display.*;
    import flash.events.*;
    import flash.system.*;
    import tInspector.itamt.utils.inspector.plugins.controlbar.*;
    import tInspector.itamt.utils.inspector.events.*;
    import tInspector.itamt.utils.inspector.plugins.gerrorkeeper.*;
    import flash.external.*;
    import tInspector.msc.console.*;
    import tInspector.itamt.utils.*;
    import tInspector.itamt.utils.inspector.firefox.setting.*;
    import tInspector.itamt.utils.inspector.plugins.*;
    import tInspector.itamt.utils.inspector.plugins.stats.*;
    import tInspector.itamt.utils.inspector.firefox.reloadapp.*;
    import tInspector.itamt.utils.inspector.firefox.download.*;
    import tInspector.itamt.utils.inspector.plugins.fullscreen.*;
    import tInspector.itamt.utils.inspector.plugins.swfinfo.*;
    import flash.text.*;

    public class tInspectorPreloader extends Sprite implements mIConsoleDelegate {

        public static var mainStage:Stage;
        public static var mainRoot:DisplayObject;
        private static var engine:MovieClip = new MovieClip();

        private var controlBar:ControlBar;
        public var tf:TextField;
        private var tInspector:Inspector;
        private var gErrorKeeper:GlobalErrorKeeper;

        public function tInspectorPreloader(){
            super();
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
            this.controlBar = new ControlBar();
            this.controlBar.addEventListener(InspectEvent.RELOAD, this.onClickReload);
            this.gErrorKeeper = new GlobalErrorKeeper();
            this.gErrorKeeper.watch(this.loaderInfo);
            if (ExternalInterface.available){
                ExternalInterface.addCallback("connectController", this.connectController);
                ExternalInterface.addCallback("disconnectController", this.disconnectController);
                ExternalInterface.addCallback("setSwfId", this.setSwfId);
                ExternalInterface.addCallback("startInspector", this.startInspector);
                ExternalInterface.addCallback("stopInspector", this.stopInspector);
            };
            if (stage){
                this.init();
            } else {
                this.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
            };
        }
        public static function callLater(func:Function, args:Array=null, frame:int=1):void{
            var func:* = func;
            var args = args;
            var frame:int = frame;
            engine.addEventListener(Event.ENTER_FRAME, function (event:Event):void{
                if (--frame <= 0){
                    engine.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                    func.apply(null, args);
                };
            });
        }

        private function onAdded(evt:Event):void{
            this.removeEventListener(Event.ADDED_TO_STAGE, this.onAdded);
            this.init();
        }
        private function init():void{
            mainStage = stage;
            this.root.addEventListener("allComplete", this.allCompleteHandler);
            this.root.addEventListener("allComplete", this.watchGlobalError);
            mainStage.addEventListener(Event.ADDED_TO_STAGE, this.onSthAdded, true);
        }
        private function watchGlobalError(evt:Event):void{
            var loaderInfo:LoaderInfo = (evt.target as LoaderInfo);
            if (loaderInfo){
                if (loaderInfo.url){
                    if (loaderInfo.contentType == "application/x-shockwave-flash"){
                        this.gErrorKeeper.watch(loaderInfo);
                    };
                };
            };
        }
        private function onSthAdded(evt:Event):void{
            mainStage.removeEventListener(Event.ADDED_TO_STAGE, this.onSthAdded, true);
            this.log(("[tInspectorPreloader][onSthAdded]" + evt.target));
            if (mainRoot != (evt.target as DisplayObject).root){
                mainRoot = (evt.target as DisplayObject).root;
            };
            this.setupControlBar();
        }
        private function allCompleteHandler(evt:Event):void{
            this.log("[tInspectorPreloader][allCompleteHandler]");
            var loaderInfo:LoaderInfo = (evt.target as LoaderInfo);
            if (loaderInfo){
                if (loaderInfo.url){
                    if ((((((((loaderInfo.url.indexOf("tInspectorPreloader.swf") == -1)) && ((loaderInfo.url.indexOf("fInspectorSetting.swf") == -1)))) && ((loaderInfo.url.indexOf("tInspectorConsoleMonitor.swf") == -1)))) && ((loaderInfo.contentType == "application/x-shockwave-flash")))){
                        this.log(loaderInfo.url);
                        this.setupControlBar();
                        this.initInspector();
                        mainRoot.removeEventListener("allComplete", this.allCompleteHandler);
                    };
                };
            };
        }
        private function initInspector():void{
            var pluginName:String;
            var i:int;
            this.log("[tInspectorPreloader][initInspector]");
            mConsole.init(false);
            mConsole.addDelegate(this);
            if (!(ExternalInterface.available)){
                this.connectController();
            };
            this.tInspector = Inspector.getInstance();
            this.tInspector.init((this.controlBar.stage.getChildAt(0) as DisplayObjectContainer));
            var arr:Array = fInspectorConfig.getEnablePlugins();
            if (arr == null){
                arr = [InspectorPluginId.APPSTATS_VIEW, InspectorPluginId.FULL_SCREEN, InspectorPluginId.GLOBAL_ERROR_KEEPER, InspectorPluginId.RELOAD_APP, InspectorPluginId.DOWNLOAD_ALL, InspectorPluginId.SWFINFO_VIEW];
                for each (pluginName in arr) {
                    fInspectorConfig.setEnablePlugin(pluginName);
                };
                fInspectorConfig.save();
            };
            if (arr){
                i = 0;
                while (i < arr.length) {
                    switch (arr[i]){
                        case InspectorPluginId.APPSTATS_VIEW:
                            this.tInspector.pluginManager.registerPlugin(new AppStats());
                            break;
                        case InspectorPluginId.RELOAD_APP:
                            this.tInspector.pluginManager.registerPlugin(new ReloadApp());
                            break;
                        case InspectorPluginId.DOWNLOAD_ALL:
                            this.tInspector.pluginManager.registerPlugin(new DownloadAll());
                            break;
                        case InspectorPluginId.FULL_SCREEN:
                            this.tInspector.pluginManager.registerPlugin(new FullScreen());
                            break;
                        case InspectorPluginId.GLOBAL_ERROR_KEEPER:
                            this.tInspector.pluginManager.registerPlugin(this.gErrorKeeper);
                            if (this.loaderInfo.hasOwnProperty("uncaughtErrorEvents")){
                                this.tInspector.pluginManager.activePlugin(InspectorPluginId.GLOBAL_ERROR_KEEPER);
                            };
                            break;
                        case InspectorPluginId.SWFINFO_VIEW:
                            this.tInspector.pluginManager.registerPlugin(new SwfInfoView());
                            break;
                    };
                    i++;
                };
            };
        }
        private function setupControlBar():void{
            if (this.controlBar.stage == null){
                mainStage.addChild(this.controlBar);
            } else {
                this.controlBar.stage.addChild(this.controlBar);
            };
        }
        private function onClickReload(event:InspectEvent):void{
            Debug.trace(((("[tInspectorPreloader][onClickReload]ExternalInterface.available: " + ExternalInterface.available) + ", ") + FlashPlayerEnvironment.swfId));
            if (ExternalInterface.available){
                ExternalInterface.call("fInspectorReloadSwf", FlashPlayerEnvironment.swfId);
            };
        }
        public function connectController():void{
            Debug.trace("[tInspectorPreloader][connectController]");
            mConsole.connectMonitor();
        }
        public function disconnectController():void{
            Debug.trace("[tInspectorPreloader][disconnectController]");
            mConsole.disconnectMonitor();
        }
        public function setSwfId(swfId:String):void{
            Debug.trace(("[tInspectorPreloader][setSwfId]" + swfId));
            FlashPlayerEnvironment.swfId = swfId;
        }
        public function startInspector():void{
            this.log("[tInspectorPreloader][startInspector]");
            this.controlBar.visible = true;
        }
        public function stopInspector():void{
            this.log("[tInspectorPreloader][stopInspector]");
            this.controlBar.visible = false;
        }
        public function log(str:String):void{
            Debug.trace(str, 1);
        }
        public function dump(str:String):void{
            this.log(("[client-->monitor]" + str));
            if (ExternalInterface.available){
                ExternalInterface.call("alert", ("\n" + str));
            };
        }

    }
}//package cn.itamt.utils.inspector.firefox 
