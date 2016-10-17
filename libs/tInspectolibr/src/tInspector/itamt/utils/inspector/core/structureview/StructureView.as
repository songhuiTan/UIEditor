//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.structureview {
    import tInspector.itamt.utils.inspector.output.*;
    import tInspector.itamt.utils.inspector.plugins.*;
    import tInspector.itamt.utils.inspector.core.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.events.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.popup.*;
    import tInspector.itamt.utils.*;

    public class StructureView extends BaseInspectorPlugin {

        private var treeView:DisplayObjectTree;
        private var panel:StructureViewPanel;
        private var liveTarget:InspectTarget;

        public function StructureView():void{
            super();
            this.outputerManager = new InspectorOutPuterManager(new StructureTreeItemInfoOutputer());
        }
        override public function set outputerManager(value:InspectorOutPuterManager):void{
            this._outputerManager = value;
            StructureElementView.outputerManager = this._outputerManager;
        }
        override public function getPluginId():String{
            return (InspectorPluginId.STRUCT_VIEW);
        }
        override public function onRegister(inspector:IInspector):void{
            super.onRegister(inspector);
            _icon = new StructureViewButton();
        }
        override public function contains(child:DisplayObject):Boolean{
            if (this.panel){
                return ((((this.panel == child)) || (this.panel.contains(child))));
            };
            return (false);
        }
        override public function onActive():void{
            super.onActive();
            this.panel = new StructureViewPanel(600, 600);
            this.treeView = new DisplayObjectTree(this._inspector.stage, StructureElementView);
            this.treeView.addEventListener(DisplayItemEvent.OVER, this.onOverElement, false, 0, true);
            this.treeView.addEventListener(DisplayItemEvent.CLICK, this.onClickElement, false, 0, true);
            this.panel.addEventListener(MouseEvent.ROLL_OUT, this.onRollOutPanel, false, 0, true);
            this.panel.addEventListener(Event.CLOSE, this.onClickClose, false, 0, true);
            this.panel.addEventListener(TextEvent.LINK, this.onClickLinkTarget);
            this.panel.addEventListener(InspectEvent.REFRESH, this.onRefresh, false, 0, true);
            this.treeView.filterFun = _inspector.isInspectView;
            this.panel.setContent(this.treeView);
            InspectorPopupManager.popup(this.panel, PopupAlignMode.CENTER);
        }
        override public function onUnActive():void{
            super.onUnActive();
            InspectorPopupManager.remove(this.panel);
            this.treeView.removeEventListener(DisplayItemEvent.OVER, this.onOverElement);
            this.treeView.removeEventListener(DisplayItemEvent.CLICK, this.onClickElement);
            this.panel.removeEventListener(MouseEvent.ROLL_OUT, this.onRollOutPanel);
            this.panel.removeEventListener(Event.CLOSE, this.onClickClose);
            this.panel.removeEventListener(TextEvent.LINK, this.onClickLinkTarget);
            this.panel.removeEventListener(InspectEvent.REFRESH, this.onRefresh);
            this.panel = null;
            this.treeView = null;
        }
        override public function onInspect($target:InspectTarget):void{
            var item:DisplayItemData;
            var view:StructureElementView;
            if (this.liveTarget){
                item = this.treeView.getDisplayItem(this.liveTarget.displayObject);
                item.onLiveInspect(false);
            };
            if (this.target){
                item = this.treeView.getDisplayItem(target.displayObject);
                item.onInspect(false);
            };
            this.target = $target;
            item = this.treeView.getDisplayItem(target.displayObject);
            item.onInspect(true);
            this.treeView.onInspect(target.displayObject);
            this.panel.onInspect(target.displayObject);
            view = this.treeView.getObjectRenderer(target.displayObject);
            if (view){
                this.panel.showContentArea(view.getBounds(view.parent), 0);
            };
        }
        override public function onLiveInspect($target:InspectTarget):void{
            var item:DisplayItemData;
            var view:StructureElementView;
            if ($target == this.liveTarget){
                return;
            };
            if (this.liveTarget){
                item = this.treeView.getDisplayItem(this.liveTarget.displayObject);
                item.onLiveInspect(false);
            };
            this.liveTarget = $target;
            item = this.treeView.getDisplayItem(this.liveTarget.displayObject);
            item.onLiveInspect(true);
            this.treeView.onInspect(this.liveTarget.displayObject);
            this.panel.onLiveInspect(this.liveTarget.displayObject);
            view = this.treeView.getObjectRenderer(this.liveTarget.displayObject);
            if (view){
                this.panel.showContentArea(view.getBounds(view.parent), 0);
            };
        }
        override public function onStartLiveInspect():void{
            var item:DisplayItemData;
            if (this.target){
                item = this.treeView.getDisplayItem(this.target.displayObject);
                item.onInspect(false);
            };
        }
        private function onOverElement(evt:DisplayItemEvent):void{
            var ele:StructureElementView;
            if ((evt.target is StructureElementView)){
                ele = (evt.target as StructureElementView);
                evt.stopImmediatePropagation();
                this._inspector.liveInspect(ele.data.displayObject);
            };
        }
        private function onClickElement(evt:DisplayItemEvent):void{
            var ele:StructureElementView;
            if ((evt.target is StructureElementView)){
                ele = (evt.target as StructureElementView);
                evt.stopImmediatePropagation();
                this._inspector.inspect(ele.data.displayObject);
            };
        }
        private function onRollOutPanel(evt:MouseEvent):void{
            if (!(this._inspector.isLiveInspecting)){
                if (target){
                    if (!(this.panel.hitTestPoint(evt.stageX, evt.stageY))){
                        this._inspector.inspect(target.displayObject);
                    };
                };
            };
        }
        private function onClickLinkTarget(evt:TextEvent):void{
            var level:uint = uint(evt.text);
            var object:DisplayObject = this.panel.inspectObject;
            while (level--) {
                object = object.parent;
            };
            this._inspector.inspect(object);
        }
        override public function onUpdate(target:InspectTarget=null):void{
            this.treeView.drawList();
        }
        private function onClickClose(evt:Event):void{
            Debug.trace("[StructureView][onClickClose]");
            this._inspector.pluginManager.unactivePlugin(InspectorPluginId.STRUCT_VIEW);
        }
        private function onRefresh(evt:Event):void{
            this.onInspect(this.target);
        }
        public function dispose():void{
        }

    }
}//package cn.itamt.utils.inspector.core.structureview 
