package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;
	
	public class CMD_GR_LogonError
	{
		public static const SIZE : uint = 132;
		
		public var lErrorCode : Number;							//错误代码
		public var szErrorDescribe : String;					//错误消息
		public function CMD_GR_LogonError()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GR_LogonError
		{
			var result : CMD_GR_LogonError = new CMD_GR_LogonError();
			result.lErrorCode = LONG.read(bytes);
			result.szErrorDescribe = TCHAR.read(bytes,128);
			return result;
		}
		
	}
}