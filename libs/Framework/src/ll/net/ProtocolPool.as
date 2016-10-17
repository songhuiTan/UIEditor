package ll.net
{
	import flash.utils.Dictionary;
	
	import ll.evt.NetEvent;
	import ll.net.core.ProtocolBase;

	/**
	 * 网络协议池 
	 * @author SilenXiao
	 * 
	 */	
	public class ProtocolPool
	{
		/** 池是否初始化*/
		public static var isInit:Boolean;
		/** */
		public static var dict:Dictionary;
		public static function init():void
		{
			if(isInit)
				return ;
			isInit = true;
			
			dict = new Dictionary();
		}
		
		
		/**
		 * 获取网络协议体
		 * @param respId	数据返回协议号
		 * @return ProxyBase
		 */		
		public static function getProtocol(respId:uint):ProtocolBase
		{
			if(!isInit)
				init();
			
			return dict[respId];
		}
		
		/**
		 * 添加协议实例
		 * @param reqId		发送id
		 * @param respId		接受id
		 * @param protocolClass	协议类
		 * @param evtFunction 数据返回的监视事件函数
		 */		
		public static function addProtocol(reqId:uint, respId:uint, 
										   protocolClass:Class, 
										   succFunction:Function = null, 
										   errFunction:Function = null):void 
		{
			if(!isInit)
				init();
			
			if(!dict[respId]){
				dict[respId] = new protocolClass(reqId, respId);
			}
			if(succFunction != null)
				NetEvtTrigger.addEventListener(respId.toString(16), succFunction);
			if(errFunction != null)
				NetEvtTrigger.addEventListener(NetEvent.EVT_ERROR + respId.toString(16), errFunction);
		}
	}
}