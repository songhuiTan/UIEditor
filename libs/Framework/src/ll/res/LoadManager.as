package ll.res
{
	import ll.timer.TimerManager;
	import ll.res.data.ResData;
	import ll.res.parsers.BaseResParser;
	import ll.res.parsers.LoadResParser;
	import ll.res.parsers.TextResParser;
	import ll.utils.HashMap;
	
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	public class LoadManager
	{
		private static var instance:LoadManager = new LoadManager();
		
		/** 资源池 */
		private var resDataPool:Dictionary;
		/** 加载资源的数据结构 **/
		private var resDatas:Dictionary;
		/** 加载器列表，并发3组*/
		private var bytesLoaders:ResLoaders;
		
		/** 等待解析的列表 **/
		private var waitParseQueue:Vector.<BaseResParser>;
		/** 解析集合 **/
		private var parsers:HashMap;
		/** 是否已经在时间管理器中 **/
		private var addTimer:Boolean;
		/** 单个解析器的最大解析时间(毫秒) **/
		private const FRAME_TIME:int = 10;
		
		public function LoadManager()
		{
			resDataPool = new Dictionary();
			waitParseQueue = new Vector.<BaseResParser>();
			
			//添加默认的解析器
			parsers = new HashMap();
			addParser(new TextResParser(),"bin");
			addParser(new LoadResParser(),"png","jpg", "swf");
			bytesLoaders = new ResLoaders(completeFun, errorFun);
			
			addTimer = true;
		}
		
		public function addParser(parser:BaseResParser,...parseTypes):void
		{
			for (var i:int = 0; i < parseTypes.length; i++) 
			{
				//统一变成小写
				parsers.put(parseTypes[i].toLowerCase(),parser);
				parser.setParseCompleteCallFn(onParseComplete);
			}
		}
		/**
		 * 加载资源 
		 * @param assetName 资源名字
		 * @param complete 资源加载完毕后回调函数
		 * @param target 资源所属的目标对象
		 * @param error 资源加载错误回调函数
		 * @param level 资源是否优先加载
		 * @return 
		 * 
		 */		
		public static function load(assetName:String, complete:Function=null, target:*=null, error:Function=null, level:uint = 0):ResData
		{
			return instance.load(assetName,complete,target,error,level);
		}
		
		private function load(assetName:String, complete:Function=null, target:*=null, error:Function=null, level:uint = 0):ResData
		{
			var resData:ResData = resDataPool[assetName];
			if(!resData)
			{
				resData = new ResData(assetName);
				resDataPool[assetName] = resData;
				bytesLoaders.load(resData, level > 0);
			}
			resData.level = level;
			resData.completeFn.push(complete);
			resData.errorFn.push(error);
			resData.targets.push(target);
			return resData;
		}
		
		/**
		 * 取消加载资源 
		 * @param assetName
		 * @param complete
		 * 
		 */		
		public static function cancel(assetName:String, complete:Function):void
		{
			return instance.cancel(assetName,complete);
		}
		
		private function cancel(assetName:String, complete:Function):void
		{
			var resData:ResData = resDataPool[assetName];
			if(resData != null)
			{
				for (var i:int = 0; i < resData.completeFn.length; i++) 
				{
					if(resData.completeFn[i] == complete)
					{
						resData.completeFn.splice(i,1);
						break;
					}
				}
				if(resData.completeFn.length == 0)
				{
					delete resDataPool[assetName];
					resData.dispose();
					//停止加载
					bytesLoaders.stop(assetName);
				}
			}
		}
		
		/**
		 * 资源二进制加载完毕回调函数处理 
		 * 
		 */		
		private function completeFun(resData:ResData):void
		{
			//借出新的解析器
			var parser:BaseResParser = parsers.get(resData.suffix);
			if(parser == null)
			{
				//直接返回二进制数据
				onParseComplete(resData, resData.byteData);
				return ;
			}
			
			parser.addResData(resData);
			if(parser.isAsync())
			{
				//尝试解析加载文件
				parser.tryParse();
			}
			else
			{
				//存放到循环渐变解析中
				waitParseQueue.push(parser);
				//进行循环解析
				if(addTimer)
				{
					addTimer = false;
					TimerManager.add(20,onTimer);
				}
			}
		}
		
		private var time:uint;
		private function onTimer():void
		{
			time = getTimer() + FRAME_TIME;
			var parser:BaseResParser = null;
			for (var i:int = 0; i < waitParseQueue.length; i++) 
			{
				parser = waitParseQueue[i];
				
				//尝试开始新的加载
				parser.tryParse();
				if(parser.isComplete())
				{
					//解析完毕
					waitParseQueue.splice(i, 1);
					i--;
				}
				if (getTimer() >= time) break;
			}
			if(waitParseQueue.length == 0)
			{
				addTimer = true;
				TimerManager.remove(onTimer);
			}
		}
		
		private function onParseComplete(resData:ResData, data:*):void
		{
			//先进行清除，预防回调里有再次使用到ResManager
			delete resDataPool[resData.assetName];
			//遍历，广播出去
			var len:int = resData.completeFn.length;
			for (var i:int = 0; i < len; i++) 
			{
				if(resData.completeFn[i])
				{
					if(resData.targets[i] == null)
					{
						resData.completeFn[i](data);
					}
					else
					{
						resData.completeFn[i](data,resData.targets[i]);
					}	
				}
			}
			resData.dispose();
		}
		
		/**
		 * 资源二进制加载错误回调函数处理 
		 * 
		 */	
		private function errorFun(resData:ResData):void
		{
			delete resDataPool[resData.assetName];
			
			var len:int = resData.errorFn.length;
			for (var i:int = 0; i < len; i++) 
			{
				if(resData.errorFn[i])
				{
					if(resData.targets[i] == null)
					{
						resData.errorFn[i](resData);
					}
					else
					{
						resData.errorFn[i](resData,resData.targets[i]);
					}
				}
			}
			resData.dispose();
		}
	}
}