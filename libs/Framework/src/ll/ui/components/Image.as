package ll.ui.components
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	
	import ll.ui.core.ScaleBitmap;
	import ll.ui.managers.AssetsManager;

	/**
	 * 位图组件，可以设置资源为外部资源 or 内部资源 
	 * @author silenxiao
	 * 
	 */	
	public class Image extends ScaleBitmap
	{
		public function Image()
		{
			super();
		}
		
		private var _id:String="";
		/**
		 * 设置Image的实例名 
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
		/**
		 * 设置图片资源名字，已经图片资源加载完成后的回调函数 
		 * @param fn
		 * @param value
		 * 
		 */		
		public function setAssetName(fn:Function, value:String):void
		{
			this._callBackFn = fn;
			this.assetName = value;
		}
		
		/**
		 * 设置图片资源的名字
		 * @param value [value为图片文字，从域中加载资源； 为路径是，动态加载资源]
		 */
		public function set assetName(value:String):void
		{
			if(value == null || value == "")
				return;
			_assetName=value
			this.scale9Grid = AssetsManager.getInstance().getImgScale9Grid(value);
			AssetsManager.getInstance().loadBmpData(value, onAssetLoaded);
		}
		
		protected var _assetName:String="";
		public function get assetName():String
		{
			return _assetName;
		}
		
		protected var _callBackFn:Function;
		
		/**
		 * 设置图片资源加载完毕后回调函数，注：此赋值必须在assetName赋值前
		 * @param fn
		 * 
		 */		
		public function set callBackFnOnloaded(fn:Function):void
		{
			this._callBackFn = fn;
		}
		
		public function setLocation(x:uint, y:uint):void
		{
			this.x = x;
			this.y = y;
		}
		
		protected function onAssetLoaded(bmp:BitmapData):void
		{
			if(this._isDipose)
			{
				return;
			}
			this.bitmapData = bmp;
			if(_callBackFn != null)
			{
				_callBackFn.call();
			}
		}
	}
}