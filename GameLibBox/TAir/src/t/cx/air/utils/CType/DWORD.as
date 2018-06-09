package t.cx.air.utils.CType
{
	import flash.utils.ByteArray;

	public class DWORD
	{
		public function DWORD()
		{
			
		}
		public static function get size():uint
		{
			return 4;
		}
		public static function read(byte : ByteArray) : int
		{
			return byte.readUnsignedInt();
		}
		public static function write(value : int,byte : ByteArray) : void
		{
			byte.writeUnsignedInt(value);
		}
	}
}