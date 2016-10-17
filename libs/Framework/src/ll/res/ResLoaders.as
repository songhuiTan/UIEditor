package ll.res
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoaderDataFormat;
	import flash.utils.Dictionary;
	
	import ll.res.data.ResData;
	import ll.utils.Log;

	public class ResLoaders
	{
		/** 加载成功之后回调函数 **/
		private var completeFun:Function;
		/** 加载错误之后回调函数 **/
		private var errorFun:Function;
		/** 并发最大数 默认为3 **/
		private const MAX_LOAD_THREAD:int = 3;
		/** 重载次数，默认为1 **/
		private const MAX_RELOAD_NUM:int = 1;
		/** ByteLoader加载器列表 **/
		private var loaderList:Vector.<ResLoader>;
		/** 等待加载资源队列 **/
		private var waitLoadQueue:Vector.<ResData>;
		/** 错误重新次数记录集合 **/
		private var reLoadDic:Dictionary;
		/** 正在加载中的URLLoader集合 **/
		private var loaderDic:Dictionary;
		
		public function ResLoaders(completeFun:Function, errorFun:Function)
		{
			this.completeFun = completeFun;
			this.errorFun = errorFun;
			
			loaderList = new Vector.<ResLoader>();
			for (var i:int = 0; i < MAX_LOAD_THREAD; i++) 
			{
				var urlLoader:ResLoader = new ResLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
				urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onStatus);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR , onError);
				urlLoader.addEventListener(Event.COMPLETE, onStreamHandler);
				urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR , onError);
				urlLoader.addEventListener(ResLoader.TIMEOUT,onTimeOut);
				
				loaderList[i] = urlLoader;
			}
			waitLoadQueue = new Vector.<ResData>();
			reLoadDic = new Dictionary();
			loaderDic = new Dictionary();
		}
		
		/**
		 * 加载url。因为内部采用的并发加载，所以不保证加载的顺序 
		 * @param url
		 * @param priority
		 * 
		 */		
		public function load(resData:ResData, priority:Boolean):void
		{
			if(loaderList.length == 0)
			{
				if(priority)
				{
					waitLoadQueue.unshift(resData);
				}
				else
				{
					waitLoadQueue.push(resData);
				}
				return ;
			}
			//todo 这里都是采用删除和添加的方式来使用loader，如果有性能问题，采用index来获取loader
			var loader:ResLoader = loaderList.shift();
			loaderDic[resData.assetName] = loader;
			loader.loadResData(resData);
			resData.loader = loader;
			return 
		}
		
		/**
		 * 根据httpstatue状态判断是否加载成功 
		 * @param evt
		 * 
		 */		
		private function onStatus(evt:HTTPStatusEvent):void{
			if(evt.status == 404 || evt.status == 403){
				return;
			}
			
			var urlLoader:ResLoader = evt.target as ResLoader;
			if(evt.status == 200 && urlLoader.bytesLoaded != urlLoader.bytesTotal){
				onError(evt);
				return;
			}
			
			if(evt.status != 0 && evt.status != 200){
				//重新读取资源
				onTimeOut(evt);
				return;
			}
		}
		
		/**超时重新加入到加载队列中*/
		protected function onTimeOut(evt:Event):void
		{
			var urlloader:ResLoader = evt.target as ResLoader;
			var resData:ResData = urlloader.resData;
			resData.resetVersion();
			onError(evt);
		}
		
		private var reLoadCount:int = 0;
		/**
		 * 加载数据错误了 
		 * @param event
		 * 
		 */		
		private function onError(event:Event):void
		{
			var byteloader:ResLoader = event.target as ResLoader;
			var resData:ResData = byteloader.resData;
			
			
			if(reLoadDic[resData.assetName] != null)
			{
				reLoadCount = reLoadDic[resData.assetName];
			}
			reLoadCount++;
			if(reLoadCount > MAX_RELOAD_NUM)
			{
				delete loaderDic[resData.assetName];
				Log.log("加载错误，重载" + reLoadCount + "次，对应的路径没有数据：" + resData.assetName);
				errorFun(resData);
				reLoadCount = 0;
			}
			else
			{
				reLoadDic[resData.assetName] = reLoadCount;
				load(resData, resData.level > 0);
			}
			//超出重载次数，加载下一条
			nextLoad(byteloader);
		}
		
		/**
		 * 资源加载完毕 
		 * @param event
		 * 
		 */		
		private function onStreamHandler(event:Event):void
		{
			var byteloader:ResLoader = event.target as ResLoader;
			var resData:ResData = byteloader.resData;
			
			delete loaderDic[resData.assetName];
			
			if(reLoadDic[resData.assetName] != null)
				delete reLoadDic[resData.assetName];
			
			//回调
			resData.byteData = byteloader.data;
			resData.loader = null;
			completeFun(resData);
			nextLoad(byteloader);
		}
		
		
		private function nextLoad(byteLoad:ResLoader):void
		{
			if(waitLoadQueue.length > 0)
			{
				var resData:ResData = waitLoadQueue.shift();
				byteLoad.loadResData(resData);
			}
			else
			{
				//返回池
				loaderList.push(byteLoad);
			}
		}
		
		/**
		 * 停止加载指定的url 
		 * @param url
		 * 
		 */		
		public function stop(assetName:String):void
		{
			//正在加载中
			var byteLoad:ResLoader = loaderDic[assetName];
			if(byteLoad != null)
			{
				//停掉指定的loader
				delete loaderDic[assetName];
				
				if(reLoadDic[assetName] != null)
					delete reLoadDic[assetName];
				
				byteLoad.close();
				
				return ;
			}
			//删除等候列表
			var index:int = waitLoadQueue.indexOf(byteLoad.resData);
			if(index != -1)
			{
				waitLoadQueue.splice(index,1);
			}
		}
	}
}
