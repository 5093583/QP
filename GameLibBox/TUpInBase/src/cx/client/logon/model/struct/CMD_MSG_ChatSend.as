package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.Memory;

	public class CMD_MSG_ChatSend
	{
		public var bChatKind : uint;					//聊天类型
		public var dwUserID : int;						//发送ID
		public var dwTargetID : int;					//聊天对象
		public var szUserName : String;					//发送玩家名称				
		public var szChat : String;						//聊天内容

		public function CMD_MSG_ChatSend()
		{
		}
		
		public function ToByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			BYTE.write(bChatKind,bytes);
			DWORD.write(dwUserID,bytes);
			DWORD.write(dwTargetID,bytes);
			TCHAR.write(szUserName,bytes,32);
			TCHAR.write(szChat,bytes,128);
			
			return bytes;
		}
		
		public function get size() : uint
		{
			return 169;
		}
	}
}