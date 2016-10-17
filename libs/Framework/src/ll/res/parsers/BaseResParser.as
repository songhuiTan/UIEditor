package ll.res.parsers
{
	import ll.res.data.ResData;
	
	import flash.utils.ByteArray;

	/**
	 * 基础资源解析类 
	 * @author silenxiao
	 * 
	 */	
	public class BaseResParser extends Object
	{
		/** 资源队列 */
		protected var resDataList:Vector.<ResData>;
		/** 解析中 **/
		protected var isParsing:Boolean;
		/** UI资源数据 */
		protected var _resData:ResData;
		
		/** 解析后得资源数据 */
		protected var _data:*;
		/** 解析完毕回调函数 */
		protected var parseCompleteCallFn:Function;
		/** 解析器中，所有的资源解析完毕 */
		protected var complete:Boolean;
		public function BaseResParser()
		{
			resDataList = new Vector.<ResData>();
		}
		
		/** 增加新的解析资源 */
		public function addResData(resData:ResData):void
		{
			if(resData.level > 0)
				resDataList.unshift(resData);
			else
				resDataList.push(resData);	
		}

		/** 尝试解析资源 */
		public function tryParse():void
		{
			if(isParsing)//正在解析
				return;
			if(resDataList.length == 0)
			{//资源解析完毕
				complete = true;
				return ;
			}
			complete = false;
			//载入一个新的
			_resData = resDataList.shift();
			//解析资源数据
			if(_resData.byteData)
				startParse(_resData.byteData);
		}
		
		/** 设置同步解析回调函数 */
		public function setParseCompleteCallFn(parseCompleteCallFn:Function):void
		{
			this.parseCompleteCallFn = parseCompleteCallFn;
		}
		
		/**
		 * 开始解析 
		 * @param byteData
		 * 
		 */		
		protected function startParse(byteData:ByteArray):void
		{
			isParsing = true;
		}
		
		/**
		 *  资源解析完毕
		 * 
		 */		
		protected function parseComplete():void
		{
			isParsing = false;	
			parseCompleteCallFn(this._resData, this._data);
			//解析下个资源
			tryParse();
		}
		
		public function isComplete():Boolean
		{
			return complete;
		}
		
		/**
		 * 是否同步解析 
		 * @return 
		 * 
		 */		
		public function isAsync():Boolean
		{
			return false;
		}
	}
}