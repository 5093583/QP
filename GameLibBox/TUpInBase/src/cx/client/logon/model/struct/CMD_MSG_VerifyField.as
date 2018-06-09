package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;

	public class CMD_MSG_VerifyField
	{
		public static const SIZE : uint = 140;
		
		public var bErrorCode : int;					//错误代码
		public var dwRepeatIP : int;					//重连ip
		public var dwRepeatPort : int;					//重连端口
		public var szErrorDescribe : String;			//错误消息

		public function CMD_MSG_VerifyField()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_MSG_VerifyField
		{
			var result : CMD_MSG_VerifyField = new CMD_MSG_VerifyField();
			
			result.bErrorCode	 =  LONG.read(bytes);
			result.dwRepeatIP	 =  DWORD.read(bytes);
			result.dwRepeatPort	 =  DWORD.read(bytes);
			result.szErrorDescribe	 =  TCHAR.read(bytes,128);

			return result;
		}
	}
}