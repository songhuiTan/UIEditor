package ll.ui.managers
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	import ll.ui.UIGlobals;
	import ll.ui.components.WindowModel;
	import ll.ui.core.UIComponent;
	import ll.ui.events.WindowEvent;

	public class PopUpManager
	{
		private static var instance:PopUpManager;
		public static function getInstance():PopUpManager
		{
			if(!instance)
			{
				instance = new PopUpManager();
			}
			
			return instance;
		}
		
		/** 窗口弹出层 */
		private var popupWinLayer:UIComponent;
		/** 窗口置顶层 */
		private var topWinLayer:UIComponent;
		/** 打开的窗口列表 */
		private var winList:Array;
		/** 当前活动窗口 */
		private var winActived:WindowModel;
		/**当前焦点窗口*/
		private var focusWin:WindowModel;
		
		public function initialLayer(popupWinLayer:UIComponent, topWinLayer:UIComponent):void
		{
			this.popupWinLayer = popupWinLayer;
			this.topWinLayer = topWinLayer;
			winList = [];
		}
		
		/**
		 * 弹出窗口 
		 * @param winType
		 * @param window
		 * 
		 */		
		public function addPopUp(winType:String, window:WindowModel):void
		{
			winInitial(winType, window);
			
			popupWinLayer.addChild(window);
			
			if(window.showHandler != null)
			{
				window.showHandler.call();
			}
		}
		
		/**
		 * 最上层增加窗口 
		 * @param winType
		 * @param window
		 * 
		 */		
		public function addTopWin(winType:String, window:WindowModel):void
		{
			winInitial(winType, window)
			topWinLayer.addChild(window);
			if(window.showHandler != null)
			{
				window.showHandler.call();
			}
		}
		
		private function winInitial(winType:String, window:WindowModel):void
		{
			window.winType=winType;
			winList[winType] = window;
			window.x = (UIGlobals.STAGEW - window.width) * window.xScale >> 0;
			window.y = (UIGlobals.STAGEH - window.height) * window.yScale >> 0;
			window.addEventListener(WindowEvent.ACTIVE, activeWinHandle);
			window.addEventListener(WindowEvent.CLOSE, closeWinHandle);
		}
		
		protected function closeWinHandle(evt:WindowEvent):void
		{
			var window:WindowModel = evt.target as WindowModel;
			
			window.removeEventListener(WindowEvent.CLOSE, closeWinHandle);
			window.removeEventListener(WindowEvent.ACTIVE, activeWinHandle);
			window.parent.removeChild(window);
			
			if(window.closeHandler != null)
			{
				window.closeHandler.call();
			}
			delete winList[window.winType]
		}
		
		protected function activeWinHandle(evt:WindowEvent):void
		{
			var win:WindowModel=evt.target as WindowModel;
			
			var parent:DisplayObjectContainer = win.parent;
			parent.setChildIndex(win, parent.numChildren - 1);
			
			if (win.hasFocus)
			{
				if (focusWin && focusWin != win)
				{
					focusWin.dispatchEvent(new WindowEvent(WindowEvent.FOCUS_OUT));
				}
				focusWin=win;
				focusWin.dispatchEvent(new WindowEvent(WindowEvent.FOCUS_IN));
			}
			winActived = win;
		}
		
		public function getFocusWin():WindowModel
		{
			return focusWin;
		}
		
		/**
		 * 判断面板是否已存在
		 */
		public function hasWin(type:String):Boolean
		{
			if (this.winList[type])
			{
				return true;
			}
			return false;
		}
		
		/**
		 * 根据名字获取窗口
		 * @param name
		 * @return
		 */
		public function getWinByName(type:String):WindowModel
		{
			if (hasWin(type))
			{
				return this.winList[type];
			}
			return null;
		}
		
		public function activeWin(type:String):WindowModel
		{
			var win:WindowModel = getWinByName(type);
			if (win == null)
				return null;
			winActived = win;
			popupWinLayer.setChildIndex(win, popupWinLayer.numChildren - 1);
			return win;
		}
		
		/**
		 * 根据类型关闭已存在的面板
		 */
		public function closeWinByType(type:String):void
		{
			var win:WindowModel=getWinByName(type);
			if (win == null)
				return;
			win.close();
		}
		
		public function closeActiviWin():void
		{
			if (winActived && winActived.isClosedByEsc)
				winActived.close();
		}
		
		/**关闭所有面板*/
		public function closeAllWindow():void
		{
			for each (var win:WindowModel in winList)
			{
				win.close();
			}
		}
		
		/**
		 * 重新布局窗口
		 */
		public function reLayout():void
		{
			for each (var win:WindowModel in winList)
			{
				win.x = (UIGlobals.STAGEW - win.width) * win.xScale >> 0;
				win.y = (UIGlobals.STAGEH - win.height) * win.yScale >> 0;
			}
		}
	}
}