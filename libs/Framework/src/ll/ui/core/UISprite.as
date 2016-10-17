package ll.ui.core
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	import ll.ui.UIGlobals;
	import ll.ui.interfaces.IDispose;
	import ll.ui.interfaces.IToolTipManagerClient;
	import ll.ui.interfaces.IUISprite;
	import ll.ui.managers.tooltip.ToolTipManager;
	import ll.utils.ColorTransKit;
	
	use namespace dx_internal;
	/**
	 * 继承于Sprite，是所有UI组件的的基础类，主要做了一下处理
	 * 1、增加了布局设置，可以设置四个角的位置，
	 * 2、从显示对象移除时，可以设置自动销毁资源
	 * 3、销毁对象时，对所监听的事件自动移除
	 * @author SilenXiao
	 * @date 2013-9-26
	 */
	public class UISprite extends Sprite implements IDispose, IToolTipManagerClient, IUISprite
	{
		/**储存注册的事件*/
		private var _uiListeners:Array;
		
		public function UISprite()
		{
			super();
			
			_uiListeners = [];
			/*if(!UIGlobals.stage)
			{
				if(stage)
				{
					onAddToStage();
				}else{
					addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
				}
			}*/
			this.addEventListener(Event.ADDED, onAdded);
		}
		
		/**
		 * 增加到舞台 
		 * @param evt
		 * 
		 */		
		/*private function onAddToStage(evt:Event = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			UIGlobals.init(stage);
		}*/
		
		/**
		 * 增加到显示列表
		 */
		private function onAdded(evt:Event):void
		{
			if(evt.target == this)
			{
				this.removeEventListener(Event.ADDED, onAdded);
				this.addEventListener(Event.REMOVED, onRemoved);
			}
		}
		
		/**
		 * 从显示列表中移除 
		 * @param evt
		 * 
		 */		
		private function onRemoved(evt:Event):void
		{
			if(evt.target == this)
			{
				this.removeEventListener(Event.REMOVED, onRemoved);
			}
		}
		
		private var _id:String;
		/**
		 * 设置组件的实例名 
		 * @return 
		 * 
		 */		
		public function get id():String
		{
			return _id || getQualifiedClassName(this);
		}
		
		
		public function set id(value:String):void
		{
			this._id = value;
		}
		
		/** 设置UI组件的位置
		 * @param value 字符串表示位置：x:y;
		 */
		public function set location(value:String):void
		{
			var param:Array = value.split(":");
			setLocation(param[0], param[1]);
		}
		
		public function setLocation(x:uint, y:uint):void
		{
			this.x = x;
			this.y = y;
		}
		
		private var _toolTip:Object;
		public function get toolTip():Object
		{
			return _toolTip;
		}
		
		public function set toolTip(value:Object):void
		{
			if(value == _toolTip)
				return;
			var oldValue:Object = _toolTip;
			
			_toolTip = value;
			ToolTipManager.registerToolTip(this, oldValue, value);
		}
		
		private var _toolTipClass:Class;
		public function get toolTipClass():Class
		{
			return _toolTipClass;
		}
		
		public function set toolTipClass(value:Class):void
		{
			if(value == _toolTipClass)
			{
				return;
			}
			var oldValue:Object = _toolTip;
			_toolTipClass = value;
			ToolTipManager.registerToolTip(this, oldValue, value);
		}
		
		
		private var _toolTipLayout:uint;
		public function get toolTipLayout():uint
		{
			return _toolTipLayout;
		}
		
		public function set toolTipLayout(value:uint):void
		{
			if(_toolTipLayout == value)
				return;
			_toolTipLayout = value;
		}
		
		private var _toolTipOffset:Point;
		public function get toolTipOffset():Point
		{
			return _toolTipOffset;
		}
		
		public function set toolTipOffset(value:Point):void
		{
			if(_toolTipOffset == value)
				return;
			_toolTipOffset = value;
		}
		
		/**
		 * 重写监听事件，将监听的事情保存，方便资源的自动释放 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 * 
		 */		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			if(!_uiListeners[type]){
				_uiListeners[type] = new Vector.<Function>;
				_uiListeners[type].push(listener);
			} else{
				var arr:Vector.<Function> = _uiListeners[type];
				var len:int = arr.length;
				for(var i:int = 0; i < len; i++){
					if(arr[i] == listener){//增加相同的事件函数
						return;
					}
				}
				_uiListeners[type].push(listener);
			}
			super.addEventListener(type,listener, useCapture,priority,useWeakReference);
		}
		
		/**
		 * 重写移除事件 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * 
		 */		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			if(!_uiListeners) return;
			super.removeEventListener(type, listener, useCapture);
			
			if(_uiListeners[type]){
				var arr:Vector.<Function> = this._uiListeners[type];
				if(arr){
					var index:int = arr.indexOf(listener);
					if(index != -1){
						arr.splice(index, 1);
						if(arr.length == 0){
							delete _uiListeners[type];
						}
					}
				}
			}
		}
		
		
		private var _viewXml:XML;
		public function set viewXml(xml:XML):void
		{
			this._viewXml = xml;
		}
		
		public function get viewXml():XML
		{
			return this._viewXml;
		}
		
		/**
		 * 移除当前UI组件上的所有监听事件 
		 * 
		 */		
		public function removeAllUIEvent():void
		{
			for(var type:String in _uiListeners){
				var arr:Vector.<Function> = this._uiListeners[type];
				while(arr.length > 0){
					this.removeEventListener(type,arr.pop() as Function);
				}
				delete _uiListeners[type];
			}
			_uiListeners = null;
		}
		
		public function removeAllChild():void
		{
			this.graphics.clear();
			
			while(numChildren > 0)
			{
				var child:IDispose = this.getChildAt(0) as IDispose;
				this.removeChildAt(0)
				if(child)
				{
					child.dispose();
				}
			}
		}
		
		private var _enable:Boolean = true;
		/**
		 * set/get 当前组件是否具有交互性 
		 * @param value
		 * 
		 */		
		public function set enable(value:Boolean):void
		{
			this._enable = value;
			this.filters = value ? null:[ColorTransKit.gray()];
		}
		
		/**
		 *  set/get 当前组件是否具有交互性 
		 * @return 
		 * 
		 */		
		public function get enable():Boolean
		{
			return this._enable;
		}
		
		
		/**
		 * 清理数据
		 */
		public function clear():void
		{
			
		}
		
		protected var _isDipose:Boolean;
		
		public function isDispose():Boolean
		{
			return this._isDipose;
		}
		
		public function dispose():void
		{
			this.removeAllUIEvent();
			this.removeAllChild();
			this._isDipose = true;
		}
	}
}