package ll.ui.managers.tooltip
{
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.getQualifiedClassName;
	
	import ll.ui.UIGlobals;
	import ll.ui.components.ToolTip;
	import ll.ui.core.dx_internal;
	import ll.ui.interfaces.IToolTip;
	import ll.ui.interfaces.IToolTipManagerClient;
	import ll.utils.HashMap;
	
	use namespace dx_internal;
	
	[ExcludeClass]
	
	/**
	 * 工具提示管理器实现类
	 * @author DOM
	 */	
	public class ToolTipManagerImpl extends EventDispatcher
	{
		/**
		 * 构造函数
		 */		
		public function ToolTipManagerImpl()
		{
			super();
		}
		/**
		 * 初始化完成的标志
		 */		
		private var initialized:Boolean = false;
		/**
		 * 用于鼠标经过一个对象后计时一段时间开始显示ToolTip
		 */		
		private var showTimer:Timer;
		/**
		 * 用于ToolTip显示后计时一段时间自动隐藏。
		 */		
		private var hideTimer:Timer;
		/**
		 * 用于当已经显示了一个ToolTip，鼠标快速经过多个显示对象时立即切换显示ToolTip。
		 */		
		private var scrubTimer:Timer;
		/**
		 * 当前的toolTipData
		 */		
		private var currentTipData:Object;
		/**
		 * 上一个ToolTip显示对象
		 */		
		private var previousTarget:IToolTipManagerClient;
		
		private var _currentTarget:IToolTipManagerClient;
		/**
		 * 当前的IToolTipManagerClient组件
		 */		
		public function get currentTarget():IToolTipManagerClient
		{
			return _currentTarget;
		}
		
		public function set currentTarget(value:IToolTipManagerClient):void
		{
			_currentTarget = value;
		}
		
		private var _currentToolTip:DisplayObject;
		/**
		 * 当前的ToolTip显示对象；如果未显示ToolTip，则为 null。
		 */		
		public function get currentToolTip():IToolTip
		{
			return _currentToolTip as IToolTip;
		}
		
		public function set currentToolTip(value:IToolTip):void
		{
			_currentToolTip = value as DisplayObject;
		}
		
		//private var _enabled:Boolean = true;
		/**
		 * 如果为 true，则当用户将鼠标指针移至组件上方时，ToolTipManager 会自动显示工具提示。
		 * 如果为 false，则不会显示任何工具提示。
		 */		
		/*public function get enabled():Boolean 
		{
		return _enabled;
		}
		
		public function set enabled(value:Boolean):void
		{
		if(_enabled==value)
		return;
		_enabled = value;
		if(!_enabled&&currentTarget)
		{
		currentTarget = null;
		targetChanged();
		previousTarget = currentTarget;
		}
		}*/
		
		private var _hideDelay:Number = 10000; 
		/**
		 * 自工具提示出现时起，ToolTipManager要隐藏此提示前所需等待的时间量（以毫秒为单位）。默认值：10000。
		 */		
		public function get hideDelay():Number 
		{
			return _hideDelay;
		}
		
		public function set hideDelay(value:Number):void
		{
			_hideDelay = value;
		}
		
		private var _scrubDelay:Number = 100; 
		/**
		 * 当第一个ToolTip显示完毕后，若在此时间间隔内快速移动到下一个组件上，就直接显示ToolTip而不延迟一段时间。默认值：100。
		 */		
		public function get scrubDelay():Number 
		{
			return _scrubDelay;
		}
		
		public function set scrubDelay(value:Number):void
		{
			_scrubDelay = value;
		}
		
		private var _showDelay:Number = 200;
		/**
		 * 当用户将鼠标移至具有工具提示的组件上方时，等待 ToolTip框出现所需的时间（以毫秒为单位）。
		 * 若要立即显示ToolTip框，请将toolTipShowDelay设为0。默认值：200。
		 */		
		public function get showDelay():Number 
		{
			return _showDelay;
		}
		public function set showDelay(value:Number):void
		{
			_showDelay = value;
		}
		
		private var _toolTipClass:Class = ToolTip;
		/**
		 * 全局默认的创建工具提示要用到的类。
		 */		
		public function get toolTipClass():Class 
		{
			return _toolTipClass;
		}
		
		public function set toolTipClass(value:Class):void
		{
			_toolTipClass = value;
		}
		/**
		 * 初始化
		 */		
		private function initialize():void
		{
			if (!showTimer)
			{
				showTimer = new Timer(20, 1);
				showTimer.addEventListener(TimerEvent.TIMER,
					showTimer_timerHandler);
			}
			
			if (!hideTimer)
			{
				hideTimer = new Timer(20, 1);
				hideTimer.addEventListener(TimerEvent.TIMER,
					hideTimer_timerHandler);
			}
			
			if (!scrubTimer)
				scrubTimer = new Timer(20, 1);
			
			initialized = true;
		}
		/**
		 * 注册需要显示ToolTip的组件
		 * @param target 目标组件
		 * @param oldToolTip 之前的ToolTip数据
		 * @param newToolTip 现在的ToolTip数据
		 */		
		dx_internal function registerToolTip(target:DisplayObject,
											 oldToolTip:Object,
											 newToolTip:Object):void
		{
			var hasOld:Boolean = (oldToolTip != null) && (oldToolTip != "");
			var hasNew:Boolean = (newToolTip !=null) && (newToolTip != "");
			if (!hasOld && hasNew)
			{
				target.addEventListener(MouseEvent.MOUSE_OVER,
					toolTipMouseOverHandler);
				target.addEventListener(MouseEvent.MOUSE_OUT,
					toolTipMouseOutHandler);
				if (mouseIsOver(target))
					showImmediately(target);
			}
			else if (hasOld&&!hasNew)
			{
				target.removeEventListener(MouseEvent.MOUSE_OVER,
					toolTipMouseOverHandler);
				target.removeEventListener(MouseEvent.MOUSE_OUT,
					toolTipMouseOutHandler);
				if (mouseIsOver(target))
					hideImmediately(target);
			}
		}
		/**
		 * 检测鼠标是否处于目标对象上
		 */		
		private function mouseIsOver(target:DisplayObject):Boolean
		{
			if (!target || !target.stage)
				return false;
			if ((target.stage.mouseX == 0)	 && (target.stage.mouseY == 0))
				return false;
			
			return target.hitTestPoint(target.stage.mouseX,
				target.stage.mouseY, true);
		}
		/**
		 * 立即显示ToolTip标志
		 */		
		private var showImmediatelyFlag:Boolean = false;
		/**
		 * 立即显示目标组件的ToolTip
		 */		
		private function showImmediately(target:DisplayObject):void
		{
			showImmediatelyFlag = true;
			checkIfTargetChanged(target);
			showImmediatelyFlag = false;
		}
		/**
		 * 立即隐藏目标组件的ToolTip
		 */		
		private function hideImmediately(target:DisplayObject):void
		{
			checkIfTargetChanged(null);
		}
		/**
		 * 检查当前的鼠标下的IToolTipManagerClient组件是否发生改变
		 */		
		private function checkIfTargetChanged(displayObject:DisplayObject):void
		{
			/*if (!enabled)
			return;*/
			
			findTarget(displayObject);
			
			if (currentTarget != previousTarget)
			{
				targetChanged();
				previousTarget = currentTarget;
			}
		}
		/**
		 * 向上遍历查询，直到找到第一个当前鼠标下的IToolTipManagerClient组件。
		 */		
		private function findTarget(displayObject:DisplayObject):void
		{
			while (displayObject)
			{
				if (displayObject is IToolTipManagerClient)
				{
					currentTipData = IToolTipManagerClient(displayObject).toolTip;
					if (currentTipData != null)
					{
						currentTarget = displayObject as IToolTipManagerClient;
						return;
					}
				}
				
				displayObject = displayObject.parent;
			}
			
			currentTipData = null;
			currentTarget = null;
		}
		
		/**
		 * 当前的IToolTipManagerClient组件发生改变
		 */		
		private function targetChanged():void
		{
			
			if (!initialized)
				initialize()
			
			/*if (previousTarget && currentToolTip)
			{
			if (currentToolTip is IToolTip)
			{
			event = new ToolTipEvent(ToolTipEvent.TOOL_TIP_HIDE);
			event.toolTip = currentToolTip;
			previousTarget.dispatchEvent(event);
			}
			else
			{
			if (hasEventListener(ToolTipEvent.TOOL_TIP_HIDE))
			dispatchEvent(new Event(ToolTipEvent.TOOL_TIP_HIDE));
			}
			}   */
			
			reset();
			
			if (currentTarget)
			{
				
				if (currentTipData==null||currentTipData == "")
					return;
				if (_showDelay==0||showImmediatelyFlag||scrubTimer.running)
				{
					createTip();
					initializeTip();
					positionTip();
					showTip();
				}
				else
				{
					showTimer.delay = _showDelay;
					showTimer.start();
				}
			}
		}
		/**
		 * toolTip实例缓存表
		 */		
		private var toolTipCacheMap:HashMap = new HashMap;
		/**
		 * 创建ToolTip显示对象
		 */		
		private function createTip():void
		{
			var tipClass:Class = currentTarget.toolTipClass;
			if(!tipClass)
			{
				tipClass = toolTipClass;
			}
			var key:String = getQualifiedClassName(tipClass);
			currentToolTip = toolTipCacheMap.get(key);
			if(!currentToolTip)
			{
				currentToolTip = new tipClass();
				toolTipCacheMap.put(key,currentToolTip);
			}
			if(currentToolTip is InteractiveObject)
				InteractiveObject(currentToolTip).mouseEnabled = false;
			if(currentToolTip is DisplayObjectContainer)
				DisplayObjectContainer(currentToolTip).mouseChildren = false;
		}
		/**
		 * 初始化ToolTip显示对象
		 */		
		private function initializeTip():void
		{
			if (currentToolTip is IToolTip)
				IToolTip(currentToolTip).toolTipData = currentTipData;
			
		}
		/**
		 * 设置ToolTip位置
		 */		
		private function positionTip():void
		{
			var x:Number, y:Number;
			var stage:Stage = UIGlobals.stage;
			
			var toolTipDp:DisplayObject = currentToolTip as DisplayObject;
			switch(currentTarget.toolTipLayout)
			{
				case ToolTipManager.AUTO://自动调节模式
				{
					if(toolTipDp.width + stage.mouseX <= stage.stageWidth)
					{//显示在右边
						x = stage.mouseX + 5;
					}else if(stage.mouseX - toolTipDp.width  >= 0){
						//显示在左边
						x = stage.mouseX - toolTipDp.width;
					}else{
						x = stage.mouseX - (toolTipDp.width >> 1);
					}
					
					if(toolTipDp.height + stage.mouseY < stage.stageHeight)
					{
						y = stage.mouseY;
					}else if(stage.stageHeight - toolTipDp.height >= 0)
					{
						y = stage.mouseY - toolTipDp.height;
					}else{
						y = stage.mouseY - (toolTipDp.height >> 1);
					}
					break;
				}
				case ToolTipManager.RIGHT_BOTTOM:
				{
					x = stage.mouseX;
					y = stage.mouseY;
					break;
				}
					
				case ToolTipManager.RIGHT_TOP:
				{
					x = stage.mouseX;
					y = stage.mouseY - toolTipDp.height;
					break;
				}
				case ToolTipManager.LEFT_BOTTOM:
				{
					x = stage.mouseX - toolTipDp.width;
					y = stage.mouseY;
					break;
				}
				case ToolTipManager.LEFT_TOP:
				{
					x = stage.mouseX - toolTipDp.width;
					y = stage.mouseY - toolTipDp.height;
					break;
				}
			}
			
			var offset:Point = currentTarget.toolTipOffset;
			if(offset)
			{
				x += offset.x;
				y += offset.y;
			}
			currentToolTip.x = x;
			currentToolTip.y = y;
		}
		/**
		 * 显示ToolTip
		 */		
		private function showTip():void
		{
			UIGlobals.stage.addEventListener(MouseEvent.MOUSE_DOWN,
				stage_mouseDownHandler);
			UIGlobals.stage.addChild(currentToolTip as DisplayObject);
		}
		/**
		 * 隐藏ToolTip
		 */		
		private function hideTip():void
		{
			if (currentToolTip && DisplayObject(currentToolTip).parent)
			{
				UIGlobals.stage.removeChild(currentToolTip as DisplayObject);
				currentToolTip.clear();
			}
				
			if (previousTarget)
			{
				UIGlobals.stage.removeEventListener(MouseEvent.MOUSE_DOWN,
					stage_mouseDownHandler);
			}
		}
		
		/**
		 * 移除当前的ToolTip对象并重置所有计时器。
		 */		
		private function reset():void
		{
			showTimer.reset();
			hideTimer.reset();
			if (currentToolTip)
			{
				if(currentToolTip)
				{
					UIGlobals.stage.removeChild(currentToolTip as DisplayObject);
					currentToolTip.clear();
				}
					
				currentToolTip = null;
				
				scrubTimer.delay = scrubDelay;
				scrubTimer.reset();
				if (scrubDelay > 0)
				{
					scrubTimer.delay = scrubDelay;
					scrubTimer.start();
				}
			}
		}
		/**
		 * 使用指定的ToolTip数据,创建默认的ToolTip类的实例，然后在舞台坐标中的指定位置显示此实例。
		 * 保存此方法返回的对 ToolTip 的引用，以便将其传递给destroyToolTip()方法销毁实例。
		 * @param toolTipData ToolTip数据
		 * @param x 舞台坐标x
		 * @param y 舞台坐标y
		 * @return 创建的ToolTip实例引用
		 */		
		public function createToolTip(toolTipData:Object, x:Number, y:Number):IToolTip
		{
			var toolTip:IToolTip = new toolTipClass() as IToolTip;
			
			UIGlobals.stage.addChild(toolTip as DisplayObject);
			
			toolTip.toolTipData = toolTipData;
			
			toolTip.x = x;
			toolTip.y = y;
			return toolTip;
		}
		
		/**
		 * 销毁由createToolTip()方法创建的ToolTip实例。 
		 * @param toolTip 要销毁的ToolTip实例
		 */		
		public function destroyToolTip(toolTip:IToolTip):void
		{
			UIGlobals.stage.removeChild(toolTip as DisplayObject);
			toolTip.clear();
		}
		
		/**
		 * 鼠标经过IToolTipManagerClient组件
		 */		
		private function toolTipMouseOverHandler(event:MouseEvent):void
		{
			checkIfTargetChanged(DisplayObject(event.target));
		}
		/**
		 * 鼠标移出IToolTipManagerClient组件
		 */		
		private function toolTipMouseOutHandler(event:MouseEvent):void
		{
			if(event.relatedObject == UIGlobals.stage)
				return;
			checkIfTargetChanged(event.relatedObject);
		}
		
		/**
		 * 显示ToolTip的计时器触发。
		 */		
		private function showTimer_timerHandler(event:TimerEvent):void
		{
			if (currentTarget)
			{
				createTip();
				initializeTip();
				positionTip();
				showTip();
			}
		}
		/**
		 * 隐藏ToolTip的计时器触发
		 */		
		private function hideTimer_timerHandler(event:TimerEvent):void
		{
			hideTip();
		}
		/**
		 * 舞台上按下鼠标
		 */		
		private function stage_mouseDownHandler(event:MouseEvent):void
		{
			reset();
		}
	}
	
}
