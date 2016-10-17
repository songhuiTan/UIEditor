package ll.net.core
{
	import ll.utils.ByteArrayUtil;
	
	import flash.utils.ByteArray;

	/**
	 * 网络数据包基类 
	 * @author SilenXiao
	 * 
	 */	
	public class NetPack
	{
		/** 包头的字节数长度 */
		public const HEAD_LENGTH:int = 18;
		public const MAGIC_NUMBER:uint = 0xC0074346;
		
		/** 协议头变量 */
		public var magicNumber:uint = 0xC0074346;
//		public var version:uint = 0;
		public var serialNo:uint;
		/** 协议号ID */
		public var protocolId:uint;
		/** 协议数据的验证号 */
//		public var checkSum:uint;
		/** 数据包是否完整标记，0表示完整，非0表示不完整(用于大数据包接收) */
		public var flag:uint;
		/** 包体的字节数长度 */
		public var dataSize:uint;
		
		public var body:ByteArray;
		public function NetPack(protocolId:uint)
		{
			this.protocolId = protocolId;
		}
		
		/**
		 * 读取包头
		 */
		public function readHeadFromInput(input:ByteArray):uint
		{
			this.magicNumber = input.readUnsignedInt();
			this.flag = input.readUnsignedByte();
			this.serialNo = input.readUnsignedInt();
			this.protocolId = input.readUnsignedInt();
			
			if((flag&0x01) > 0)
				dataSize = input.readUnsignedShort();
			else
				dataSize = input.readUnsignedByte();
			return dataSize;
		}
		
		public function isValidity():Boolean
		{
			return this.magicNumber == MAGIC_NUMBER;
		}
		
		/**
		 * 读取包体
		 */
		public function readBodyFromInput(input:ByteArray, len:uint):void
		{
			input.readBytes(this.body, this.body.bytesAvailable, len);
		}
		
		/**
		 * 创建包体 
		 * @return 
		 * 
		 */		
		public function createDataBody():ByteArray
		{
			if(this.body)
			{
				this.body.clear();
			}else{
				this.body = ByteArrayUtil.creatByteArray();
			}
			return this.body;
		}
		
		/**
		 *  写协议头 
		 * @param output
		 * 
		 */		
		public function writeHeadToOutput(output:ByteArray):void
		{
			output.writeUnsignedInt(this.magicNumber);
			dataSize = body.length;
			if (dataSize>=0xFF)
				flag = flag | 0x01;
			output.writeByte(flag);
			
			output.writeUnsignedInt(this.serialNo);
			output.writeUnsignedInt(this.protocolId);
		}
		
		/**
		 * 写协议体 
		 * @param output
		 * 
		 */		
		public function writeBodyToOutput(output:ByteArray):void
		{
			if(this.body)
			{
				dataSize = body.length;
				if (dataSize>=0xFF)
					output.writeShort(dataSize);
				else
					output.writeByte(dataSize);
				output.writeBytes(this.body,0,this.body.length);
			} else{
				output.writeByte(0);
			}
		}
	}
}