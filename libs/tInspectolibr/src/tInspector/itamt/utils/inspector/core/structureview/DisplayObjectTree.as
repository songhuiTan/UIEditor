//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.structureview {
    import flash.utils.*;
    import flash.display.*;
    import tInspector.itamt.utils.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.events.*;

    public class DisplayObjectTree extends Sprite {

        private var _root:DisplayObject;
        private var _data:Array;
        private var _map:Dictionary;
        private var _list:Sprite;
        private var _itemRenderer:Class;
        public var filterFun:Function;

        public function DisplayObjectTree(object:DisplayObject, itemRenderClass:Class=null){
            super();
            this._data = [];
            this._map = new Dictionary();
            if (itemRenderClass == null){
                this._itemRenderer = DisplayItemRenderer;
            } else {
                this._itemRenderer = itemRenderClass;
            };
            this._root = object;
            this._list = new Sprite();
            addChild(this._list);
            this.initTree();
//			this.buildTree(_root)
            this.drawList();
        }
        private function initTree():void{
            var container:DisplayObjectContainer;
            var i:int;
            var itemData:DisplayItemData = this.getDisplayItem(this._root);
            itemData.isExpand = true;
            this.addDisplayItem(itemData);
            if ((this._root is DisplayObjectContainer)){
                container = (this._root as DisplayObjectContainer);
                i = 0;
                while (i < container.numChildren) {
                    this.addDisplayItem(this.getDisplayItem(container.getChildAt(i)));
                    i++;
                };
            };
        }
        private function buildTree(object:DisplayObject):void{
            var container:DisplayObjectContainer;
            var i:int;
            this.addDisplayItem(this.getDisplayItem(object));
            if ((object is DisplayObjectContainer)){
                container = (object as DisplayObjectContainer);
                i = 0;
                while (i < container.numChildren) {
                    this.buildTree(container.getChildAt(i));
                    i++;
                };
            };
        }
        public function onInspect(object:DisplayObject):void{
            this.inspectDisplayItem(this.getDisplayItem(object));
            this.drawList();
        }
        private function inspectDisplayItem(item:DisplayItemData):void{
            var parent:DisplayItemData;
            var parentObject:DisplayObjectContainer = item.displayObject.parent;
            if ((((parentObject == null)) || ((item.displayObject == this._root)))){
                this.expandDisplayItem(item);
            } else {
                parent = this.getDisplayItem(parentObject);
                parent.isExpand = true;
                if (this.hasDisplayItem(parent)){
                    this.expandDisplayItem(parent);
                } else {
                    this.inspectDisplayItem(parent);
                };
            };
        }
        private function addDisplayItem(item:DisplayItemData):void{
            if ((((item.displayObject == this)) && (this.contains(item.displayObject)))){
                return;
            };
            if (this._data.indexOf(item) < 0){
                this._data.push(item);
            };
        }
        private function hasDisplayItem(item:DisplayItemData):Boolean{
            return ((this._data.indexOf(item) >= 0));
        }
        private function addDisplayItemAfter(item:DisplayItemData, afterItem:DisplayItemData):void{
            var t:int = this._data.indexOf(afterItem);
            if (t >= 0){
                this.addDisplayItemAt((t + 1), item);
            };
        }
        private function addDisplayItemAt(index:int, item:DisplayItemData):void{
            if ((((item.displayObject == this)) && (this.contains(item.displayObject)))){
                return;
            };
            if (this._data.indexOf(item) < 0){
                this._data.splice(index, 0, item);
            };
        }
        private function removeDisplayItem(item:DisplayItemData):void{
            var i:int = this._data.indexOf(item);
            if (i >= 0){
                this._data.splice(i, 1);
            };
        }
        public function drawList():void{
            var item:DisplayItemData;
            var render:BaseDisplayItemView;
            this._list.graphics.clear();
            this._list.graphics.lineTo(0, 0);
            while (this._list.numChildren) {
                ObjectPool.disposeObject(this._list.removeChildAt(0), this._itemRenderer);
            };
            var i:int;
            while (i < this._data.length) {
                item = this._data[i];
                if (item.displayObject.stage == null){
                } else {
//                    if (this.filterFun != null){
//                        //unresolved if
//                    } else {
                        render = ObjectPool.getObject(this._itemRenderer);
                        render.setData(item);
                        render.x = 0;
                        render.y = (this._list.height + 2);
                        this._list.addChild(render);
//                    };
                };
                i++;
            };
            dispatchEvent(new Event(Event.RESIZE));
        }
        public function getDisplayItem(object:DisplayObject):DisplayItemData{
            if (this._map[object] == null){
                this._map[object] = new DisplayItemData(object);
                (this._map[object] as DisplayItemData).addEventListener(DisplayItemEvent.EXPAND, this.onExpandCollapseItem);
                (this._map[object] as DisplayItemData).addEventListener(DisplayItemEvent.COLLAPSE, this.onExpandCollapseItem);
            };
            return (this._map[object]);
        }
        private function onExpandCollapseItem(evt:DisplayItemEvent):void{
            var item:DisplayItemData = (evt.target as DisplayItemData);
            switch (evt.type){
                case DisplayItemEvent.EXPAND:
                    this.expandDisplayItem(item);
                    break;
                case DisplayItemEvent.COLLAPSE:
                    this.collapseDisplayItem(item);
                    break;
            };
            this.drawList();
        }
        private function collapseDisplayItem(item:DisplayItemData):void{
            var container:DisplayObjectContainer;
            var i:int;
            if (item.hasChildren){
                if ((item.displayObject is DisplayObjectContainer)){
                    container = (item.displayObject as DisplayObjectContainer);
                    i = 0;
                    while (i < container.numChildren) {
                        this.removeItemAndChilds(this.getDisplayItem(container.getChildAt(i)));
                        i++;
                    };
                };
            };
        }
        private function removeItemAndChilds(item:DisplayItemData):void{
            var container:DisplayObjectContainer;
            var i:int;
            this.removeDisplayItem(item);
            if (item.hasChildren){
                container = (item.displayObject as DisplayObjectContainer);
                i = 0;
                while (i < container.numChildren) {
                    this.removeItemAndChilds(this.getDisplayItem(container.getChildAt(i)));
                    i++;
                };
            };
        }
        private function expandDisplayItem(item:DisplayItemData):void{
            var container:DisplayObjectContainer;
            var childItem:DisplayItemData;
            var i:int;
            if (item.hasChildren){
                if ((item.displayObject is DisplayObjectContainer)){
                    container = (item.displayObject as DisplayObjectContainer);
                    i = (container.numChildren - 1);
                    while (i >= 0) {
                        childItem = this.getDisplayItem(container.getChildAt(i));
                        this.addDisplayItemAfter(childItem, item);
                        if (((childItem.hasChildren) && (childItem.isExpand))){
                            this.expandDisplayItem(childItem);
                        };
                        i--;
                    };
                };
            };
        }
        public function getObjectRenderer(object:DisplayObject){
            var render:BaseDisplayItemView;
            var i:int = this._list.numChildren;
            while (i--) {
                render = (this._list.getChildAt(i) as BaseDisplayItemView);
                if (render.data.displayObject == object){
                    return ((render as this._itemRenderer));
                };
            };
            return (null);
        }

    }
}//package cn.itamt.utils.inspector.core.structureview 
