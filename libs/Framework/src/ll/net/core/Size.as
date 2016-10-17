package ll.net.core
{
	import flash.utils.ByteArray;

	public class Size
	{
		public static const CHECK_LENGTH:int = 255;
		public static const CHECK_LENGTH_MAX:int = 65535;
		
		private var _size:uint;
		
		public function Size()
		{
		}
		
		/**
		 * 不够长度读数据，返回false
		 * 否则返回ture;
		 */
		public function readSizeFromByteArray(input:ByteArray):Boolean{
			this._size = input.readUnsignedByte();
			if(this._size>=CHECK_LENGTH){ 
				if(input.bytesAvailable < 2){
					return false;
				}
				this._size = input.readUnsignedShort();
				if(this._size >= CHECK_LENGTH_MAX){
					if(input.bytesAvailable < 4){
						return false;
					}
					this._size = input.readUnsignedInt();
				}
			}
			return true;
		}
		
		public function writeSizeToByteArray(size:uint, output:ByteArray):void
		{
			this._size = size;
			if(this._size<CHECK_LENGTH){
				output.writeByte(this._size);
			}
			else if(this._size>=CHECK_LENGTH){
				output.writeByte(CHECK_LENGTH);
				output.writeShort(this._size);
			}
		}
		public function set size(value:uint):void
		{
			_size = value;
		}
		public function get size():uint
		{
			return this._size;
		}
	}
}