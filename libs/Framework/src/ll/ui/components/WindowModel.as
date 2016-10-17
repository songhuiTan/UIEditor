package ll.ui.components
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import ll.ui.UIGlobals;
	import ll.ui.events.WindowEvent;

	public class WindowModel extends Panel
	{
		/**
		 * 是否需要焦点判断 聊天窗口用到 
		 */		
		public var hasFocus:Boolean = false;
		
		/** 是否允许拖拽 */
		public var allowDrag:Boolean = true;
		
		/** 是否响应Esc按键关闭窗口 */
		public var isClosedByEsc:Boolean = true;
		
		/** 拖拽时，是否透明处理 */
		public var isDragAlpha:Boolean = true;
		
		/** 设置拖拽的鼠标响应区域 */
		public var dragRect:Rectangle;

		/** 设置拖拽的鼠标响应区域的高度 */
		public const DRAG_RECT_HEIGHT: uint = 30
		
		/**位置比例*/
		public var xScale:Number = 0.5, yScale:Number = 0.5;

		/** 显示窗口的回调函数 */
		public var showHandler:Function;
		
		/** 关闭窗口回调函数 */
		public var closeHandler:Function;
		public function WindowModel()
		{
			initListener();
		}
		
		/**
		 * 初始化鼠标事件
		 */
		protected function initListener():void
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, toDrag);
			this.addEventListener(MouseEvent.MOUSE_UP, endDrag);
		}
		
		protected function toDrag(evt:MouseEvent):void
		{
			//置当前点击的窗口为被激活窗口
			this.dispatchEvent(new WindowEvent(WindowEvent.ACTIVE));//不能拖动，但需要响应事件
			
			if(!allowDrag)
				return;
			//判断当前鼠标点击位置是否处于拖动区域
			var pt:Point = new Point(evt.localX,evt.localY);
			if(evt.target != evt.currentTarget && evt.currentTarget == this)
			{
				pt = DisplayObject(evt.currentTarget).globalToLocal(DisplayObject(evt.target).localToGlobal(pt));
			}else{
				if(evt.target !=this)
					return;
			}
			if(!dragRect)
			{
				dragRect = new Rectangle(0, 0, this.width, 40);
			}
			if(!dragRect.contains(pt.x, pt.y))
				return;
			
			if(this.isDragAlpha)
				this.alpha = 0.6;
			
			this.startDrag(false,new Rectangle(-width * .5,0, UIGlobals.stage.stageWidth, UIGlobals.stage.stageHeight - 40));
		}
		
		protected function endDrag(evt:MouseEvent):void
		{
			this.stopDrag();
			
			this.x >>= 0;
			this.y >>= 0;
			this.xScale = this.x / (UIGlobals.stage.stageWidth - this.width);
			this.yScale = this.y / (UIGlobals.stage.stageHeight - this.height);
			if(this.xScale < 0) 
				this.xScale = 0;
			else 
				if(this.xScale > 1) 
					this.xScale = 1;
			
			if(this.yScale < 0) 
				this.yScale = 0;
			else 
				if(this.yScale > 1) 
					this.yScale = 1;
			this.alpha = 1;
		}
		
		
		protected override function commitSize():void
		{
			super.commitSize();
			this.dragRect = new Rectangle(0, 0, width, DRAG_RECT_HEIGHT);
		}
		
		private var _winType:String;
		public function set winType(value:String):void
		{
			_winType = value;
		}
		
		public function get winType():String
		{
			return _winType || id;
		}
		
		/**
		 * 关闭窗口是否释放资源 
		 * @param isDispose
		 * 
		 */		
		public function close(isDispose:Boolean = false):void{
			this.stopDrag();
			this.dispatchEvent(new WindowEvent(WindowEvent.CLOSE));
			isDispose && dispose()
		}
	}
}