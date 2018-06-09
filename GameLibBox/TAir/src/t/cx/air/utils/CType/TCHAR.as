package t.cx.air.utils.CType
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.Memory;
	

	public class TCHAR
	{
		public function TCHAR()
		{
		}
		public static function get size():uint
		{
			return 0;
		}
		public static function getLength(value : String) : uint
		{
			return Memory._getStringLength(value);
		}
		
		public static function read(byte : ByteArray,len : uint,charSet : String = 'gb2312') : String
		{
			if(len > (byte.length - byte.position))
				len =  byte.length - byte.position;
			return byte.readMultiByte(len,charSet);
		}
		public static function write(value : String,byte : ByteArray,len : uint = 0,charSet : String = 'gb2312') : void
		{
			len = len==0?Memory._getStringLength(value):len;
			Memory._writeStringToBytes(byte,value,len,charSet);
		}
	}
}