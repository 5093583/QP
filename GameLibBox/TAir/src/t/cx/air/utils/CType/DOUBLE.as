package t.cx.air.utils.CType
{
	import flash.utils.ByteArray;

	public class DOUBLE
	{
		public function DOUBLE()
		{
			
		}
		public static function get size():uint
		{
			return 8;
		}
		public static function read(byte : ByteArray) : Number
		{
			return byte.readDouble();
		}
		public static function write(value : Number,byte : ByteArray) : void
		{
			byte.writeDouble(value);
		}
	}
}