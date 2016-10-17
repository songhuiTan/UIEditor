package ll.ui.renderer
{
	import ll.ui.core.DataGroup;
	import ll.ui.core.UIComponent;
	import ll.ui.core.UISprite;
	import ll.ui.interfaces.IItemRenderer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public dynamic class ItemRenderer extends UIComponent implements IItemRenderer
	{
		/** 为了是整个呈现项响应鼠标事件，增加一张透明底图 */
		private var groundBmp:Bitmap;
		public function ItemRenderer()
		{
			super();
			
			groundBmp = new Bitmap(new BitmapData(1, 1, true, 0x0));
			this.addChild(groundBmp);
			
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
			this.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			this.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
		}
		
		protected var _data:Object;
		public function get data():Object
		{
			return _data;
		}
		
		/**
		 * 显示呈现项的数据 
		 * @param value
		 * 
		 */		
		public function set data(value:Object):void
		{
			/*if(this._data == value)
				return; */
			this._data = value;
			dataUpdateHandle(value);
		}
		
		/**
		 * 数据更新处理 
		 * @param value
		 * 
		 */		
		protected function dataUpdateHandle(value:Object):void
		{
			
		}
		
		protected var _selected:Boolean;
		public function get selected():Boolean
		{
			return _selected;
		}
		
		/**
		 * 呈现项是否被选中 
		 * @param value
		 * 
		 */		
		public function set selected(value:Boolean):void
		{
			if(this._selected == value)
				return;
			this._selected = value;
			selectedUpdateHandle(value)
		}
		
		/**
		 * 选中更新处理
		 */
		protected function selectedUpdateHandle(value:Boolean):void
		{
		}
		
		protected var _itemIdex:uint;
		public function get itemIndex():int
		{
			return _itemIdex;
		}
		
		/**
		 * 呈现项的索引值 
		 * @param value
		 * 
		 */		
		public function set itemIndex(value:int):void
		{
			_itemIdex = value;
		}
		
		public function get validated():Boolean
		{
			return _validated;
		}
		
		protected var _validated:Boolean = true;
		public function set validated(value:Boolean):void
		{
			this._validated = value;
		}
		
		protected var _owner:DataGroup;
		public function set owner(value:DataGroup):void
		{
			this._owner = value;
		}
		
		public function get owner():DataGroup
		{
			return this._owner;
		}
		
		protected function onMouseClick(evt:MouseEvent):void
		{
			this.selected = true;
		}
		
		protected function onRollOut(evt:MouseEvent):void
		{
			
		}
		
		protected function onRollOver(evt:MouseEvent):void
		{
			
		}
		
		public function get dragTarget():DisplayObject
		{
			return	null;
		}
			
		/**
		 *  设置呈现项的宽度 
		 * @param value
		 * 
		 */		
		override public function set width(value:Number):void
		{
			super.width = value;
			this.groundBmp.width = value;
		}
		
		/**
		 *  设置呈现项的高度 
		 * @param value
		 * 
		 */		
		override public function set height(value:Number):void
		{
			super.height = value;
			this.groundBmp.height = value;
		}
		
		override public function dispose():void
		{
			super.dispose();
			this.groundBmp.bitmapData.dispose();
			this.groundBmp = null;
		}
	}
}