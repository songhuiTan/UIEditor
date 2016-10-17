package ll.net.core
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import ll.net.ProtocolPool;
	import ll.utils.ByteArrayUtil;
	import ll.utils.Log;
	
	/**
	 * 网络socket 
	 * @author SilenXiao
	 * 
	 */	
	public class NetSocket extends EventDispatcher
	{
		/** Tencent用于TGW的参数 */
		private const HTTP_HEAD_BEGIN:String = "tgw_l7_forward\r\nHost:";
		private const HTTP_HEAD_END:String = "\r\n\r\n";
		
		/** tcp套接字*/
		protected var socket:Socket;
		/** 网络数据 */
		protected var netData:ByteArray;
		protected var netPack:NetPack;
		
		/** 是否读取包头成功 */
		protected var isHeadRead:Boolean;
		
		public function NetSocket()
		{
			super();
			
			init();
		}
		
		/**
		 * 初始化网络层，以及事件监听 
		 * 
		 */		
		protected function init():void
		{
			socket = new Socket();
			socket.endian = Endian.LITTLE_ENDIAN;
			
			netData = ByteArrayUtil.creatByteArray();
			netPack = new NetPack(0);
			netPack.createDataBody();
			initListeners();
		}
		
		/**
		 * 监听socket事件 
		 * 
		 */		
		protected function initListeners():void
		{
			
			socket.addEventListener(Event.CONNECT,onConnect);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onIoErr);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErr);
			socket.addEventListener(Event.CLOSE, onClose);
		}
		
		/**
		 * 根据ip和端口链接到指定的服务器， 
		 * @param host 服务器ip或者域名
		 * @param port 服务器端口
		 * @param policyPort 资源的策略文件端口
		 * 
		 */		
		protected function connect(host:String, port:int, policyPort:uint):void
		{
			//加载指定位置的策略文件
			Security.loadPolicyFile("xmlsocket://"+host+":"+policyPort);
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			
			socket.connect(host, port);
		}
		
		/**
		 * 获取socket是否连接成功 
		 * @return 
		 * 
		 */		
		public function get isConnected():Boolean
		{
			if(socket)
			{
				return socket.connected;
			}
			return false;
		}
		
		/**
		 *  发送网络数据包给服务器 
		 * @param netPack
		 * 
		 */		
		public function sendNetPack(netPack:NetPack):void
		{
			if(!isConnected)
				return;
			var output:ByteArray = ByteArrayUtil.creatByteArray();
			netPack.writeHeadToOutput(output);
			netPack.writeBodyToOutput(output);
			sendBytes(output);
		}
		
		/**
		 * 发送二进制流到服务器 
		 * @param byteArray
		 * 
		 */		
		public function sendBytes(byteArray:ByteArray):void
		{
			socket.writeBytes(byteArray);
			socket.flush();
		}
		
		/**
		 * 发送TGW给服务器，支持双休（腾讯服务器特有接口）
		 * @param ip
		 * @param port
		 * 
		 */		
		public function sendTGW(ip:String, port:uint):void
		{
			if(isConnected)
			{
				//如果IP是域名
				if(ip.search(/[a-z,A-Z]/) != -1)
				{
					var httpHead:String = HTTP_HEAD_BEGIN + ip + ":" + port + HTTP_HEAD_END;
					socket.writeUTFBytes(httpHead);
					socket.flush();
				}
			}
		}
		
		/**
		 * 链接到服务器成功 
		 * 
		 */		
		protected function onConnect(evt:Event):void
		{
			
		}
		
		/**
		 * 连接服务器IO错误 
		 * @param evt
		 * 
		 */		
		protected function onIoErr(evt:IOErrorEvent):void
		{
			trace("socket connect IOError");	
			onError();
		}
		
		/**
		 * 链接服务器安全错误 
		 * @param evt
		 * 
		 */		
		protected function onSecurityErr(evt:SecurityErrorEvent):void
		{
			trace("socket connect IOError");
			onError();
		}
		
		/**
		 * socket链接错误处理（子类重写); 
		 * 
		 */		
		protected function onError():void{}
		
		/**
		 * 接受服务器发送的数据 
		 * @param evt
		 * 
		 */		
		protected function onSocketData(evt:ProgressEvent):void
		{
			while(this.socket && this.socket.bytesAvailable > 0)
			{
				this.netData.position = this.netData.bytesAvailable;
				socket.readBytes(this.netData,this.netData.position,socket.bytesAvailable);
				this.netData.position = 0;
				while(true){
					if(!analysisNetData())
						break;
				}
			}
		}
		
		/**
		 * 解析网络数据 
		 * 
		 */		
		private function analysisNetData():Boolean
		{
			if (!this.isHeadRead && this.netData.bytesAvailable >= netPack.HEAD_LENGTH)
			{ 
				/** 读取包头 */
				this.netPack.readHeadFromInput(this.netData);
				//验证包头是否合法
				if(this.netPack.isValidity())
				{
					this.isHeadRead = true;
				}else{
					this.netData.clear();
					return false;
				}
			} 
			/**如果读了头部，并且当前可读长度大于等于消息长度，则开始读取*/
			if (isHeadRead && this.netData.bytesAvailable >= netPack.dataSize)
			{
				this.netPack.readBodyFromInput(this.netData, this.netPack.dataSize);
				if((netPack.flag & 0x02) == 0)
				{
					//判断是否解压缩
					if((netPack.flag & 0x04) > 0)
					{
						this.netPack.body.endian = "littleEndian";
						this.netPack.body.uncompress();
					}
//					this.netPack.readBodyFromInput(this.netData, this.netPack.dataSize);
					
					if(ProtocolPool.getProtocol(this.netPack.protocolId))
					{
						Log.log("succes!:0x"+ this.netPack.protocolId.toString(16));
						ProtocolPool.getProtocol(this.netPack.protocolId).response(this.netPack.body);
					}
					else
					{
						Log.log("未知协议：0x"+ this.netPack.protocolId.toString(16));
					}
					this.netPack.body.clear();
				}
				this.isHeadRead = false; 
				if(this.netData.bytesAvailable == 0){
					this.netData.clear();
					return false;
				}else {
					writeBackData();
					return true;
				}
			}else{
				writeBackData();
				return false;
			}
		}
		
		
		private var tmpWriteBack:ByteArray = new ByteArray();
		/**
		 * 数据写回
		 */
		private function writeBackData():void{
			tmpWriteBack.writeBytes(this.netData,this.netData.position,this.netData.bytesAvailable);
			this.netData.clear();
			tmpWriteBack.position = 0;
			this.netData.writeBytes(tmpWriteBack,0,tmpWriteBack.bytesAvailable);
			this.netData.position = 0;
			tmpWriteBack.clear();
		}
		
		/**
		 * socket 断开 子类扩展
		 * @param evt
		 * 
		 */		
		protected function onClose(evt:Event):void{};
		
		
		public function close():void
		{
			if(socket)
			{
				if(socket.connected)
				{
					socket.close();
				}
			}
		}
		
		/**
		 * 移除socket的监听事件 
		 * 
		 */		
		protected function removeListeners():void
		{
			socket.removeEventListener(Event.CONNECT, onConnect);
			socket.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			socket.removeEventListener(IOErrorEvent.IO_ERROR, onIoErr);
			socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErr);
			socket.removeEventListener(Event.CLOSE, onClose);
		}
		
		public function dispose():void
		{
			removeListeners();
			close();
		}
	}
}