package t.cx.air.utils.CType
{
	import flash.utils.ByteArray;

	public class LONGLONG
	{
		public function LONGLONG()
		{
			
		}
		public static function get size() : uint
		{
			return 8;
		}
		
		public static function read(byte : ByteArray) : Number
		{
			var low : uint = byte.readUnsignedInt();
			var high : Number = byte.readInt();
			var result : Number = high * 4294967296 + low;
			return result;
		}
		public static function write(value : Number,byte : ByteArray) : void
		{
			var lowInt : uint = value / 4294967296;
			var hightInt : uint = value % 4294967296;
			byte.writeUnsignedInt(hightInt);
			byte.writeUnsignedInt(lowInt);
		}
		
		/*
		public static function read(byte : ByteArray) : Number
		{
			var low : uint = byte.readUnsignedInt();
			var high : Number = byte.readInt();
			var result : Number = (high<<32) + low;
			return result;
		}
		public static function write(value : Number,byte : ByteArray) : void
		{
			var lowInt : uint = (value&0xFFFFFFFF);
			var hightInt : uint = (value>>32);
			byte.writeUnsignedInt(hightInt);
			byte.writeUnsignedInt(lowInt);
		}
		*/
		
		
		
	}
}