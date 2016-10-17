package ll.utils
{
	import ll.net.core.Size;
	import ll.net.core.UInt64;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * 二进制数据操作工具类 
	 * @author SilenXiao
	 * 
	 */	
	public class ByteArrayUtil
	{
		/**
		 * 创建一个低位在前的二进制数据ByteArray
		 */
		public static function creatByteArray():ByteArray
		{
			var ba:ByteArray = new ByteArray();
			ba.endian = Endian.LITTLE_ENDIAN;
			return ba;	
		}
		
		/**
		 * @return 返回 将二进制数据转换成16进制整数的字符串
		 */
		public static function traceByte(ba:ByteArray,str:String ="Send ",radix:int=16):String
		{
			var s:String = str +"("+ba.length+" B)";
			ba.position = 0;
			var tmp:String;
			while(ba && ba.bytesAvailable)
			{
				tmp = ("00"+ba.readUnsignedByte().toString(radix).toUpperCase());
				s+= (" " + tmp.slice(tmp.length-(256/(radix*radix)+1),tmp.length));
			}
			ba.position = 0;
			return s;
		}
		
		
		/**
		 * 将字符串以UTF编码格式写入二进制数据 
		 * @param str
		 * 
		 */		
		public static function writeUTF(str:String, byteArray:ByteArray):void
		{
			var utfBytes:ByteArray = ByteArrayUtil.creatByteArray();
			utfBytes.writeUTFBytes(str);
			
			if(utfBytes.length >= Size.CHECK_LENGTH){
				byteArray.writeByte(255);
				byteArray.writeShort(utfBytes.length);
			} else {
				byteArray.writeByte(utfBytes.length);
			}
			byteArray.writeBytes(utfBytes,0,utfBytes.length);
		}
		
		
		/**
		 * 从二进制数据以utf格式读取一个字符串，并于返回 
		 * @param body
		 * @return 
		 * 
		 */		
		public static function readUTF(body:ByteArray):String
		{
			var length:int = body.readUnsignedByte();
			if(length >= Size.CHECK_LENGTH){
				length = body.readUnsignedShort();
			}
			var utf:String = body.readUTFBytes(length);
			return utf;
		}
		
		/**
		 * 将64位整数写入二进制数据
		 * @param n
		 * 
		 */		
		public static function writeUInt64(uint64:UInt64, byteArray:ByteArray):void
		{
			var h:int = uint64.high;
			var l:int = uint64.low;
			if(byteArray.endian == Endian.LITTLE_ENDIAN)
			{
				
				byteArray.writeUnsignedInt(l);
				byteArray.writeUnsignedInt(h);
			}
			else
			{
				byteArray.writeUnsignedInt(h);
				byteArray.writeUnsignedInt(l);
			}
		}
		
		/**
		 * 从二进制数据中读取一个uint64 
		 * @param ba
		 * @return 
		 * 
		 */		
		public static function readUInt64(ba:ByteArray):UInt64
		{
			var h: uint = ba.readUnsignedInt();
			var l: uint = ba.readUnsignedInt();
			
			var uint64:UInt64;
			if(ba.endian == Endian.LITTLE_ENDIAN)
			{
				uint64 = new UInt64(l, h);
			}else{
				uint64 = new UInt64(h, l);
			}
			return uint64;					
		}
	}
} 
