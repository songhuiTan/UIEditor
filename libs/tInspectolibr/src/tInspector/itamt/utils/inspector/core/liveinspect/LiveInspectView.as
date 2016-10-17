//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.liveinspect {
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    
    import tInspector.com.senocular.display.*;
    import tInspector.itamt.utils.*;
    import tInspector.itamt.utils.inspector.core.*;
    import tInspector.itamt.utils.inspector.events.*;
    import tInspector.itamt.utils.inspector.output.*;
    import tInspector.itamt.utils.inspector.plugins.*;
    import tInspector.itamt.utils.inspector.ui.*;
    import tInspector.ll.evt.ComponentEvent;

    public class LiveInspectView extends BaseInspectorPlugin {

        private var _des:TextField;
        private var _mBtn:Sprite;
        private var _mFrame:Shape;
        private var _bar:OperationBar;
        private var _tfm:TransformTool;
        private var inited:Boolean;
        private var rect:Rectangle;
        private var reg:Point;
        private var parentReg:Point;
        private var lp:Point;

        public function LiveInspectView():void{
            super();
            outputerManager = new InspectorOutPuterManager();
        }
        override public function getPluginId():String{
            return (InspectorPluginId.LIVE_VIEW);
        }
        override public function onRegister(inspector:IInspector):void{
            super.onRegister(inspector);
            _icon = new LiveInspectButton();
        }
        override public function onActive():void{
            super.onActive();
            this._inspector.startLiveInspect();
            if (this.inited){
                return;
            };
            this.inited = true;
            this.viewContainer = new Sprite();
            this.viewContainer.mouseEnabled = false;
            this._des = InspectorTextField.create("", 0xFFFFFF, 13);
            this._des.background = true;
            this._des.backgroundColor = 6515714;
            this._des.border = true;
            this._des.borderColor = 6515714;
            this._des.cacheAsBitmap = true;
            this._des.autoSize = "left";
            this.viewContainer.addChild(this._des);
            this._mBtn = new Sprite();
            this._mBtn.buttonMode = true;
            this.viewContainer.addChild(this._mBtn);
            this._mFrame = new Shape();
            this._tfm = new TransformTool();
            this._tfm.addEventListener(TransformTool.TRANSFORM_TARGET, function (evt:Event):void{
                update();
            });
			
			//silenxiao
			this._tfm.addEventListener(TransformTool.CONTROL_UP, function(evt:Event):void
			{
				updateTargetSize();
			});
			//
            this._tfm.addControl(new ResetTransofrmControl());
            this._tfm.raiseNewTargets = false;
            this._tfm.moveEnabled = false;
            this._tfm.outlineEnabled = false;
            this._tfm.setSkin(TransformTool.SCALE_TOP_LEFT, new Sprite());
            this._tfm.setSkin(TransformTool.SCALE_TOP_RIGHT, new Sprite());
            this._tfm.setSkin(TransformTool.SCALE_BOTTOM_RIGHT, new LiveScalePointBtn());
            this._tfm.setSkin(TransformTool.SCALE_BOTTOM_LEFT, new Sprite());
            this._tfm.setSkin(TransformTool.SCALE_TOP, new Sprite());
            this._tfm.setSkin(TransformTool.SCALE_RIGHT, new LiveScalePointBtn());
            this._tfm.setSkin(TransformTool.SCALE_BOTTOM, new LiveScalePointBtn());
            this._tfm.setSkin(TransformTool.SCALE_LEFT, new Sprite());
            this._tfm.setSkin(TransformTool.ROTATION_TOP_RIGHT, new LiveRotatePointBtn());
            this._tfm.setSkin(TransformTool.ROTATION_BOTTOM_LEFT, new Sprite());
            this._tfm.setSkin(TransformTool.ROTATION_TOP_LEFT, new Sprite());
            this._tfm.setSkin(TransformTool.ROTATION_BOTTOM_RIGHT, new Sprite());
            this.viewContainer.addChild(this._tfm);
            this._bar = new OperationBar();
            this._bar.init();
            this._mBtn.addEventListener(MouseEvent.CLICK, this.onClickInspect);
            this._bar.addEventListener(OperationBar.DOWN_MOVE, this.onStartMove);
            this._bar.addEventListener(OperationBar.UP_MOVE, this.onStopMove);
            this._bar.addEventListener(OperationBar.PRESS_CLOSE, this.onCloseBar);
            this._bar.addEventListener(OperationBar.PRESS_PARENT, this.onPressParent);
            this._bar.addEventListener(OperationBar.PRESS_CHILD, this.onPressChild);
            this._bar.addEventListener(OperationBar.PRESS_NEXT, this.onPressBrother);
            this._bar.addEventListener(OperationBar.PRESS_PREV, this.onPressPrevious);
            this._bar.addEventListener(OperationBar.PRESS_STRUCTURE, this.onPressStructure);
            this._bar.addEventListener(OperationBar.PRESS_INFO, this.onPressInfo);
            this._bar.addEventListener(OperationBar.PRESS_FILTER, this.onPressFilter);
            this._bar.addEventListener(OperationBar.DB_CLICK_MOVE, this.onClickReset);
        }
        override public function onUnActive():void{
            super.onUnActive();
            this._inspector.stopLiveInspect();
            this.inited = false;
            if (this.viewContainer){
                this.viewContainer.graphics.clear();
                if (this.viewContainer.stage){
                    this.viewContainer.stage.removeEventListener(Event.ENTER_FRAME, this.onMouseMove);
                    this.viewContainer.stage.removeChild(this.viewContainer);
                };
                if (this._mFrame.stage){
                    this._mFrame.stage.removeChild(this._mFrame);
                };
            };
            if (this._des){
                if (this._des.parent){
                    this._des.parent.removeChild(this._des);
                };
            };
            target = null;
            this._tfm.target = null;
            this._mBtn.removeEventListener(MouseEvent.CLICK, this.onClickInspect);
            this._bar.removeEventListener(OperationBar.DOWN_MOVE, this.onStartMove);
            this._bar.removeEventListener(OperationBar.UP_MOVE, this.onStopMove);
            this._bar.removeEventListener(OperationBar.PRESS_CLOSE, this.onCloseBar);
            this._bar.removeEventListener(OperationBar.PRESS_PARENT, this.onPressParent);
            this._bar.removeEventListener(OperationBar.PRESS_CHILD, this.onPressChild);
            this._bar.removeEventListener(OperationBar.PRESS_NEXT, this.onPressBrother);
            this._bar.removeEventListener(OperationBar.PRESS_NEXT, this.onPressPrevious);
            this._bar.removeEventListener(OperationBar.PRESS_STRUCTURE, this.onPressStructure);
            this._bar.removeEventListener(OperationBar.PRESS_INFO, this.onPressInfo);
        }
        override public function contains(child:DisplayObject):Boolean{
            if (viewContainer){
                return ((((((viewContainer == child)) || (viewContainer.contains(child)))) || ((this._mFrame == child))));
            };
            return (false);
        }
        override public function onInspect(ele:InspectTarget):void{
            target = ele;
            this._tfm.target = null;
            this._tfm.target = target.displayObject;
            this.update();
            if (this._bar.stage == null){
                this.viewContainer.addChild(this._bar);
            };
            this._bar.validate(target.displayObject);
        }
        override public function onLiveInspect(ele:InspectTarget):void{
            if (this.viewContainer.stage == null){
                this._inspector.stage.addChild(this.viewContainer);
            };
            this._inspector.stage.addChild(this._mFrame);
            target = ele;
            this._tfm.target = null;
            this.update(true);
            if (this._bar.stage){
                this.viewContainer.removeChild(this._bar);
            };
            this._bar.validate(target.displayObject);
        }
        override public function onUpdate(target:InspectTarget=null):void{
            this._bar.validate(target.displayObject);
            if (target == this.target){
                this._tfm.target = null;
                this._tfm.target = this.target.displayObject;
                this.update();
            };
        }
        private function update(isLiveMode:Boolean=false):void{
            if (!(this.contains(this._des))){
                this.viewContainer.addChild(this._des);
            };
            if (!(this.contains(this._mBtn))){
                this.viewContainer.addChild(this._mBtn);
            };
            this.rect = target.displayObject.getBounds(this.viewContainer.stage);
            this.reg = target.displayObject.localToGlobal(new Point(0, 0));
            if (target.displayObject.parent){
                this.parentReg = target.displayObject.parent.localToGlobal(new Point(0, 0));
            } else {
                this.parentReg = null;
            };
            var outputer:DisplayObjectInfoOutPuter = outputerManager.getOutputerByInstance(target.displayObject);
            this._des.htmlText = outputer.output(target.displayObject);
            this._des.x = (this.rect.x - 0.5);
            this._des.y = ((this.rect.y - this._des.height) + 0.5);
            if (isLiveMode){
                this.drawMbtn();
                this._mBtn.mouseChildren = (this._mBtn.mouseEnabled = true);
            } else {
                this.drawMbtn(0, 6515714);
                this._mBtn.mouseChildren = (this._mBtn.mouseEnabled = false);
            };
            this._bar.x = (this.rect.x - 0.5);
            this._bar.y = (this._des.y - this._bar.barHeight);
			
			//silenxiao
			dispatchEvent(new ComponentEvent(ComponentEvent.UPDATE_PROPERTY, this.target.displayObject));
        }
        private function onClickInspect(evt:MouseEvent):void{
            this._inspector.inspect(target.displayObject);
			
			//silenxiao
			dispatchEvent(new ComponentEvent(ComponentEvent.COMPONENT_SELECT, target.displayObject));
        }
        private function onStartMove(evt:Event):void{
            this.viewContainer.stage.addEventListener(Event.ENTER_FRAME, this.onMouseMove);
            this.lp = new Point(this._tfm.mouseX, this._tfm.mouseY);
            if (this.viewContainer.parent){
                DisplayObjectTool.swapToTop(this.viewContainer);
            };
        }
        private function onStopMove(evt:Event=null):void{
            this.viewContainer.stage.removeEventListener(Event.ENTER_FRAME, this.onMouseMove);
        }
        private function onMouseMove(evt:Event=null):void{
            var toolMatrix:Matrix = this._tfm.toolMatrix;
            toolMatrix.tx = (toolMatrix.tx + (this._tfm.mouseX - this.lp.x));
            toolMatrix.ty = (toolMatrix.ty + (this._tfm.mouseY - this.lp.y));
            this._tfm.toolMatrix = toolMatrix;
            this._tfm.apply();
            this.lp.x = this._tfm.mouseX;
            this.lp.y = this._tfm.mouseY;
            this.update();
        }
        private function onCloseBar(evt:Event=null):void{
            if (this.viewContainer.stage){
                this.viewContainer.parent.removeChild(this.viewContainer);
            };
            if (this._mFrame.stage){
                this._mFrame.parent.removeChild(this._mFrame);
            };
            this._inspector.startLiveInspect();
        }
        private function onPressParent(evt:Event):void{
            if (target){
                if (target.displayObject.parent){
                    this._inspector.inspect(target.displayObject.parent);
                };
            };
        }
        private function onPressChild(evt:Event):void{
            if (target){
                if ((target.displayObject is DisplayObjectContainer)){
                    this._inspector.inspect((target.displayObject as DisplayObjectContainer).getChildAt(0));
                };
            };
        }
        private function onPressBrother(evt:Event):void{
            var container:DisplayObjectContainer;
            var i:int;
            var t:int;
            if (target){
                if (target.displayObject.parent){
                    container = target.displayObject.parent;
                    i = container.getChildIndex(target.displayObject);
                    ++i;
                    t = (i % container.numChildren);
                    this._inspector.inspect(container.getChildAt(t));
                };
            };
        }
        private function onPressPrevious(evt:Event):void{
            var container:DisplayObjectContainer;
            var i:int;
            var t:int;
            if (target){
                if (target.displayObject.parent){
                    container = target.displayObject.parent;
                    i = container.getChildIndex(target.displayObject);
                    --i;
                    t = ((i)<0) ? (container.numChildren - 1) : i;
                    this._inspector.inspect(container.getChildAt(t));
                };
            };
        }
        private function onClickReset(evt:Event):void{
            if (target){
                target.resetTarget();
                if (this._tfm){
                    this._tfm.target = null;
                    this._tfm.target = target.displayObject;
                };
                this.update();
            };
        }
        private function drawMbtn(alpha:Number=0.2, bColor:uint=0xFF0000):void{
            this._mBtn.graphics.clear();
            this._mBtn.graphics.lineStyle(2, bColor, 1, false, "normal", "square", "miter");
            this._mBtn.graphics.beginFill(0xFF0000, 0);
            var tmp:Rectangle = this.target.displayObject.getBounds(this.target.displayObject);
            var tl:Point = this.target.displayObject.localToGlobal(tmp.topLeft);
            var tr:Point = this.target.displayObject.localToGlobal(new Point(tmp.right, tmp.top));
            var bl:Point = this.target.displayObject.localToGlobal(new Point(tmp.left, tmp.bottom));
            var br:Point = this.target.displayObject.localToGlobal(tmp.bottomRight);
            this._mBtn.graphics.moveTo(tl.x, tl.y);
            this._mBtn.graphics.lineTo(tr.x, tr.y);
            this._mBtn.graphics.lineTo(br.x, br.y);
            this._mBtn.graphics.lineTo(bl.x, bl.y);
            this._mBtn.graphics.lineTo(tl.x, tl.y);
            this._mBtn.graphics.beginFill(0xFF0000, 0);
            this._mBtn.graphics.drawRect(this.rect.x, this.rect.y, this.rect.width, this.rect.height);
            this._mBtn.graphics.lineStyle(1, bColor, 1, false, "normal", "square", "miter");
            this._mBtn.graphics.drawCircle(this.reg.x, this.reg.y, 5);
            this._mBtn.graphics.lineStyle(2, bColor, 1, false, "normal", "square", "miter");
            this._mBtn.graphics.moveTo((this.reg.x - 3), this.reg.y);
            this._mBtn.graphics.lineTo((this.reg.x + 3), this.reg.y);
            this._mBtn.graphics.moveTo(this.reg.x, (this.reg.y - 3));
            this._mBtn.graphics.lineTo(this.reg.x, (this.reg.y + 3));
            this._mBtn.graphics.endFill();
            if (this.parentReg){
                this._mBtn.graphics.lineStyle(2, 0xFF, 1, false, "normal", "square", "miter");
                this._mBtn.graphics.moveTo((this.parentReg.x - 4), this.parentReg.y);
                this._mBtn.graphics.lineTo((this.parentReg.x + 4), this.parentReg.y);
                this._mBtn.graphics.moveTo(this.parentReg.x, (this.parentReg.y - 4));
                this._mBtn.graphics.lineTo(this.parentReg.x, (this.parentReg.y + 4));
            };
            this._mFrame.graphics.clear();
            this._mFrame.graphics.lineStyle(2, bColor, 1, false, "normal", "square", "miter");
            this._mFrame.graphics.beginFill(0xFF0000, alpha);
            this._mFrame.graphics.drawRect(this.rect.x, this.rect.y, this.rect.width, this.rect.height);
            this._mFrame.graphics.endFill();
        }
        private function onPressStructure(evt:Event):void{
            _inspector.pluginManager.activePlugin(InspectorPluginId.STRUCT_VIEW);
        }
        private function onPressInfo(evt:Event):void{
            _inspector.pluginManager.activePlugin(InspectorPluginId.PROPER_VIEW);
        }
        private function onPressFilter(evt:Event):void{
            _inspector.stage.dispatchEvent(new InspectorFilterEvent(InspectorFilterEvent.CHANGE, (this.target.displayObject["constructor"] as Class)));
        }

		//silenxiao
		private function updateTargetSize():void
		{
			var matrix:Matrix = target.displayObject.transform.matrix;
			var _width:int = target.displayObject.width * matrix.a;
			var _height:int = target.displayObject.height * matrix.d;
			
			//reset matrix
			matrix.a = 1;
			matrix.d = 1;
			target.displayObject.transform.matrix = matrix;
			
			target.displayObject.width = _width;
			target.displayObject.height = _height;
			
			_tfm.updateMatrix();
			var outputer:DisplayObjectInfoOutPuter = outputerManager.getOutputerByInstance(target.displayObject);
			this._des.htmlText = outputer.output(target.displayObject);
			
			dispatchEvent(new ComponentEvent(ComponentEvent.UPDATE_PROPERTY, this.target.displayObject));
		}
    }
}//package cn.itamt.utils.inspector.core.liveinspect 
