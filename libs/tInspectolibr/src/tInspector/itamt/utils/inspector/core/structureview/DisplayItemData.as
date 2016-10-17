//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.structureview {
    import flash.display.*;
    import tInspector.itamt.utils.inspector.events.*;
    import flash.events.*;

    public class DisplayItemData extends EventDispatcher {

        public var displayObject:DisplayObject;
        public var hasChildren:Boolean = false;
        public var isExpand:Boolean;
        public var isOnInspect:Boolean;
        public var isOnLiveInspect:Boolean;

        public function DisplayItemData(object:DisplayObject, isExpand:Boolean=false){
            super();
            this.displayObject = object;
            if ((this.displayObject is DisplayObjectContainer)){
                if ((this.displayObject as DisplayObjectContainer).numChildren){
                    this.hasChildren = true;
                    this.isExpand = isExpand;
                };
            };
        }
        public function toggleExpand():void{
            if (this.isExpand){
                this.collapseChilds();
            } else {
                this.expandChilds();
            };
        }
        public function expandChilds():void{
            this.isExpand = true;
            this.dispatchEvent(new DisplayItemEvent(DisplayItemEvent.EXPAND));
            this.dispatchEvent(new DisplayItemEvent(DisplayItemEvent.CHANGE));
        }
        public function collapseChilds():void{
            this.isExpand = false;
            this.dispatchEvent(new DisplayItemEvent(DisplayItemEvent.COLLAPSE));
            this.dispatchEvent(new DisplayItemEvent(DisplayItemEvent.CHANGE));
        }
        public function onInspect(val:Boolean):void{
            this.isOnInspect = val;
            this.dispatchEvent(new DisplayItemEvent(DisplayItemEvent.CHANGE));
        }
        public function onLiveInspect(val:Boolean):void{
            this.isOnLiveInspect = val;
            this.dispatchEvent(new DisplayItemEvent(DisplayItemEvent.CHANGE));
        }

    }
}//package cn.itamt.utils.inspector.core.structureview 
