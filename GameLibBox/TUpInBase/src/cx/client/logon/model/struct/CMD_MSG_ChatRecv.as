package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	
	public class CMD_MSG_ChatRecv
	{
		public var bChatKind : uint;					//聊天类型
		public var dwUserID : int;						//发送ID
		public var szUserName : String;					//发送玩家名称				
		public var szChat : String;						//聊天内容

		public function CMD_MSG_ChatRecv()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) :  CMD_MSG_ChatRecv
		{
			var result : CMD_MSG_ChatRecv = new CMD_MSG_ChatRecv();
			
			result.bChatKind 	= BYTE.read(bytes);
			result.dwUserID 	= DWORD.read(bytes);
			result.szUserName 	= TCHAR.read(bytes,32);
			result.szChat 		= TCHAR.read(bytes,128);
			
			return result;
		}
	}
}