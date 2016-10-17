package ll.net.core
{
	import flash.utils.ByteArray;
	
	import ll.evt.NetEvent;
	import ll.net.NetEvtTrigger;
	import ll.utils.Log;
	
	/**
	 * 基础协议类 
	 * @author SilenXiao
	 * 
	 */	
	public class ProtocolBase
	{
		public var reqId:uint;
		public var respId:uint;
		
		/** 服务器返回的状态值，0为成功，非0为错误码*/
		public var retCode:uint;
		/**
		 * 构造函数 
		 * @param reqId 发送的协议id
		 * @param respId 接收的协议id
		 * 
		 */		
		public function ProtocolBase(reqId:uint = 0, respId:uint = 0)
		{
			this.reqId = reqId;
			this.respId = respId;
		}
		
		/**
		 * 客户端发送请求 
		 * @return 
		 * 
		 */		
		public function call():void
		{
			
		}
		
		/**
		 * 接受服务器返回的数据 
		 * @param dataBody
		 * 
		 */		
		public function response(dataBody:ByteArray):void
		{
			this.retCode = dataBody.readUnsignedInt();
			
			if(retCode == 0)
			{
				onSucess(dataBody);
			}else{
				onFail(dataBody);
			}
		}
		
		/**
		 * 服务器返回操作成功（retCode == 0） 
		 * @param dataBody
		 * 
		 */		
		public function onSucess(dataBody:ByteArray):void
		{
			
		}
		
		/**
		 * 服务器返回操作失败 
		 * @param dataBody
		 * 
		 */		
		public function onFail(dataBody:ByteArray):void
		{
			Log.log("Error|0x" + retCode.toString(16));
			sendNetEvent(NetEvent, NetEvent.EVT_ERROR + respId.toString(16));
		}
		
		/**
		 * 派发网络事件 
		 * @param evtClass
		 * @param evtType
		 * 
		 */		
		public function sendNetEvent(evtClass:Class, evtType:String):void
		{
			NetEvtTrigger.dispatchEvent(new evtClass(evtType, this));
		}
	}
}