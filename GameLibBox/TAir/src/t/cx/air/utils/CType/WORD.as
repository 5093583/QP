package t.cx.air.utils.CType
{
	import flash.utils.ByteArray;

	public class WORD
	{
		public function WORD()
		{
		}
		
		public static function get size():uint
		{
			return 2;
		}
		
		public static function read(byte : ByteArray) : int
		{
			return byte.readUnsignedShort();
		}
		public static function write(value : int,byte : ByteArray) : void
		{
			byte.writeShort(value);
		}
	}
}