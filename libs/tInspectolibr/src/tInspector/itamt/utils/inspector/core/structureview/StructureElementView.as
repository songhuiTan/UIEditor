//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.structureview {
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.output.*;
    import tInspector.itamt.utils.inspector.events.*;
    import tInspector.itamt.utils.*;
    import flash.text.*;

    public class StructureElementView extends BaseDisplayItemView {

        public static var outputerManager:InspectorOutPuterManager;

        private var _tf:TextField;
        private var btn:SimpleButton;
        private var symbol:Bitmap;
        private var inited:Boolean = false;

        public function StructureElementView():void{
            super();
            this.symbol = new Bitmap();
            addChild(this.symbol);
            this._tf = InspectorTextField.create("", 0, 12);
            this._tf.selectable = false;
            this._tf.autoSize = "left";
            addChild(this._tf);
            this.btn = new SimpleButton();
            addChild(this.btn);
            addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemove);
        }
        private function onAdded(evt:Event):void{
            if (this.inited){
                return;
            };
            this.inited = true;
            this._tf.addEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            this._tf.addEventListener(MouseEvent.CLICK, this.onClickItem);
            this.btn.addEventListener(MouseEvent.CLICK, this.onClickExpand);
        }
        private function onRemove(evt:Event):void{
            this.dispose();
        }
        override public function setData(value:DisplayItemData):void{
            var bmp:Bitmap;
            this._data = value;
            var outputer:DisplayObjectInfoOutPuter = outputerManager.getOutputerByInstance(this._data.displayObject);
            this._tf.htmlText = outputer.output(this._data.displayObject);
            if (_data != value){
                if (_data){
                    _data.removeEventListener(DisplayItemEvent.CHANGE, this.onDataChange);
                };
                _data = value;
                _data.addEventListener(DisplayItemEvent.CHANGE, this.onDataChange, false, 0, true);
            };
            if (_data.hasChildren){
                this.btn.visible = true;
                if (_data.isExpand){
                    bmp = new Bitmap(InspectorSymbolIcon.getIcon(InspectorSymbolIcon.CLLOAPSE));
                } else {
                    bmp = new Bitmap(InspectorSymbolIcon.getIcon(InspectorSymbolIcon.EXPAND));
                };
                this.btn.upState = (this.btn.downState = (this.btn.overState = (this.btn.hitTestState = bmp)));
            } else {
                this.btn.visible = false;
            };
            this.symbol.bitmapData = InspectorSymbolIcon.getIconByClass(this._data.displayObject);
            var level:int = DisplayObjectTool.getDisplayObjectLevel(_data.displayObject);
            this.btn.x = (level * 16);
            this.symbol.x = (this.btn.x + this.btn.width);
            this._tf.x = (this.symbol.x + this.symbol.width);
            this.resetStyle();
            if (_data.isOnInspect){
                this._tf.background = true;
                this._tf.backgroundColor = 0xFF;
            };
            if (_data.isOnLiveInspect){
                this._tf.border = true;
                this._tf.borderColor = 0xFF00FF;
            };
        }
        private function onMouseOver(evt:MouseEvent):void{
            evt.stopImmediatePropagation();
            this.dispatchEvent(new DisplayItemEvent(DisplayItemEvent.OVER, true, true));
        }
        public function resetStyle():void{
            this._tf.background = false;
            this._tf.border = false;
        }
        private function onClickItem(evt:MouseEvent):void{
            evt.stopImmediatePropagation();
            this.dispatchEvent(new DisplayItemEvent(DisplayItemEvent.CLICK, true, true));
        }
        private function onClickExpand(evt:MouseEvent):void{
            _data.toggleExpand();
        }
        private function onDataChange(evt:DisplayItemEvent):void{
            this.setData(_data);
        }
        public function dispose():void{
            this.inited = false;
            this._tf.removeEventListener(MouseEvent.MOUSE_OVER, this.onMouseOver);
            this._tf.removeEventListener(MouseEvent.CLICK, this.onClickItem);
            this.btn.removeEventListener(MouseEvent.CLICK, this.onClickExpand);
        }

    }
}//package cn.itamt.utils.inspector.core.structureview 
