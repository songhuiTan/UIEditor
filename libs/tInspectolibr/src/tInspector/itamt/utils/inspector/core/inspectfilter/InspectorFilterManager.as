//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.inspectfilter {
    import flash.display.*;
    import flash.utils.*;
    import tInspector.itamt.utils.*;
    import tInspector.itamt.utils.inspector.events.*;
    import tInspector.itamt.utils.inspector.plugins.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.core.*;
    import tInspector.itamt.utils.inspector.lang.*;
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.text.*;

    public class InspectorFilterManager extends BaseInspectorPlugin {

        private var _filtersDb:Dictionary;
        private var _activeFilters:Array;
        private var _savedFilters:Array;
        private var _defaultFilter:Class;
        private var _view:InspectorFileterManagerPanel;

        public function InspectorFilterManager(){
            this._defaultFilter = DisplayObject;
            super();
            this._filtersDb = new Dictionary(true);
            this.applyFilter(this._defaultFilter);
        }
        public function applyFilter(filter:Class):void{
            var t:int;
            if (filter == this._defaultFilter){
                if (this._activeFilters != null){
                    this._savedFilters = this._activeFilters.slice();
                };
            } else {
                if (this._activeFilters != null){
                    t = this._activeFilters.indexOf(this._defaultFilter);
                    if (t >= 0){
                        this._activeFilters.splice(t, 1);
                        if (this._view != null){
                            this._view.inactiveFilterItem(this._defaultFilter);
                        };
                    };
                };
            };
            if (this._filtersDb[filter] == undefined){
                this._filtersDb[filter] = true;
                if (this._view){
                    this._view.addFilterItem(filter);
                };
            };
            if (this._activeFilters == null){
                this._activeFilters = [];
            };
            if (this._activeFilters.indexOf(filter) < 0){
                this._activeFilters.push(filter);
                if (this._view != null){
                    this._view.activeFilterItem(filter);
                };
                if (_inspector != null){
                    _inspector.updateInsectorView();
                };
            };
            this._activeFilters.sort(this.comapreClass);
        }
        public function killFilter(filter:Class):void{
            if (filter == this._defaultFilter){
                if (this._savedFilters != null){
                    this._activeFilters = this._savedFilters.slice();
                };
                if (this._view){
                    this._view.setActivedList(this._activeFilters);
                };
            };
            if (this._activeFilters == null){
                return;
            };
            var t:int = this._activeFilters.indexOf(filter);
            if (t >= 0){
                this._activeFilters.splice(t, 1);
                if (this._view){
                    this._view.inactiveFilterItem(filter);
                };
                if (_inspector != null){
                    _inspector.updateInsectorView();
                };
                this._activeFilters.sort(this.comapreClass);
            };
            if (this._activeFilters.length == 0){
                this._activeFilters = null;
            };
        }
        private function comapreClass(a:Class, b:Class):int{
            if (a == b){
                return (0);
            };
            var c:Class = b;
            while ((c = ClassTool.getParentClassOf(c))) {
                if (c == Object){
                    c = a;
                    while ((c = ClassTool.getParentClassOf(c))) {
                        if (c == Object){
                            return (0);
                        };
                        if (b == c){
                            return (-1);
                        };
                    };
                } else {
                    if (a == c){
                        return (1);
                    };
                };
            };
            return (0);
        }
        public function checkInFilter(target:DisplayObject):Boolean{
            if ((((this._activeFilters == null)) || ((this._activeFilters.length == 0)))){
                return (false);
            };
            var l:int = this._activeFilters.length;
            var i:int;
            while (i < l) {
                if ((target is this._activeFilters[i])){
                    return (true);
                };
                i++;
            };
            return (false);
        }
        public function isFilterActiving(filter:Class):Boolean{
            if (this._activeFilters == null){
                return (false);
            };
            return ((this._activeFilters.indexOf(filter) >= 0));
        }
        private function toChangeFilter(evt:InspectorFilterEvent):void{
            if (evt.type == InspectorFilterEvent.APPLY){
                this.applyFilter(evt.filter);
            } else {
                if (evt.type == InspectorFilterEvent.KILL){
                    this.killFilter(evt.filter);
                } else {
                    if (evt.type == InspectorFilterEvent.CHANGE){
                        if (this.isFilterActiving(evt.filter)){
                            this.killFilter(evt.filter);
                            if (this._activeFilters == null){
                                this.applyFilter(this._defaultFilter);
                            };
                        } else {
                            this.applyFilter(evt.filter);
                        };
                    };
                };
            };
        }
        private function onClickClose(evt:Event):void{
            this._inspector.pluginManager.unactivePlugin(InspectorPluginId.FILTER_VIEW);
        }
        override public function getPluginId():String{
            return (InspectorPluginId.FILTER_VIEW);
        }
        override public function onRegister(inspector:IInspector):void{
            super.onRegister(inspector);
            _icon = new FilterManagerButton();
        }
        override public function contains(child:DisplayObject):Boolean{
            if (this._view){
                return ((((this._view == child)) || (this._view.contains(child))));
            };
            return (false);
        }
        override public function onTurnOn():void{
            super.onTurnOn();
            _inspector.stage.addEventListener(InspectorFilterEvent.APPLY, this.toChangeFilter, false, 0, true);
            _inspector.stage.addEventListener(InspectorFilterEvent.KILL, this.toChangeFilter, false, 0, true);
            _inspector.stage.addEventListener(InspectorFilterEvent.CHANGE, this.toChangeFilter, false, 0, true);
            _inspector.stage.addEventListener(InspectorFilterEvent.RESTORE, this.toChangeFilter, false, 0, true);
        }
        override public function onTurnOff():void{
            super.onTurnOff();
            _inspector.stage.removeEventListener(InspectorFilterEvent.APPLY, this.toChangeFilter);
            _inspector.stage.removeEventListener(InspectorFilterEvent.KILL, this.toChangeFilter);
            _inspector.stage.removeEventListener(InspectorFilterEvent.CHANGE, this.toChangeFilter);
            _inspector.stage.removeEventListener(InspectorFilterEvent.RESTORE, this.toChangeFilter);
        }
        override public function onActive():void{
            var filter:*;
            super.onActive();
            this.buildFilterDataBase();
            var arr:Array = [];
            for (filter in this._filtersDb) {
                arr.push(filter);
            };
            this._view = new InspectorFileterManagerPanel(InspectorLanguageManager.getStr(InspectorPluginId.FILTER_VIEW));
            this._view.setFilterList(arr);
            this._view.setActivedList(this._activeFilters);
            this._view.addEventListener(Event.CLOSE, this.onClickClose);
            _inspector.stage.addChild(this._view);
            InspectorStageReference.centerOnStage(this._view);
        }
        private function buildFilterDataBase():void{
            var clazz:Class;
            var t:Array = [Sprite, Shape, SimpleButton, MovieClip, TextField];
            for each (clazz in t) {
                if (this._filtersDb[clazz] == undefined){
                    this._filtersDb[clazz] = true;
                };
            };
            DisplayObjectTool.everyDisplayObject(_inspector.stage, this.checkInDb);
        }
        private function checkInDb(dp:DisplayObject):void{
            if (_inspector.isInspectView(dp)){
                return;
            };
            if (this._filtersDb[(dp["constructor"] as Class)] == undefined){
                this._filtersDb[(dp["constructor"] as Class)] = true;
            };
        }
        override public function onUnActive():void{
            super.onUnActive();
            if (this._view != null){
                if (this._view.stage){
                    this._view.parent.removeChild(this._view);
                };
                this._view.removeEventListener(Event.CLOSE, this.onClickClose);
                this._view.dispose();
                this._view = null;
            };
        }

    }
}//package cn.itamt.utils.inspector.core.inspectfilter 
