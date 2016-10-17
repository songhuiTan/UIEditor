//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils {
    import flash.display.*;
    import tInspector.itamt.utils.inspector.core.inspectfilter.*;
    import tInspector.itamt.utils.inspector.core.*;
    import tInspector.itamt.utils.inspector.core.liveinspect.*;
    import tInspector.itamt.utils.inspector.core.structureview.*;
    import tInspector.itamt.utils.inspector.core.propertyview.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.ui.*;
    import tInspector.itamt.utils.inspector.popup.*;
    import flash.geom.*;
    import flash.utils.*;
    import flash.system.*;

    public class Inspector extends EventDispatcher implements IInspector {

        public static const VERSION:String = "1.2";

        private static var _instance:Inspector;
        public static var APP_DOMAIN:ApplicationDomain;

        private var _root:DisplayObjectContainer;
        private var _stage:Stage;
        private var _filterManager:InspectorFilterManager;
        private var _pluginMgr:IInspectorPluginManager;
        private var _inspectView:LiveInspectView;
        private var _structureView:StructureView;
        private var _propertiesView:PropertiesView;
        private var _curInspectEle:InspectTarget;
        private var _inited:Boolean;
        private var _isOn:Boolean = false;
        private var _isLiveInspecting:Boolean = false;
        private var _tMap:Dictionary;

        public function Inspector(sf:SingletonEnforcer){
            super();
            if (sf == null){
                throw (new Error("use Inspector.getInstance() to play."));
            };
            this._inspectView = new LiveInspectView();
            this._structureView = new StructureView();
            this._propertiesView = new PropertiesView();
            this._filterManager = new InspectorFilterManager();
            this._pluginMgr = new InspectorPluginManager(this);
        }
        public static function getInstance():Inspector{
            if (_instance == null){
                _instance = new Inspector(new SingletonEnforcer());
            };
            return (_instance);
        }

        public function get root():DisplayObjectContainer{
            return (this._root);
        }
        public function get stage():Stage{
            return (this._stage);
        }
        public function get filterManager():InspectorFilterManager{
            return (this._filterManager);
        }
        public function get pluginManager():IInspectorPluginManager{
            return (this._pluginMgr);
        }
        public function get liveInspectView():LiveInspectView{
            return (this._inspectView);
        }
        public function get structureView():StructureView{
            return (this._structureView);
        }
        public function getCurInspectTarget():InspectTarget{
            return (this._curInspectEle);
        }
        public function init(root:DisplayObjectContainer):void{
            var root:* = root;
            if (this._inited){
                return;
            };
            this._inited = true;
            this._root = root;
            this._stage = root.stage;
            if (this._stage == null){
                throw (new Error("Set inspector's stage before you call inspector.init(); "));
            };
            this._root.addEventListener("allComplete", function (evt:Event):void{
            });
            InspectorStageReference.referenceTo(this._stage);
            this.pluginManager.registerPlugin(this._structureView);
            this.pluginManager.registerPlugin(this._propertiesView);
            this.pluginManager.registerPlugin(this._inspectView);
            this.pluginManager.registerPlugin(this._filterManager);
        }
        public function turnOn(... _args):void{
            var plugin:IInspectorPlugin;
            var i:int;
            if (this._isOn){
                return;
            };
            this._isOn = true;
            this._curInspectEle = null;
            InspectorTipsManager.init();
            InspectorPopupManager.init();
            var plugins:Array = this.pluginManager.getPlugins();
            for each (plugin in plugins) {
                plugin.onTurnOn();
            };
            i = 0;
            while (i < _args.length) {
                this.pluginManager.activePlugin(String(_args[i]));
                i++;
            };
        }
        public function turnOff():void{
            var view:IInspectorPlugin;
            this.stopLiveInspect();
            InspectorTipsManager.dispose();
            InspectorPopupManager.dispose();
            if (!(this._isOn)){
                return;
            };
            this._isOn = false;
            this._curInspectEle = null;
            var plugins:Array = this.pluginManager.getPlugins();
            for each (view in plugins) {
                view.onTurnOff();
            };
        }
        public function toggleTurn():void{
            if (this._isOn){
                this.turnOff();
            } else {
                this.turnOn();
            };
        }
        public function get isOn():Boolean{
            return (this._isOn);
        }
        public function get isLiveInspecting():Boolean{
            return (this._isLiveInspecting);
        }
        public function startLiveInspect():void{
            var plugins:Array;
            var view:IInspectorPlugin;
            if (!(this._isLiveInspecting)){
                this._curInspectEle = null;
                this._isLiveInspecting = true;
                this.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.enterFrameHandler);
                plugins = this.pluginManager.getPlugins();
                for each (view in plugins) {
                    if (view.isActive){
                        view.onStartLiveInspect();
                    };
                };
            };
        }
        public function stopLiveInspect():void{
            var view:IInspectorPlugin;
            this._isLiveInspecting = false;
            this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.enterFrameHandler);
            var plugins:Array = this.pluginManager.getPlugins();
            for each (view in plugins) {
                if (view.isActive){
                    view.onStopLiveInspect();
                };
            };
        }
        private function enterFrameHandler(evt:Event=null):void{
            var target:DisplayObject;
            var mousePos:Point = new Point(this.stage.mouseX, this.stage.mouseY);
            var objs:Array = this.stage.getObjectsUnderPoint(mousePos);
            var l:int = objs.length;
            if (l){
                while (l--) {
                    target = objs[l];
                    if (this.isInspectView(target)){
                        if (this.liveInspectView.contains(target)){
                            continue;
                        };
                        return;
                    };
                    while (target) {
                        if (this._filterManager.checkInFilter(target)){
                            this.liveInspect(target, false);
                            return;
                        };
                        if (((target.parent) && (!((target.parent == this.stage))))){
                            target = target.parent;
                        } else {
                            break;
                        };
                    };
                };
            };
        }
        public function isInspectView(target:DisplayObject):Boolean{
            var view:IInspectorPlugin;
            var plugins:Array = this.pluginManager.getPlugins();
            for each (view in plugins) {
                if (view.contains(target)){
                    return (true);
                };
            };
            return (false);
        }
        public function liveInspect(ele:DisplayObject, checkIsInspectorView:Boolean=true):void{
            var view:IInspectorPlugin;
            if (((this._curInspectEle) && ((this._curInspectEle.displayObject == ele)))){
                return;
            };
            if (checkIsInspectorView){
                if (this.isInspectView(ele)){
                    return;
                };
            };
            this._curInspectEle = this.getInspectTarget(ele);
            var plugins:Array = this.pluginManager.getPlugins();
            for each (view in plugins) {
                if (view.isActive){
                    view.onLiveInspect(this._curInspectEle);
                };
            };
        }
        public function inspect(ele:DisplayObject):void{
            var view:IInspectorPlugin;
            if (this.isInspectView(ele)){
                return;
            };
            this.stopLiveInspect();
            this._curInspectEle = this.getInspectTarget(ele);
            var plugins:Array = this.pluginManager.getPlugins();
            for each (view in plugins) {
                if (view.isActive){
                    view.onInspect(this._curInspectEle);
                };
            };
        }
        public function updateInsectorView():void{
            var plugins:Array;
            var view:IInspectorPlugin;
            if (this._curInspectEle != null){
                plugins = this.pluginManager.getPlugins();
                for each (view in plugins) {
                    if (view.isActive){
                        view.onUpdate(this._curInspectEle);
                    };
                };
            };
        }
        private function getInspectTarget(target:DisplayObject):InspectTarget{
            if (this._tMap == null){
                this._tMap = new Dictionary();
            };
            if (this._tMap[target] == null){
                this._tMap[target] = new InspectTarget(target);
            };
            return (this._tMap[target]);
        }

    }
}//package cn.itamt.utils 

class SingletonEnforcer {

    public function SingletonEnforcer(){
    }
}
