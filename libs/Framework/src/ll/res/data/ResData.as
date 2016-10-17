package ll.res.data
{
	import ll.ui.UIGlobals;
	
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.utils.ByteArray;

	/**
	 * 外部加载数据结构 
	 * @author silenxiao
	 * 
	 */	
	public class ResData
	{
		public var level:uint;
		public var loader:URLLoader;
		public var targets:Array;
		public var completeFn:Vector.<Function>;
		public var errorFn:Vector.<Function>;

		//资源名字
		private var _assetName:String;
		/** 资源后缀 */
		public var suffix:String;

		/** 资源的二进制数据 */
		public var byteData:ByteArray;
		/** 资源是否加载完毕  */
		public var isAssetLoaded:Boolean;
		/** 资源是否解析完毕 */
		public var isAnalyzed:Boolean;
		
		public function ResData(assetName:String)
		{
			completeFn = new Vector.<Function>();
			errorFn = new Vector.<Function>();
			targets = [];
			this.assetName = assetName;
		}
		
		public function get bytesLoaded():uint
		{
			if(loader)
				return loader.bytesLoaded;
			return 0;
		}
		
		public function get bytesTotal():uint
		{
			if(loader)
				return loader.bytesTotal;
			return 0;
		}
		
		public function get url():String
		{
			return UIGlobals.path + _assetName + "?v=" + version;
		}
		
		/**
		 *  获取资源名字
		 */
		public function set assetName(value:String):void
		{
			if(this._assetName == value)
				return;
			this._assetName = value;
			var index:int = value.lastIndexOf(".");
			suffix = value.substr((index + 1)).toLowerCase();
		}
		
		public function get assetName():String
		{
			return this._assetName;
		}
		/**
		 * 重置版本号 
		 * 
		 */		
		public function resetVersion():void
		{
			var tmp:int = int(_version);
			tmp++;
			_version = tmp.toString();
		}
		
		private var _version:String;
		/**
		 * 获取资源的版本号 
		 * @return 
		 * 
		 */		
		public function get version():String
		{
			if(!_version)
			{//从配置中获取版本号
					
			}
			return _version;
		}
		
		public function dispose():void
		{
			this.loader = null;
			if(this.byteData is ByteArray)
			{
				ByteArray(this.byteData).clear();
			}
			this.byteData = null;
		}
	}
}