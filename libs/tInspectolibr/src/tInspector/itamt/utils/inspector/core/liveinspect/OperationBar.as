//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.liveinspect {
    import tInspector.itamt.utils.inspector.ui.*;
    import tInspector.itamt.utils.inspector.core.propertyview.*;
    import tInspector.itamt.utils.inspector.core.structureview.*;
    import tInspector.itamt.utils.inspector.core.inspectfilter.*;
    import flash.events.*;
    import flash.display.*;
    import tInspector.itamt.utils.*;
    import tInspector.itamt.utils.inspector.lang.*;

    public class OperationBar extends Sprite {

        public static const PRESS_MOVE:String = "press_move";
        public static const PRESS_PARENT:String = "press_parent";
        public static const PRESS_CHILD:String = "press_child";
        public static const PRESS_NEXT:String = "press_brother";
        public static const PRESS_PREV:String = "press_prev";
        public static const PRESS_INFO:String = "press_info";
        public static const PRESS_STRUCTURE:String = "press_structure";
        public static const PRESS_CLOSE:String = "press_close";
        public static const DOWN_MOVE:String = "down_move";
        public static const UP_MOVE:String = "up_move";
        public static const DB_CLICK_MOVE:String = "double_click_move";
        public static const PRESS_FILTER:String = "click_filter";

        private var _moveBtn:InspectorViewMoveButton;
        private var _pareBtn:InspectorViewParentButton;
        private var _childBtn:InspectorViewChildButton;
        private var _broBtn:InspectorViewBrotherButton;
        private var _prevBtn:InspectorViewPrevButton;
        private var _infoBtn:PropertiesViewButton;
        private var _filterBtn:FilterManagerButton;
        private var _struBtn:StructureViewButton;
        private var _closeBtn:InspectorViewCloseButton;
        private var _paddings:Array;
        private var _btnGap:int = 5;
        private var _width:int = 200;
        private var _height:int = 33;

        public function OperationBar():void{
            this._paddings = [10, 5, 10];
            super();
        }
        public function get barHeight():int{
            return (this._height);
        }
        public function init():void{
            var btn:InspectorButton;
            var btns:Array = [(this._moveBtn = new InspectorViewMoveButton()), (this._pareBtn = new InspectorViewParentButton()), (this._childBtn = new InspectorViewChildButton()), (this._prevBtn = new InspectorViewPrevButton()), (this._broBtn = new InspectorViewBrotherButton()), (this._infoBtn = new PropertiesViewButton()), (this._struBtn = new StructureViewButton()), (this._filterBtn = new FilterManagerButton()), (this._closeBtn = new InspectorViewCloseButton())];
            var i:int;
            while (i < btns.length) {
                btn = (btns[i] as InspectorButton);
                addChild(btn);
                if (i == 0){
                    btn.x = (this._paddings[0] + (i * this._btnGap));
                } else {
                    btn.x = (this._paddings[0] + (i * (this._btnGap + (btns[(i - 1)] as InspectorButton).width)));
                };
                btn.y = this._paddings[1];
                i++;
            };
            graphics.clear();
            graphics.beginFill(0x393939);
            graphics.drawRoundRectComplex(0, 0, ((this._closeBtn.x + this._closeBtn.width) + 10), this._height, 8, 8, 0, 8);
            graphics.endFill();
            this._moveBtn.doubleClickEnabled = true;
            this._moveBtn.addEventListener(MouseEvent.CLICK, this.onClickMoveBtn);
            this._moveBtn.addEventListener(MouseEvent.MOUSE_DOWN, this.onDownMoveBtn);
            this._moveBtn.addEventListener(MouseEvent.MOUSE_UP, this.onUpMoveBtn);
            this._moveBtn.addEventListener(MouseEvent.DOUBLE_CLICK, this.onDlickMoveBtn);
            this._pareBtn.addEventListener(MouseEvent.CLICK, this.onClickParentBtn);
            this._childBtn.addEventListener(MouseEvent.CLICK, this.onClickChildBtn);
            this._broBtn.addEventListener(MouseEvent.CLICK, this.onClickBrotherBtn);
            this._prevBtn.addEventListener(MouseEvent.CLICK, this.onClickPrevBtn);
            this._infoBtn.addEventListener(MouseEvent.CLICK, this.onClickInfoBtn);
            this._closeBtn.addEventListener(MouseEvent.CLICK, this.onClickCloseBtn);
            this._struBtn.addEventListener(MouseEvent.CLICK, this.onClickStruBtn);
            this._filterBtn.addEventListener(MouseEvent.CLICK, this.onClickFilterBtn);
        }
        private function onDlickMoveBtn(evt:MouseEvent):void{
            dispatchEvent(new Event(DB_CLICK_MOVE));
        }
        private function onClickMoveBtn(evt:MouseEvent):void{
            dispatchEvent(new Event(PRESS_MOVE));
        }
        private function onDownMoveBtn(evt:MouseEvent):void{
            this.stage.addEventListener(MouseEvent.MOUSE_UP, this.onUpMoveBtn);
            dispatchEvent(new Event(DOWN_MOVE));
        }
        private function onUpMoveBtn(evt:MouseEvent):void{
            this.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onUpMoveBtn);
            dispatchEvent(new Event(UP_MOVE));
        }
        private function onClickParentBtn(evt:MouseEvent):void{
            dispatchEvent(new Event(PRESS_PARENT));
        }
        private function onClickChildBtn(evt:MouseEvent):void{
            dispatchEvent(new Event(PRESS_CHILD));
        }
        private function onClickBrotherBtn(evt:MouseEvent):void{
            dispatchEvent(new Event(PRESS_NEXT));
        }
        private function onClickPrevBtn(evt:MouseEvent):void{
            dispatchEvent(new Event(PRESS_PREV));
        }
        private function onClickInfoBtn(evt:MouseEvent):void{
            dispatchEvent(new Event(PRESS_INFO, true, true));
        }
        private function onClickStruBtn(evt:MouseEvent):void{
            dispatchEvent(new Event(PRESS_STRUCTURE, true, true));
        }
        private function onClickFilterBtn(evt:MouseEvent):void{
            dispatchEvent(new Event(PRESS_FILTER, true, true));
        }
        private function onClickCloseBtn(evt:MouseEvent):void{
            dispatchEvent(new Event(PRESS_CLOSE));
        }
        public function dispose():void{
        }
        public function validate(target:DisplayObject):void{
            this._moveBtn.enabled = (this._pareBtn.enabled = (this._childBtn.enabled = (this._prevBtn.enabled = (this._broBtn.enabled = (this._closeBtn.enabled = true)))));
            if ((target is Stage)){
                this._moveBtn.enabled = false;
            };
            if (target.parent){
                if (target.parent.numChildren == 1){
                    this._broBtn.enabled = false;
                    this._prevBtn.enabled = false;
                };
            } else {
                this._pareBtn.enabled = false;
                this._broBtn.enabled = false;
                this._prevBtn.enabled = false;
            };
            if ((target is DisplayObjectContainer)){
            } else {
                this._childBtn.enabled = false;
            };
            this._filterBtn.active = Inspector.getInstance().filterManager.isFilterActiving((target["constructor"] as Class));
            if (this._filterBtn.active){
                this._filterBtn.tip = InspectorLanguageManager.getStr("SetFilterClass");
            } else {
                this._filterBtn.tip = InspectorLanguageManager.getStr("unSetFilterClass");
            };
        }

    }
}//package cn.itamt.utils.inspector.core.liveinspect 
