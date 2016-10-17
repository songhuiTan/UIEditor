//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import tInspector.itamt.utils.*;
    import tInspector.itamt.utils.inspector.core.liveinspect.*;
    
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;

    public class InspectorViewPanel extends Sprite {

        protected var _padding:Padding;
        protected var bg:Sprite;
        protected var _title:TextField;
        protected var _width:Number;
        protected var _height:Number;
        protected var _contentContainer:Sprite;
        protected var _content:DisplayObject;
        protected var _scroller:InspectorScroller;
        protected var closeBtn:InspectorViewCloseButton;
        protected var resizeBtn:InspectorViewResizeButton;
        protected var _resizer:ResizerButton;
        protected var _virtualResizer:Sprite;
        private var autoDispose:Boolean;
        protected var _minW:Number = 180;
        protected var _minH:Number = 160;
        private var inited:Boolean;
        private var _lw:Number = Infinity;
        private var _lh:Number = Infinity;

        public function InspectorViewPanel(title:String="面板", w:Number=200, h:Number=200, autoDisposeWhenRemove:Boolean=true, resizeable:Boolean=true, closeable:Boolean=true){
            this._padding = new Padding(33, 10, 10, 10);
            super();
            this.autoDispose = autoDisposeWhenRemove;
            this.bg = new Sprite();
            addChild(this.bg);
            this.bg.filters = [new GlowFilter(0, 1, 8, 8, 1)];
            this._virtualResizer = new Sprite();
            this._virtualResizer.graphics.lineStyle(1, 0x888888, 1, false, "normal", CapsStyle.NONE, JointStyle.MITER);
            this._virtualResizer.graphics.beginFill(0);
            this._virtualResizer.graphics.moveTo(0, 0);
            this._virtualResizer.graphics.lineTo(-(w), 0);
            this._virtualResizer.graphics.lineTo(0, -(h));
            this._virtualResizer.graphics.lineTo(0, 0);
            this._virtualResizer.graphics.moveTo((-(w) / 2), 0);
            this._virtualResizer.graphics.moveTo(0, (-(h) / 2));
            this._virtualResizer.graphics.endFill();
            this._resizer = new ResizerButton(15, 15);
            if (resizeable){
                addChild(this._resizer);
            };
            this._title = InspectorTextField.create(title, 0x99CC00, 12);
            this._title.selectable = false;
            this._title.height = 20;
            addChild(this._title);
            this._contentContainer = new Sprite();
            addChild(this._contentContainer);
            this.closeBtn = new InspectorViewCloseButton();
            this.closeBtn.addEventListener(MouseEvent.CLICK, this.onClickClose);
            if (closeable){
                addChild(this.closeBtn);
            };
            this.resizeBtn = new InspectorViewResizeButton();
            this.resizeBtn.addEventListener(MouseEvent.CLICK, this.onClickResize);
            if (resizeable){
                addChild(this.resizeBtn);
            };
            this._width = ((w > this._minW)) ? w : this._minW;
            this._height = ((h > this._minH)) ? h : this._minH;
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
        }
        public function set padding(val:Padding):void{
            this._padding = val;
            if (this.inited){
                this.relayout();
            };
        }
        public function get padding():Padding{
            return (this._padding);
        }
        override public function get width():Number{
            return (this._width);
        }
        public function set minW(num:Number):void{
            this._minW = num;
        }
        public function set minH(num:Number):void{
            this._minH = num;
        }
        private function onAdded(evt:Event):void{
            if (evt.target == this){
                if (this.inited){
                    return;
                };
                this.inited = true;
                this.bg.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                this.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseup);
                this.addEventListener(MouseEvent.MOUSE_UP, this.onMouseup);
                this._resizer.addEventListener(MouseEvent.MOUSE_DOWN, this.onDownResizer);
                this.relayout();
            };
        }
        private function onRemoved(evt:Event):void{
            if (evt.target == this){
                this.inited = false;
                this.bg.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
                this.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseup);
                this.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseup);
                this._resizer.removeEventListener(MouseEvent.MOUSE_DOWN, this.onDownResizer);
                this.stage.removeEventListener(Event.ENTER_FRAME, this.onMoveResizer);
                this.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
                if (this.autoDispose){
                    this.dispose();
                };
            };
        }
        private function onDownResizer(evt:MouseEvent):void{
            this._virtualResizer.x = this._resizer.x;
            this._virtualResizer.y = this._resizer.y;
            this.stage.addEventListener(Event.ENTER_FRAME, this.onMoveResizer);
            var rect:Rectangle = this.getBounds(this.stage);
            var stagetBounds:Rectangle = InspectorStageReference.getStageBounds();
            this._virtualResizer.startDrag(false, new Rectangle(this._minW, this._minH, (((stagetBounds.right - this._minW) - rect.x) - 8), (((stagetBounds.bottom - this._minH) - rect.y) - 8)));
        }
        protected function onMoveResizer(evt:Event):void{
            this.resize(this._virtualResizer.x, this._virtualResizer.y);
        }
        protected function onMouseDown(evt:MouseEvent):void{
            this.cacheAsBitmap = true;
            var rect:Rectangle = InspectorStageReference.getStageBounds();
            this.startDrag(false, new Rectangle((rect.left - mouseX), (rect.top - mouseY), rect.width, rect.height));
            DisplayObjectTool.swapToTop(this);
        }
        protected function onMouseup(evt:MouseEvent):void{
            this.cacheAsBitmap = false;
            this.stage.removeEventListener(Event.ENTER_FRAME, this.onMoveResizer);
            this.stopDrag();
            this._virtualResizer.stopDrag();
        }
        public function setContent(content:DisplayObject):void{
            if (content == this._content){
                if (this.inited){
                    this.relayout();
                };
            } else {
                if (this._content){
                    this._content.removeEventListener(Event.RESIZE, this.onContentResize);
                    this._contentContainer.removeChild(this._content);
                };
                this._content = content;
                this._content.addEventListener(Event.RESIZE, this.onContentResize, false, 0, true);
                this._contentContainer.x = this._padding.left;
                this._contentContainer.y = this._padding.top;
                this._contentContainer.scrollRect = new Rectangle(0, 0, this.calculateContenAreaWidth(), this.calculateContenAreaHeight());
                this._contentContainer.addChild(this._content);
                if (this.inited){
                    this.relayout();
                };
            };
        }
        public function getContent():DisplayObject{
            return (this._content);
        }
        public function resize(w:Number, h:Number):void{
            this._width = ((w > this._minW)) ? w : this._minW;
            this._height = ((h > this._minH)) ? h : this._minH;
            this.relayout();
        }
        public function relayout():void{
            this.drawBG();
            if (this._content){
                this.drawContent();
            };
            this._virtualResizer.x = (this._resizer.x = this._width);
            this._virtualResizer.y = (this._resizer.y = this._height);
            this.closeBtn.x = ((this._width - 5) - this.closeBtn.width);
            this.closeBtn.y = 5;
            this.resizeBtn.x = (this.closeBtn.x - this.resizeBtn.width);
            this.resizeBtn.y = 5;
            this.drawTitle();
        }
        override public function get height():Number{
            return (this._height);
        }
        protected function drawTitle():void{
            this._title.x = this._padding.left;
            this._title.y = 7;
            this._title.width = (this._title.textWidth + 4);
            if (this._title.width > (this.resizeBtn.x - this._padding.left)){
                this._title.width = (this.resizeBtn.x - this._padding.left);
            };
        }
        public function set title(str:String):void{
            this._title.text = str;
            this.drawTitle();
        }
        public function get title():String{
            return (this._title.text);
        }
        private function drawContent():void{
            var rect:Rectangle = this._contentContainer.scrollRect;
            if (this.needHScroller()){
                if (this._scroller == null){
                    this._scroller = new InspectorScroller(15, this.calculateContenAreaHeight());
                    this._scroller.y = this._padding.top;
                    this._scroller.addEventListener(Event.CHANGE, this.onScroll);
                    this.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
                } else {
                    this._scroller.resize(15, this.calculateContenAreaHeight());
                };
                this._scroller.x = ((this._width - this._padding.right) - this._scroller.width);
                this._scroller.setContenRatio((this.calculateContenAreaHeight() / this._content.height));
                if (this._scroller.stage == null){
                    addChild(this._scroller);
                };
                this._contentContainer.scrollRect = new Rectangle(rect.x, this.calculateScrollRectY(), (this.calculateContenAreaWidth() - this._scroller.width), this.calculateContenAreaHeight());
            } else {
                this._contentContainer.scrollRect = new Rectangle(rect.x, 0, this.calculateContenAreaWidth(), this.calculateContenAreaHeight());
                if (this._scroller){
                    if (this._scroller.stage){
                        removeChild(this._scroller);
                    };
                    this.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
                    this._scroller.removeEventListener(Event.CHANGE, this.onScroll);
                    this._scroller = null;
                };
            };
        }
        private function drawBG():void{
            this.bg.graphics.clear();
            this.bg.graphics.lineStyle(2, 0x888888);
            this.bg.graphics.beginFill(InspectorColorStyle.DEFAULT_BG);
            this.bg.graphics.drawRoundRect(0, 0, this._width, this._height, 15, 15);
            this.bg.graphics.endFill();
        }
        private function onContentResize(evt:Event):void{
            this.relayout();
        }
        private function onScroll(evt:Event=null):void{
            var rect:Rectangle = this._contentContainer.scrollRect;
            rect.y = this.calculateScrollRectY();
            this._contentContainer.scrollRect = rect;
        }
        public function showContentArea(rect:Rectangle, ori:int=2):void{
            if (ori == 0){
                rect.width = 1;
            } else {
                if (ori == 1){
                    rect.height = 1;
                };
            };
            if (this._contentContainer.scrollRect.containsRect(rect)){
                return;
            };
            var v:Number = ((100 * rect.bottom) / this._content.height);
            if (v < 0){
                v = 0;
            };
            if (v > 100){
                v = 100;
            };
            if (this._scroller){
                this._scroller.value = v;
            };
            this.onScroll();
        }
        protected function needHScroller():Boolean{
            return (((this._content.height - this.calculateContenAreaHeight()) > 0));
        }
        protected function needVScroller():Boolean{
            return (false);
        }
        private function onMouseWheel(evt:MouseEvent):void{
            var rect:Rectangle;
            var t:Number;
            if (this._content){
                rect = this._contentContainer.scrollRect;
                rect.y = (rect.y + ((evt.delta < 0)) ? 20 : -20);
                if (rect.y < 0){
                    rect.y = 0;
                };
                t = (this._content.height - this.calculateContenAreaHeight());
                if (rect.y > t){
                    rect.y = t;
                };
                this._contentContainer.scrollRect = rect;
                if (this._scroller){
                    this._scroller.value = ((100 * rect.y) / t);
                };
            };
        }
        private function calculateScrollRectY():Number{
            if (this._scroller){
                return (((this._scroller.value / 100) * (this._content.height - this.calculateContenAreaHeight())));
            };
            return (0);
        }
        private function calculateContenAreaHeight():Number{
            return (((this._height - this._padding.top) - this._padding.bottom));
        }
        private function calculateContenAreaWidth():Number{
            return (((this._width - this._padding.left) - this._padding.right));
        }
        protected function onClickClose(evt:Event):void{
            evt.stopImmediatePropagation();
            dispatchEvent(new Event(Event.CLOSE));
        }
        private function onClickResize(evt:Event):void{
            evt.stopImmediatePropagation();
            if (this.resizeBtn.normalMode){
                this.open();
                dispatchEvent(new Event(Event.CANCEL));
            } else {
                this.hide();
                dispatchEvent(new Event(Event.OPEN));
            };
        }
        private function onEffComplete(evt:Event):void{
        }
        public function open():void{
            if (isNaN(this._lw)){
                this._lw = 200;
            };
            if (isNaN(this._lh)){
                this._lh = 200;
            };
            addChild(this._contentContainer);
            addChild(this._resizer);
            this._width = this._lw;
            this._height = this._lh;
            this.relayout();
            if (this._scroller){
                this._scroller.visible = true;
            };
        }
        public function hide():void{
            this._lw = this._width;
            this._lh = this._height;
            if (this._contentContainer.stage){
                this._contentContainer.parent.removeChild(this._contentContainer);
            };
            if (this._resizer.stage){
                this._resizer.parent.removeChild(this._resizer);
            };
            this._height = 33;
            this.relayout();
            if (this._scroller){
                this._scroller.visible = false;
            };
        }
        public function dispose():void{
            while (this.numChildren) {
                this.removeChildAt(0);
            };
        }

    }
}//package cn.itamt.utils.inspector.ui 
