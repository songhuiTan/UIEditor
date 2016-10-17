package ll.ui.core
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import ll.ui.DefaultUIComponent;
	import ll.ui.UIGlobals;
	import ll.ui.UIType;
	import ll.ui.components.Button;
	import ll.ui.components.Panel;
	import ll.ui.interfaces.IScroll;
	
	/**
	 *  滚动条组件 
	 * @author silenxiao
	 * 
	 */	
	public class ScrollBar extends UIComponent
	{
		private var _btnUp:Button;
		private var _btnDown:Button;
		private var _panelTrack:Panel;
		private var _btnTrack:Button;
		public function ScrollBar()
		{
			super();
			_scrollPos=0;
			intialDisplayList();
			initalMouseClick();
		}
		
		private function intialDisplayList():void
		{
			_btnUp = DefaultUIComponent.createButton(this, UIType.BTN_SCROLL_UP);
			
			_btnDown = DefaultUIComponent.createButton(this, UIType.BTN_SCROLL_DOWN);
			
			_btnTrack = DefaultUIComponent.createButton(this, UIType.BTN_SCROLL_TRACK);
			
			_panelTrack = new Panel();
			this.addChild(_panelTrack);
		}
		
		private function initalMouseClick():void
		{
			_btnUp.addEventListener(MouseEvent.CLICK, onBtnClick);
			_btnDown.addEventListener(MouseEvent.CLICK, onBtnClick);
			_btnTrack.addEventListener(MouseEvent.MOUSE_DOWN, onBtnMouseDown);
			_panelTrack.addEventListener(MouseEvent.CLICK, onTrackMouseDown);
		}
		
		private var _viewport:IScroll;
		public function set viewport(value:IScroll):void
		{
			if(value){
				this._viewport = value;
				this._viewport.addEventListener(Event.RESIZE, onViewportResize);
			}
			if(!_validateSizeFlag)
				viewSizeUpdate();
		}
		
		
		private function onViewportResize(evt:Event):void
		{
			if(!_validateSizeFlag)
				viewSizeUpdate();
		}
		
		
		/** 滑块的最大y坐标和最小值y坐标 */
		private var _maxTrackBtnY:int, _minTrackBtnY:int;
		
		private var _maxTrackHeight:int;
		/**
		 * 重置滚动条的步进值 
		 * 
		 */		
		private function resetStepvalue():void
		{
			/*var trackBtnHeight:int
			if(_viewport){
				trackBtnHeight= int(this.height * this.height / _viewport.height);
			}
			
			if(trackBtnHeight < 10)
				trackBtnHeight = 10;
			_btnTrack.height = trackBtnHeight;*/
			//滑块的最小，最大位置
			_minTrackBtnY = this._btnUp.height;
			_maxTrackBtnY = this.height - _btnTrack.height - this._btnDown.height - _minTrackBtnY;
			
			//定位滑块的位置
			_btnTrack.y = _scrollPos * _maxTrackBtnY + _minTrackBtnY;
			
			if(_viewport){
				_maxTrackHeight = this._viewport.height - this.height<0?0:this._viewport.height - this.height;
			}
			if(_maxTrackHeight <= 0)
			{
				_btnTrack.visible = false;
			}else{
				_btnTrack.visible = true;
			}
		}
		
		private function viewSizeUpdate():void
		{
			_maxTrackHeight = this._viewport.height - this.height;
			if(_maxTrackHeight <= 0)
			{
				_btnTrack.visible = false;
			}else{
				_btnTrack.visible = true;
			}
			if(_maxTrackHeight>0){
				linepos = _scrollPos * _maxTrackHeight / _viewport.lineHeight;
			}
		}
		
		private function onBtnClick(evt:MouseEvent):void
		{
			var target:Button = evt.target  as Button;
			var line:int = _linepos;
			if(_btnUp == target)
			{
				line -= 1;
			}else{
				line += 1;
			}
			linepos = line;
		}
		
		private var _linepos:Number = 0;
		/**
		 * 设置滚动的行数
		 */
		public function set linepos(value:Number):void
		{
			if(_linepos == value)
				return;
			_linepos = value;
			
			if(_linepos < 0)
			{
				_linepos = 0;
			}
			var tmp:Number;
			if(_viewport){
				tmp = _linepos * _viewport.lineHeight / _maxTrackHeight;
				if(tmp > 1)
				{
					_linepos = _maxTrackHeight / _viewport.lineHeight
					scrollPos = 1;
				}else{
					scrollPos = tmp;
				}
			}
			
			
		}
		
		public function get linepos():Number
		{
			return _linepos;
		}
		
		private var _scrollPos:Number// = 0;
		/**
		 * 设置滚动的位置(0 ~ 1);
		 */
		public function set scrollPos(value:Number):void
		{
			/*if(this._scrollPos == value)
				return;*/
			var trackBtnOffsetY:Number = value * _maxTrackBtnY;
			
			if(trackBtnOffsetY < 0)
			{
				trackBtnOffsetY = 0;
				value = 0;
			}
			if(trackBtnOffsetY > _maxTrackBtnY)
			{
				trackBtnOffsetY = _maxTrackBtnY;
				value = 1;
			}
			_btnTrack.y = trackBtnOffsetY + _minTrackBtnY;
			
			this._scrollPos = value;
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get scrollPos():Number
		{
			return _scrollPos;
		}
		
		/**
		 * 记录鼠标在thumb上按下的位置
		 */		
		private var _clickOffset:Point;
		private var _oldTrackY:uint;
		private function onBtnMouseDown(evt:MouseEvent):void
		{
			UIGlobals.stage.addEventListener(MouseEvent.MOUSE_MOVE, 
				onStageMouseMove, false,0,true);
			UIGlobals.stage.addEventListener(MouseEvent.MOUSE_UP, 
				onStageMouseUp, false,0,true);
			UIGlobals.stage.addEventListener(Event.MOUSE_LEAVE,
				onStageMouseUp, false,0,true);
			
			_clickOffset = this.globalToLocal(new Point(UIGlobals.stage.mouseX, UIGlobals.stage.mouseY));
			_oldTrackY = this._btnTrack.y;
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		/**
		 * 鼠标移动事件
		 */
		private function onStageMouseMove(evt:MouseEvent):void
		{
			if (needUpdateValue)
				return;
			needUpdateValue = true;
		}
		
		private function onStageMouseUp(evt:Event):void
		{
			UIGlobals.stage.removeEventListener(MouseEvent.MOUSE_MOVE, 
				onStageMouseMove);
			UIGlobals.stage.removeEventListener(MouseEvent.MOUSE_UP, 
				onStageMouseUp);
			UIGlobals.stage.removeEventListener(Event.MOUSE_LEAVE,
				onStageMouseUp);
			removeEventListener(Event.ENTER_FRAME,updateWhenMouseMove);
			
			if(needUpdateValue)
			{
				updateWhenMouseMove();
				needUpdateValue = false;
			}
		}
		
		/**
		 * 当鼠标拖动thumb时，需要更新value的标记。
		 */		
		private var needUpdateValue:Boolean = false;
		/**
		 * 拖动thumb过程中触发的EnterFrame事件
		 */		
		private function onEnterFrame(event:Event):void
		{
			if(!needUpdateValue)
				return;
			updateWhenMouseMove();
			needUpdateValue = false;
		}
		
		/**
		 * 当thumb被拖动时更新值，此方法每帧只被调用一次，比直接在鼠标移动事件里更新性能更高。
		 */		
		protected function updateWhenMouseMove():void
		{
			var p:Point = this.globalToLocal(new Point(UIGlobals.stage.mouseX, UIGlobals.stage.mouseY));
			
			var offsetleft:int = p.x - _clickOffset.x;
			var offsetRight:int = p.y - _clickOffset.y;
			if(offsetleft > 200 || offsetleft < -200 || offsetRight > 200 || offsetRight < -200)
			{
				needUpdateValue = false
				onStageMouseUp(null);
				return;
			}
			
			var tmpScrollPos:Number = (offsetRight + _oldTrackY - _minTrackBtnY)  * 1.0/ _maxTrackBtnY;
			if(_viewport){
				linepos = tmpScrollPos * _maxTrackHeight / _viewport.lineHeight;
			}
		}
		
		/**
		 * 当在滑块轨迹上按下鼠标时记录被按下的子显示对象
		 */
		protected function onTrackMouseDown(evt:MouseEvent):void
		{
			var p:Point = _panelTrack.globalToLocal(new Point(evt.stageX, evt.stageY));
			
			var tmpScrollPos:Number = (p.y - _minTrackBtnY) / _maxTrackBtnY;
			linepos = tmpScrollPos * _maxTrackHeight / _viewport.lineHeight;
		}
		
		/**
		 * 大小发生改变时 
		 * 
		 */		
		protected override function commitSize():void
		{
			_panelTrack.setsize(_btnUp.width + 4, _height);
			_panelTrack.x = 2;
			
			_btnDown.y = _height - _btnDown.height;
			
			if(_btnTrack.y == 0)
			{
				_btnTrack.y = _btnUp.height;
			}
			resetStepvalue();
		}
		
		
		public override function get width():Number
		{
			if(super.width == 0)
			{
				if(_btnUp)
				{
					return _btnUp.width + 4;
				}
			}
			return super.width;
		}
		
	}
}