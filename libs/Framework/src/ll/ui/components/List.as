package ll.ui.components
{
	import ll.ui.collections.ICollection;
	import ll.ui.core.DataGroup;
	import ll.ui.interfaces.IItemRenderer;
	import ll.ui.interfaces.IScroll;
	import ll.ui.renderer.ItemRenderer;
	import ll.ui.renderer.ListRenderer;
	
	/**
	 *  列表组件 
	 * @author silenxiao
	 * 
	 */	
	public class List extends DataGroup implements IScroll
	{
		/** 垂直排版 */
		public const LAYOUT_VERTICAL:uint = 0;
		/** 水平排版 */
		public const LAYOUT_HORIZON:uint = 1;
		public function List()
		{
			super();
			
			this.itemRenderer = ListRenderer;
		}
		
		override protected function commitDisplayList():void
		{
			const length:uint = indexToRenderer.length;
			if(_layoutType == LAYOUT_VERTICAL)
			{
				for(var i:uint = 0; i < length; i++)
				{
					var renderer:ItemRenderer = indexToRenderer[i];
					renderer.y = i * (renderer.height + this._vSpace);
				}
				if(renderer){
					setsize(renderer.width, i * (renderer.height + this._vSpace));
				}
			}else{
				for(i= 0; i < length; i++)
				{
					renderer = indexToRenderer[i];
					renderer.x = i * (renderer.width + this._hSpace);
				}
				if(renderer){
					setsize(i * (renderer.width + this._hSpace),  renderer.height);
				}
			}
		}
		
		protected var _layoutType:uint;
		/**
		 * 设置List的排版类型 
		 * @param value LAYOUT_VERTICAL垂直排版，LAYOUT_HORIZON水平排版
		 * 
		 */		
		public function set layoutType(value:uint):void
		{
			_layoutType = value;	
		}
		
		public function get layoutType():uint
		{
			return _layoutType;
		}
		
		protected var _mouseWheelLine:int = 3;
		
		/**
		 * 滚轮滚动，滚动的行数 
		 * @param value
		 * 
		 */		
		public function set mouseWheelLine(value:int):void
		{
			this._mouseWheelLine = value;
		}
		
		public function get mouseWheelLine():int
		{
			return this._mouseWheelLine;
		}
		
		/**
		 * 每行的宽度 
		 * @return 
		 * 
		 */		
		public function get lineWidth():int
		{
			if(indexToRenderer.length > 0)
				return indexToRenderer[0].width;
			return 20;
		}
		
		/**
		 * 每行的高度 
		 * @return 
		 * 
		 */		
		public function get lineHeight():int
		{
			if(indexToRenderer.length > 0)
				return indexToRenderer[0].height+_vSpace;
			return 20+_vSpace;//不能默认返回0，否则scroll的值有问题
		}
		
		
		protected var _defaultDataStr:String = "";
		
		/**
		 * 默认数据字符串
		 * @param value
		 */		
		public function set defaultDataStr(value:String):void
		{
			this._defaultDataStr = value;
			if(dataProvider){
				var dp:ICollection=dataProvider;
				dp.source=value.split(",");
			}
		}
		
		public function get defaultDataStr():String
		{
			return this._defaultDataStr;
		}
	}
}