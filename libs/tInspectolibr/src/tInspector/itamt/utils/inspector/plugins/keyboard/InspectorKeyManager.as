//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.keyboard {
    import tInspector.itamt.keyboard.*;
    import flash.utils.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.core.*;
    import tInspector.itamt.utils.inspector.plugins.*;

    public class InspectorKeyManager extends BaseInspectorPlugin {

        private var _keyViewMap:Dictionary;
        private var _keyFunMap:Dictionary;
        private var _stMgr:ShortcutManager;

        public function InspectorKeyManager():void{
            super();
            this._stMgr = new ShortcutManager();
            this._stMgr.addEventListener(ShortcutEvent.DOWN, this.onShortcutDown);
        }
        public function bindKey2View(keys:Array, viewID:String=null):void{
            if (this._keyViewMap == null){
                this._keyViewMap = new Dictionary(true);
            };
            var shortcut:Shortcut = this._stMgr.checkShortcutExist(keys);
            if (shortcut == null){
                shortcut = new Shortcut(keys);
                this._stMgr.registerShortcut(shortcut);
            };
            this._keyViewMap[shortcut] = viewID;
        }
        public function unbindKey2View(keys:Array=null, viewID:String=null):void{
            var shortcut:Shortcut;
            var i:*;
            if ((((keys == null)) && ((viewID == null)))){
                throw (new ArgumentError("keys, view两个参数不能同时为空."));
            };
            if (keys){
                shortcut = this._stMgr.checkShortcutExist(keys);
                if (shortcut){
                    this._keyViewMap[shortcut] = null;
//                    ɾ  �� this._keyViewMap[shortcut];
                };
            } else {
                if (viewID){
                    for (i in this._keyViewMap) {
                        if (this._keyViewMap[i] == viewID){
                            this._keyViewMap[i] = null;
//                            ɾ  �� this._keyViewMap[shortcut];
                            break;
                        };
                    };
                };
            };
        }
        public function bindKey2Fun(keys:Array, fun:Function):void{
            if (this._keyFunMap == null){
                this._keyFunMap = new Dictionary(true);
            };
            var shortcut:Shortcut = this._stMgr.checkShortcutExist(keys);
            if (shortcut == null){
                shortcut = new Shortcut(keys);
                this._stMgr.registerShortcut(shortcut);
            };
            this._keyFunMap[shortcut] = fun;
        }
        public function unbindKey2Fun(keys:Array=null, fun:Function=null):void{
            var shortcut:Shortcut;
            var i:*;
            if ((((keys == null)) && ((fun == null)))){
                throw (new ArgumentError("keys, fun两个参数不能同时为空."));
            };
            if (keys){
                shortcut = this._stMgr.checkShortcutExist(keys);
                if (shortcut){
                    this._keyFunMap[shortcut] = null;
//                    ɾ  �� this._keyFunMap[shortcut];
                };
            } else {
                if (fun != null){
                    for (i in this._keyFunMap) {
                        if (this._keyFunMap[i] == fun){
                            this._keyFunMap[i] = null;
//                            ɾ  �� this._keyFunMap[shortcut];
                            break;
                        };
                    };
                };
            };
        }
        private function onShortcutDown(evt:ShortcutEvent):void{
            var viewID:String = this._keyViewMap[evt.shortcut];
            if (viewID){
                this._inspector.pluginManager.togglePluginById(viewID);
            };
            var fun:Function = this._keyFunMap[evt.shortcut];
            if (fun != null){
                fun.call();
            };
        }
        override public function contains(child:DisplayObject):Boolean{
            return (false);
        }
        override public function onRegister(inspector:IInspector):void{
            super.onRegister(inspector);
            this._stMgr.setStage(_inspector.stage);
            this.bindKey2Fun([17, 73], _inspector.toggleTurn);
        }
        override public function onActive():void{
            super.onActive();
            this.bindKey2View([17, 83], InspectorPluginId.STRUCT_VIEW);
            this.bindKey2View([17, 84], InspectorPluginId.LIVE_VIEW);
            this.bindKey2View([17, 80], InspectorPluginId.PROPER_VIEW);
            this.bindKey2View([17, 77], InspectorPluginId.FILTER_VIEW);
        }
        override public function onUnActive():void{
            super.onUnActive();
            this.unbindKey2View([17, 83], InspectorPluginId.STRUCT_VIEW);
            this.unbindKey2View([17, 84], InspectorPluginId.LIVE_VIEW);
            this.unbindKey2View([17, 80], InspectorPluginId.PROPER_VIEW);
            this.unbindKey2View([17, 77], InspectorPluginId.FILTER_VIEW);
        }
        override public function onTurnOn():void{
            super.onTurnOn();
            this.bindKey2View([17, 83], InspectorPluginId.STRUCT_VIEW);
            this.bindKey2View([17, 84], InspectorPluginId.LIVE_VIEW);
            this.bindKey2View([17, 80], InspectorPluginId.PROPER_VIEW);
            this.bindKey2View([17, 77], InspectorPluginId.FILTER_VIEW);
        }
        override public function onTurnOff():void{
            super.onTurnOff();
            this.unbindKey2View([17, 83], InspectorPluginId.STRUCT_VIEW);
            this.unbindKey2View([17, 84], InspectorPluginId.LIVE_VIEW);
            this.unbindKey2View([17, 80], InspectorPluginId.PROPER_VIEW);
            this.unbindKey2View([17, 77], InspectorPluginId.FILTER_VIEW);
        }
        override public function getPluginId():String{
            return (InspectorPluginId.SHORT_CUT);
        }

    }
}//package cn.itamt.utils.inspector.plugins.keyboard 
