package t.cx.air.utils.CType
{
	import flash.utils.ByteArray;

	public class BYTE
	{
		public function BYTE()
		{
		}
		public static function get size():uint
		{
			return 1;
		}
		public static function read(byte : ByteArray) : uint
		{
			return byte.readByte();
		}
		public static function write(value : int,byte : ByteArray) : void
		{
			byte.writeByte(value);
		}
		
	}
}