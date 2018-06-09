package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_GP_PlayWithFriend
	{
		public function CMD_GP_PlayWithFriend()
		{
		}
		
		
		public var dwUserID:uint;
		public var dwFriendID:uint;
		public var wKindID:uint;							//类型标识
		public var wServerID:uint;							//房间号码
		public var cbResult:int;							//1邀请，2同意，3拒绝
		
		public var szname:String;
		//TCHAR szname[64];
		
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_PlayWithFriend
		{
			var result : CMD_GP_PlayWithFriend = new CMD_GP_PlayWithFriend();
			
			result.dwUserID 	= DWORD.read(bytes);
			result.dwFriendID 	= DWORD.read(bytes);
			result.wKindID 		= WORD.read(bytes);
			result.wServerID 	= WORD.read(bytes);
			result.cbResult 	= BYTE.read(bytes);
			
			result.szname		= TCHAR.read(bytes, 64);
			
			return result;
		}
		
		public function ToByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			DWORD.write(dwUserID,bytes);
			DWORD.write(dwFriendID,bytes);
			WORD.write(wKindID,bytes);
			WORD.write(wServerID,bytes);
			BYTE.write(cbResult,bytes);
			
			TCHAR.write(szname, bytes, 64);
			
			return bytes;
		}
		
		public function get size() : uint
		{
			return 4+4+2+2+1+64;
		}
		
	}
}