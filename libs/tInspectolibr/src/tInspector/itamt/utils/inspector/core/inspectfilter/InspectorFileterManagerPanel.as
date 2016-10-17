//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.inspectfilter {
    import flash.display.*;
    import tInspector.itamt.utils.inspector.lang.*;
    import tInspector.itamt.utils.inspector.events.*;
    import tInspector.itamt.utils.inspector.ui.*;
    import tInspector.msc.events.*;
    import flash.utils.*;
    import tInspector.itamt.utils.*;
    import flash.events.*;

    public class InspectorFileterManagerPanel extends InspectorViewPanel {

        private var _listContainer:Sprite;
        private var _data:Array;
        private var _itemRenderer:Class;
        private var _activing:Dictionary;
        private var _all:InspectorFilterItemRenderer;
        private var _search:InspectSearchBar;
        private var litem:InspectorFilterItemRenderer;

        public function InspectorFileterManagerPanel(title:String="设定查看类型", w:Number=260, h:Number=200, autoDisposeWhenRemove:Boolean=true){
            this._itemRenderer = InspectorFilterItemRenderer;
            super(title, w, h, autoDisposeWhenRemove);
            _padding.left = (_padding.right = 15);
            _padding.bottom = 40;
            this._listContainer = new Sprite();
            this.setContent(this._listContainer);
            this._all = new InspectorFilterItemRenderer();
            this._all.data = DisplayObject;
            this._all.color = 16737894;
            this._all.label = InspectorLanguageManager.getStr("FilterAllDisplayObject");
            this._all.addEventListener(InspectorFilterEvent.APPLY, this.onToggleAll);
            this._all.addEventListener(InspectorFilterEvent.KILL, this.onToggleAll);
            this.disableAllToggler();
            this._search = new InspectSearchBar();
            this._search.addEventListener(mTextEvent.ENTER, this.onSearch);
            this._search.addEventListener(mTextEvent.SELECT, this.onSearch);
            addChild(this._search);
            this._activing = new Dictionary();
        }
        override public function relayout():void{
            super.relayout();
            this._all.x = ((_width - this._padding.right) - this._all.width);
            this._all.y = ((_height - this._all.height) - 7);
            if (this._search.stage){
                this._search.x = _padding.left;
                this._search.y = (_height - 26);
                this._search.setSize(((((_width - this._padding.right) - this._padding.left) - this._all.width) - 10));
            };
        }
        override public function open():void{
            super.open();
            this._search.visible = (this._all.visible = true);
        }
        override public function hide():void{
            super.hide();
            this._search.visible = (this._all.visible = false);
        }
        public function setFilterList(arr:Array):void{
            var filter:Class;
            this._data = arr;
            this._data.sort(this.compareFilter);
            for each (filter in this._data) {
                this._search.addToDictionary(ClassTool.getShortClassName(filter));
            };
            this.drawContent();
        }
        public function setActivedList(arr:Array):void{
            var filter:Class;
            var tfilter:Class;
            if (arr != null){
                for each (filter in arr) {
                    this.activeFilterItem(filter);
                };
            } else {
                for each (tfilter in this._data) {
                    this.inactiveFilterItem(tfilter);
                };
            };
        }
        public function addFilterItem(filter:Class):void{
            if (this._data == null){
                this._data = [];
            };
            if (this._data.indexOf(filter) < 0){
                this._data.push(filter);
                this._data.sort(this.compareFilter);
                this._search.addToDictionary(ClassTool.getShortClassName(filter));
            };
            this.drawContent();
        }
        public function activeFilterItem(filter:Class):void{
            this._activing[filter] = true;
            var item:InspectorFilterItemRenderer = this.findFilterItem(filter);
            if (item != null){
                item.enable = true;
            };
        }
        public function inactiveFilterItem(filter:Class):void{
            this._activing[filter] = false;
            var item:InspectorFilterItemRenderer = this.findFilterItem(filter);
            if (item != null){
                item.enable = false;
            };
        }
        private function compareFilter(a:Class, b:Class):int{
            var aName:String = ClassTool.getShortClassName(a);
            var bName:String = ClassTool.getShortClassName(b);
            if (aName > bName){
                return (1);
            };
            if (aName < bName){
                return (-1);
            };
            return (0);
        }
        private function findFilterItem(filter:Class):InspectorFilterItemRenderer{
            var item:InspectorFilterItemRenderer;
            if (filter == DisplayObject){
                return (this._all);
            };
            var i:int = this._listContainer.numChildren;
            while (i--) {
                item = (this._listContainer.getChildAt(i) as InspectorFilterItemRenderer);
                if (item.data == filter){
                    return (item);
                };
            };
            return (null);
        }
        private function drawContent():void{
            var render:InspectorFilterItemRenderer;
            this._listContainer.graphics.clear();
            this._listContainer.graphics.lineTo(0, 0);
            while (this._listContainer.numChildren) {
                ObjectPool.disposeObject(this._listContainer.removeChildAt(0), this._itemRenderer);
            };
            var l:int = ((this._data)==null) ? 0 : this._data.length;
            var i:int;
            while (i < l) {
                if (this._data[i] != DisplayObject){
                    render = ObjectPool.getObject(InspectorFilterItemRenderer);
                    render.x = 0;
                    render.y = (this._listContainer.height + 2);
                    render.data = this._data[i];
                    this._listContainer.addChild(render);
                } else {
                    this.enableAllToggler();
                    render = this._all;
                };
                render.enable = Boolean(this._activing[this._data[i]]);
                i++;
            };
            this.relayout();
        }
        private function enableAllToggler():void{
            this.addChild(this._all);
        }
        private function disableAllToggler():void{
            if (this._all.parent){
                this._all.parent.removeChild(this._all);
            };
        }
        private function onToggleAll(evt:InspectorFilterEvent):void{
            if (evt.type == InspectorFilterEvent.APPLY){
                _contentContainer.alpha = 0.5;
                _contentContainer.mouseChildren = (_contentContainer.mouseEnabled = false);
            } else {
                if (evt.type == InspectorFilterEvent.KILL){
                    _contentContainer.alpha = 1;
                    _contentContainer.mouseChildren = (_contentContainer.mouseEnabled = true);
                };
            };
        }
        private function onSearch(evt:mTextEvent):void{
            var item:InspectorFilterItemRenderer;
            if (this.litem != null){
                this.litem.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
            };
            var i:int = this._listContainer.numChildren;
            while (i--) {
                item = (this._listContainer.getChildAt(i) as InspectorFilterItemRenderer);
                if (ClassTool.getShortClassName(item.data) == evt.text){
                    this.litem = item;
                    break;
                };
            };
            if (evt.type == mTextEvent.ENTER){
                item.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            } else {
                if (evt.type == mTextEvent.SELECT){
                    item.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
                    this.showContentArea(item.getBounds(item.parent), 0);
                };
            };
        }

    }
}//package cn.itamt.utils.inspector.core.inspectfilter 
