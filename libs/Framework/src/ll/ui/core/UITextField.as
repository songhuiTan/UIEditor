package ll.ui.core
{
	import avmplus.getQualifiedClassName;
	
	import flash.text.TextField;
	
	import ll.ui.DefaultUIComponent;
	import ll.ui.UIGlobals;
	import ll.ui.interfaces.IDispose;
	import ll.ui.interfaces.IUIComponent;
	
	use namespace dx_internal;
	
	[ExcludeClass]
	public class UITextField extends TextField implements IUIComponent, IDispose
	{
		protected var onLinkCallBackFn:Function;
		/**储存注册的事件*/
		private var _uiListeners:Array;
		public function UITextField()
		{
			this._uiListeners = [];//事件监听的使用要用
			super();
			
//			this._uiListeners = [];
			this.filters = DefaultUIComponent.TEXT_FILTER;
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
		
		public function set size(value:String):void
		{
			var param:Array = value.split(":");
			setsize(param[0], param[1]);
		}
		
		public function setsize(width:uint, height:uint):void
		{
			this.width = width;
			this.height = height;
		}
		
		public function setFocus():void
		{
			if(UIGlobals.stage)
			{
				UIGlobals.stage.focus = this;
			}
		}
		
		public function set enable(value:Boolean):void
		{
			this.mouseWheelEnabled = value;
			this.mouseEnabled = value;
			this.selectable = value;
		}
		
		public function get enable():Boolean
		{
			throw new Error("UITextFiled组件无enabel属性返回");
			return false;
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
		
		
		public function clear():void
		{
			this.text = "";
		}
		
		protected var _isDipose:Boolean;
		public function isDispose():Boolean
		{
			return this._isDipose;
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
		
		public function dispose():void
		{
			removeAllUIEvent();
		}
	}
}