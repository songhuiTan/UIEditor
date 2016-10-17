package ll.ui.core
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import ll.ui.UIGlobals;
	import ll.ui.interfaces.IUIComponent;
	
	/**
	 * ui组件类，所有组合ui类的基类 
	 * @author silenxiao
	 * 
	 */	
	public class UIComponent extends UISprite implements IUIComponent
	{
		protected var _validateSizeFlag:Boolean;
		
		public function UIComponent()
		{
			super();
		}
		
		protected var _width:Number = 0;
		public override function get width():Number
		{
			if(_width)
				return _width;
			if(_validateSizeFlag)
				validateNow();
			return super.width;
		}
		
		public override function set width(value:Number):void
		{
			if(this._width == value)
				return;
			this._width = value;
			validateSize();
		}
		
		
		protected var _height:Number = 0;
		public override function get height():Number
		{
			if(this._height)
				return this._height;
			if(_validateSizeFlag)
				validateNow();
			return super.height;
		}
		
		public override function set height(value:Number):void
		{
			if(this._height == value)
				return;
			this._height = value;
			validateSize();
		}
		
		/**
		 * 设置组件的大小 
		 * @param value
		 * 
		 */		
		public function set size(value:String):void
		{
			var param:Array = value.split(":");
			setsize(param[0], param[1]);
		}
		
		public function setsize(width:uint, height:uint):void
		{
			if(this._width == width && this._height == height)
			{
				return;
			}
			this._width = width;
			this._height = height;
			validateSize();
		}
		
		/**
		 * 大小发生改变，做标记 
		 * 
		 */		
		protected function validateSize():void
		{
			if(!_validateSizeFlag)
			{
				_validateSizeFlag = true;
				invalidateProperties();
			}
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		/**
		 * 属性改变，延迟处理 
		 * 
		 */		
		public function invalidateProperties():void
		{
			/*if(stage)
			{
				addEventListener(Event.RENDER,validateProperties);
				stage.invalidate();
			}
			else*/
			//{
				addEventListener(Event.ENTER_FRAME,validateProperties);
			//}
		}
		
		/** 子项大小发生改变 */
		protected var _validateChildSizeFlag:Boolean; 
		public function validateChildSizeChange():void
		{
			if(!_validateChildSizeFlag)
			{
				_validateChildSizeFlag = true;
				invalidateProperties();
			}
		}
		
		protected function validateProperties(evt:Event = null):void
		{
			removeEventListener(Event.ENTER_FRAME,validateProperties);
			commitProperties();
		}
		
		/**
		 * 处理应用变更属性
		 * 
		 */		
		protected function commitProperties():void
		{
			if(_validateSizeFlag)
			{
				commitSize();
				_validateSizeFlag = false
			}
			
			if(_validateChildSizeFlag)
			{
				refreshRender();
				_validateChildSizeFlag = false
			}
		}
		
		/**
		 * 标记父类需要大小变更
		 */
		public function validateParentSizeChange():void
		{
			if(this.parent && this.parent is UIComponent)
			{
				UIComponent(this.parent).validateChildSizeChange();
			}
		}
		
		//子类重写
		protected function refreshRender():void{}
		
		//子类重写
		protected function commitSize():void{}
		
		public function validateNow():void
		{
			validateProperties(null);
		}
		
		/*protected var _focusEnabled:Boolean
		public function set focusEnabled(value:Boolean):void
		{
		_focusEnabled = value;
		}
		
		public function get focusEnabled():Boolean
		{
		return _focusEnabled; 
		}*/
		
		
		public override function addChild(child:DisplayObject):DisplayObject
		{
			return addChildAt(child, numChildren);
		}
		
		public override function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			if(hasEventListener(Event.RESIZE))
			{
				var oldWidth:Number = this.width;
				var oldHight:Number = this.height;
				var display:DisplayObject =  super.addChildAt(child, index);
				if(oldWidth != this.width || oldHight != this.height)
					dispatchEvent(new Event(Event.RESIZE));
				return display;
			}else{
				return super.addChildAt(child, index);
			}
		}
		
		public override function removeChild(child:DisplayObject):DisplayObject
		{
			return removeChildAt(getChildIndex(child));
		}
		
		public override function removeChildAt(index:int):DisplayObject
		{
			if(hasEventListener(Event.RESIZE))
			{
				var oldWidth:Number = this.width;
				var oldHight:Number = this.height;
				var display:DisplayObject =  super.removeChildAt(index);
				if(oldWidth != this.width || oldHight != this.height)
					dispatchEvent(new Event(Event.RESIZE));
				return display;
			}else{
				return super.removeChildAt(index);
			}
		}
		
		/**
		 * 设置当前组件为当前场景焦点对象
		 * 
		 */		
		public function setFocus():void
		{
			if(UIGlobals.stage)
			{
				UIGlobals.stage.focus = this;
			}
		}
	}
}