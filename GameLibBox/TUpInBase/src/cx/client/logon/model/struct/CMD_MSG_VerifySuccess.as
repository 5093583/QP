package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.WORD;

	public class CMD_MSG_VerifySuccess
	{
		public static const SIZE : uint = 4;
		public var wChatLength : uint;					//聊天长度限制
		public var wLimitChatTimes : uint;				//聊天间隔限制

		public function CMD_MSG_VerifySuccess()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_MSG_VerifySuccess
		{
			var result : CMD_MSG_VerifySuccess = new CMD_MSG_VerifySuccess();
			
			result.wChatLength 		= WORD.read(bytes);
			result.wLimitChatTimes 	= WORD.read(bytes);
			
			return result;
		}
	}
}