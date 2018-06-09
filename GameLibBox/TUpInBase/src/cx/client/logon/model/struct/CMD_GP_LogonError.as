package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DOUBLE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	
	public class CMD_GP_LogonError
	{
		private static const ErrLen : uint = 128;
		public const SIZE : int = DOUBLE.size +  ErrLen;
		public var lErrorCode : Number;						//错误代码
		public var szErrorDescribe : String;				//错误消息
		public function CMD_GP_LogonError()
		{
			szErrorDescribe = '';
		}
		public static function _readByteArray(bytes : ByteArray,wDataSize : int) : CMD_GP_LogonError
		{
			var result : CMD_GP_LogonError = new CMD_GP_LogonError();
			result.lErrorCode = DWORD.read(bytes);
			result.szErrorDescribe = TCHAR.read(bytes,wDataSize - DWORD.size);
			return result;
		}
	}
}