package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.Memory;

	public class CMD_MSG_VerifyConnect
	{
		public var dwMessageVer : int;					//消息服务器版本
		public var dwUserID : int;						//用户ID
		public var szUserPassword : String;				//用户密码
		public var szComputerID : String;				//机器序列
		
		public function CMD_MSG_VerifyConnect()
		{
			szComputerID = '';
		}
		public function ToByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			DWORD.write(dwMessageVer,bytes);
			DWORD.write(dwUserID,bytes);
			
			TCHAR.write(szUserPassword,bytes,33);
			TCHAR.write(szComputerID,bytes,33);
			return bytes;
		}
		
		public function get size() : uint
		{
			return 74;
		}
	}
}