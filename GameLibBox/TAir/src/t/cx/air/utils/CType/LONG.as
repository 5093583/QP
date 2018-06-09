package t.cx.air.utils.CType
{
	import flash.utils.ByteArray;

	public class LONG
	{
		public function LONG()
		{
		}
		public static function get size():uint
		{
			return 4;
		}
		public static function read(byte : ByteArray) : Number
		{
			return byte.readInt();
		}
		public static function write(value : Number,byte : ByteArray) : void
		{
			byte.writeInt(value);
		}
	}
}