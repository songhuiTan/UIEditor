//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview.accessors {
    import flash.events.*;
    import tInspector.itamt.utils.inspector.events.*;
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.display.*;

    public class EnumValueListEditor extends BasePropertyEditor {

        protected var _curItem:EnumValueItemRenderer;
        protected var _items:Array;
        protected var _itemsPanel:InspectorViewPanel;

        public function EnumValueListEditor(){
            super();
        }
        private function onSelectItem(evt:Event):void{
            if (evt.type == Event.SELECT){
                _value = (evt.target as EnumValueItemRenderer).editor.getValue();
                this.dispatchEvent(new PropertyEvent(PropertyEvent.UPDATE, true, true));
            } else {
                this.setValue(_value);
            };
            evt.stopImmediatePropagation();
            if (this._itemsPanel){
                if (this._itemsPanel.parent){
                    this._itemsPanel.parent.removeChild(this._itemsPanel);
                    this.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
                    this._itemsPanel = null;
                };
            };
        }
        override protected function onReadWrite():void{
            this.addEventListener(MouseEvent.CLICK, this.onClick);
        }
        private function onClick(event:MouseEvent):void{
            var maxw:Number;
            var i:int;
            var item:EnumValueItemRenderer;
            if (this._itemsPanel == null){
                this._itemsPanel = new InspectorViewPanel("", 180, 160, true, false, false);
                this._itemsPanel.minH = (this._itemsPanel.minW = 30);
                this._itemsPanel.padding = new Padding(10, 10, 10, 10);
                this._itemsPanel.setContent(new Sprite());
            };
            if (this._items){
                maxw = 0;
                i = 0;
                while (i < this._items.length) {
                    item = this._items[i];
                    this._items[i].x = 0;
                    maxw = Math.max(maxw, this._items[i].width);
                    if (i > 0){
                        this._items[i].y = ((this._items[(i - 1)].y + this._items[(i - 1)].height) + 3);
                    } else {
                        this._items[i].y = 0;
                    };
                    (this._itemsPanel.getContent() as Sprite).addChild(item);
                    this._itemsPanel.resize((maxw + 20), ((this._items[i].y + this._items[i].height) + 20));
                    i++;
                };
            };
            this.stage.addChild(this._itemsPanel);
            this.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
            this._itemsPanel.x = this.stage.mouseX;
            this._itemsPanel.y = this.stage.mouseY;
        }
        private function onMouseUp(evt:MouseEvent):void{
            if (this._itemsPanel){
                if (this._itemsPanel.parent){
                    if (!(this._itemsPanel.hitTestPoint(this.stage.mouseX, this.stage.mouseY))){
                        this._itemsPanel.parent.removeChild(this._itemsPanel);
                        this.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
                        this._itemsPanel = null;
                        if (this._curItem){
                            this._curItem.x = 0;
                            this._curItem.y = 0;
                            addChild(this._curItem);
                        };
                    };
                };
            };
        }
        override public function setValue(value):void{
            var item:EnumValueItemRenderer;
            super.setValue(value);
            for each (item in this._items) {
                if (item.editor.getValue() == _value){
                    item.selected = true;
                    if (item != this._curItem){
                        if (((this._curItem) && (contains(this._curItem)))){
                            removeChild(this._curItem);
                        };
                        this._curItem = item;
                    };
                } else {
                    item.selected = false;
                };
            };
            if (this._curItem){
                this._curItem.x = 0;
                this._curItem.y = 0;
                addChild(this._curItem);
            };
        }
        public function addEnumValueEditor(editor:BasePropertyEditor):void{
            if (this._items == null){
                this._items = [];
            };
            if (this._items.indexOf(editor) >= 0){
                return;
            };
            var item:EnumValueItemRenderer = new EnumValueItemRenderer(editor);
            this._items.push(item);
            item.addEventListener(Event.SELECT, this.onSelectItem);
            item.addEventListener(Event.CANCEL, this.onSelectItem);
        }
        override public function relayOut():void{
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview.accessors 
