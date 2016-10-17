package ll.net.core
{
	import flash.utils.ByteArray;
	
	import ll.utils.StringUtil;
	
	/**
	 * 64位无符号整数 
	 * @author zcw
	 */	
	public class UInt64
	{
		public var high:uint;
		public var low:uint;
		/**
		 *  构造函数
		 * @param pHigh 高32位
		 * @param pLow 低32位
		 */		
		public function UInt64(pHigh:uint = 0, pLow:uint = 0)
		{
			high = pHigh;
			low = pLow;
		}
		
		/**
		 * 转换为字符串
		 * @param radix		几进制(2  10  16)
		 * @return 
		 */		
		public final function toString(radix:uint=10):String {
			if (radix < 2 || radix > 36) 
			{
				throw new ArgumentError
			}
			if (high == 0) 
			{
				return low.toString(radix);
			}
			//16进制的字符串可以通过高低位快速换算
			if(radix == 16)
			{
				return toHexString();
			}
			
			const digitChars:Array = [];
			const copyOfThis:UInt64 = new UInt64(low, high);
			do 
			{
				const digit:uint = copyOfThis.div(radix);
				var charCode:String = digit < 10 ? '0' : 'a';
				digitChars.push(charCode.charCodeAt() + digit);
			} while (copyOfThis.high != 0)
			return copyOfThis.low.toString(radix) + String.fromCharCode.apply(String, digitChars.reverse())
		}
		
		/**
		 * 16进制的字符串通过高低位快速换算
		 */
		protected final function toHexString():String
		{
			var lowLen:uint = low.toString(16).length;
			return high.toString(16) + "00000000".substr(0, 8 - lowLen) + lowLen.toString(16);
		}
		
		public function equal(value:UInt64):Boolean
		{
			return this.toHexString() == value.toHexString();
		}
		
		/**
		 * 将字符串转换为uint64 
		 * @param str
		 * @param radix
		 * @return 
		 * 
		 */		
		public static function parseUInt64(str:String, radix:uint = 0):UInt64 {
			var i:uint = 0;
			if (radix == 0) 
			{
				if (str.search(/^0x/) == 0) 
				{
					radix = 16;
					i = 2;
				} else {
					radix = 10;
				}
			}
			if (radix < 2 || radix > 36) 
			{
				throw new ArgumentError
			}
			str = str.toLowerCase();
			const result:UInt64 = new UInt64(0,0);
			for (; i < str.length; i++) {
				var digit:uint = str.charCodeAt(i)
				if (digit >= '0'.charCodeAt() && digit <= '9'.charCodeAt()) {
					digit -= '0'.charCodeAt();
				} else if (digit >= 'a'.charCodeAt() && digit <= 'z'.charCodeAt()) {
					digit -= 'a'.charCodeAt();
				} else {
					throw new ArgumentError
				}
				if (digit >= radix) {
					throw new ArgumentError
				}
				result.mul(radix);
				result.add(digit);
			}
			return result;
		}
		
		/**
		 * Division by n.
		 * @return The remainder after division.
		 */
		internal final function div(n:uint):uint {
			const modHigh:uint = low % n;
			const mod:uint = (high % n + modHigh * 6) % n;
			low /= n;
			const newLow:Number = (modHigh * 4294967296.0 + high) / n;
			low += uint(newLow / 4294967296.0);
			high = newLow;
			return mod;
		}
		internal final function mul(n:uint):void {
			const newLow:Number = Number(low) * n;
			high *= n;
			high += uint(newLow / 4294967296.0);
			low *= n;
		}
		internal final function add(n:uint):void {
			const newLow:Number = Number(low) + n;
			high += uint(newLow / 4294967296.0);
			low = newLow;
		}
		internal final function bitwiseNot():void {
			high = ~high;
			low = ~low;
		}
	}
}