package cx.admin
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.Memory;

	public class CMD_GF_AidePlay
	{
		public var dwUserID : Number;
		public var dwViewID : Number;					//使用的视图ID
		public var szViewIP : String;					//使用的视图IP
		public function CMD_GF_AidePlay()
		{
		}
		
		public function ToByteArray() : ByteArray
		{
			var result : ByteArray = Memory._newLiEndianBytes();
			DWORD.write(dwUserID,result);
			DWORD.write(dwViewID,result);
			TCHAR.write(szViewIP,result,64);
			return result;
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GF_AidePlay
		{
			var result : CMD_GF_AidePlay = new CMD_GF_AidePlay();
			result.dwUserID = DWORD.read(bytes);
			result.dwViewID = DWORD.read(bytes);
			result.szViewIP = TCHAR.read(bytes,64);
			return result;
		}
		public function get size() : uint
		{
			return 68;
		}
	}
}