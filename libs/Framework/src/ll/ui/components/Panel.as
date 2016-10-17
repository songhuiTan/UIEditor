package ll.ui.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import ll.ui.core.UIComponent;
	import ll.ui.interfaces.IScroll;
	
	/**
	 * 面板组件，可以设置其背景资源 
	 * @author silenxiao
	 * 
	 */	
	public class Panel extends UIComponent implements IScroll
	{
		protected var _image:Image;
		public function Panel()
		{
			super();
		}
		
		protected var _validateImgFlag:Boolean;
		/**
		 * 设置图片资源的名字
		 * @param value [value为图片文字，从域中加载资源； 为路径是，动态加载资源]
		 */
		public function set assetName(value:String):void
		{
			if(!_image)
			{
				_image = new Image();
				this.addChildAt(_image,0);
				_image.callBackFnOnloaded = callBackFnImg;
			}
			_assetName=value;
			_image.assetName = value;
		}
		protected  var _assetName:String="";
		
		public function get assetName():String
		{
			return _assetName;
		}
		
		protected function callBackFnImg():void
		{
			_validateImgFlag = true;
			invalidateProperties();
		}
		
		protected override function commitSize():void
		{
			if(_validateImgFlag)
			{
				_image.setsize(this._width, this._height);
				_image.validateNow();
			}
		}
		
	
		
		protected var _mouseWheelLine:int = 3;
		public function set mouseWheelLine(value:int):void
		{
			this._mouseWheelLine = value;
		}
		
		public function get mouseWheelLine():int
		{
			return this._mouseWheelLine;
		}
		
		public function get lineWidth():int
		{
			return _lineWidth;
		}
		
		private var _lineWidth:int = 20;
		public function set lineWidth(value:int):void
		{
			this._lineWidth = value;
		}
		
		public function get lineHeight():int
		{
			return _lineHeight;
		}
		
		private var _lineHeight:int = 20;
		public function set lineHeight(value:int):void
		{
			this._lineHeight = value;
		}
		
	}
}