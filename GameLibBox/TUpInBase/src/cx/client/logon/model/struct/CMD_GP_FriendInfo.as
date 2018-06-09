package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.Memory;

	public class CMD_GP_FriendInfo
	{
		public function CMD_GP_FriendInfo()
		{
		}
		
		
		public var dwFriendID:Array = new Array(20);				//DWORD			dwFriendID[20];
		
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_FriendInfo
		{
			var result : CMD_GP_FriendInfo = new CMD_GP_FriendInfo();
			
			for(var i:int=0; i<20; i++)
			{
				result.dwFriendID[i] = DWORD.read(bytes);
			}
			
			return result;
		}
		
		
		public function ToByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			for(var i:int=0; i<20; i++)
			{
				DWORD.write(dwFriendID[i], bytes);
			}
			
			return bytes;
		}
		public function get size() : uint
		{
			return 4*20;
		}
		
		
	}
}