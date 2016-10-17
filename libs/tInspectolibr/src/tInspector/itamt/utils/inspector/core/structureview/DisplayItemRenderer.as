//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.structureview {
    import flash.events.*;
    import tInspector.itamt.utils.inspector.events.*;
    import tInspector.itamt.utils.*;
    import flash.display.*;
    import flash.text.*;

    public class DisplayItemRenderer extends BaseDisplayItemView {

        public var name_tf:TextField;
        public var btn:MovieClip;

        public function DisplayItemRenderer(){
            super();
            this.name_tf.autoSize = "left";
            this.btn.addEventListener(MouseEvent.CLICK, this.onClickExpand);
        }
        override public function setData(value:DisplayItemData):void{
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
                    this.btn.gotoAndStop(1);
                } else {
                    this.btn.gotoAndStop(2);
                };
            } else {
                this.btn.visible = false;
            };
            this.name_tf.text = ClassTool.getShortClassName(_data.displayObject);
            var level:int = this.getDisplayObjectLevel(_data.displayObject);
            this.btn.x = (level * 10);
            this.name_tf.x = ((this.btn.x + this.btn.width) + 4);
        }
        private function onClickExpand(evt:MouseEvent):void{
            _data.toggleExpand();
        }
        private function onDataChange(evt:DisplayItemEvent):void{
            this.setData(_data);
        }
        private function getDisplayObjectLevel(object:DisplayObject):int{
            var i:int;
            if ((object is Stage)){
                return (0);
            };
            if (object.stage){
                i = 0;
                while (object.parent) {
                    object = object.parent;
                    i++;
                };
                return (i);
            };
            return (-1);
        }

    }
}//package cn.itamt.utils.inspector.core.structureview 
