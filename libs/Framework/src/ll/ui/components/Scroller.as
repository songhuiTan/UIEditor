package ll.ui.components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import ll.ui.core.ScrollBar;
	import ll.ui.core.UIComponent;
	import ll.ui.interfaces.IScroll;
	
	/**
	 * 滚动容器组件 
	 * @author silenxiao
	 * 
	 */	
	public class Scroller extends Panel
	{
		public var scrollbar:ScrollBar;
		public function Scroller()
		{
			super();
		}
		
		private var _viewport:IScroll;
		public function set viewport(value:IScroll):void
		{
			if(value == _viewport)
			{
				return;
			}
			uninstallViewport();
			_viewport = value;
			installViewport();			
		}
		
		/**
		 * 卸载视域组件
		 */		
		private function uninstallViewport():void
		{
			if(_viewport)
			{
				var viewport:UIComponent = _viewport as UIComponent;
				this.removeChild(viewport);
				viewport.dispose();
			}
		}
		
		/**
		 * 安装并初始化视域组件
		 */		
		private function installViewport():void
		{
			_viewport.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			if(scrollbar)
			{
				scrollbar.viewport = _viewport;
			}
		}
		
		protected function onMouseWheel(evt:MouseEvent):void
		{
			var linestep:int = _viewport.mouseWheelLine;
			if(evt.delta > 0)
			{
				linestep = -linestep;
			}
			
			if(scrollbar)
			{
				var linepos:Number = scrollbar.linepos;
				linepos += linestep; 
				scrollbar.linepos = linepos;
			}
		}
		
		private var _scrollPos:Number = 0;
		public function scrollTo(value:Number):void
		{
			_scrollPos = value;
			if(scrollbar)
				scrollbar.scrollPos = value;
		}
		
		protected function onChange(evt:Event):void
		{
			var scrollPos:Number = scrollbar.scrollPos;
			
			var viewportx:int = scrollPos * (_viewport.height - this.height);
			
			if(_viewport.y == -viewportx)
				return;
			_viewport.y = -viewportx;
		}
		
		protected override function commitSize():void
		{
			super.commitSize();
			
			if(scrollbar == null)
			{
				scrollbar = new ScrollBar();
				scrollbar.viewport = _viewport;
				scrollbar.addEventListener(Event.CHANGE, onChange);
				this.addChild(scrollbar);
				if(_scrollPos != 0)
					scrollbar.scrollPos = _scrollPos;
			}
			scrollbar.height = _height;
			scrollbar.x = _width - scrollbar.width;
			
			this.scrollRect = new Rectangle(0, 0, _width, _height);
			if(_viewport){
				this.addChild(_viewport as UIComponent);
			}
		}
		
		
		
	}
}