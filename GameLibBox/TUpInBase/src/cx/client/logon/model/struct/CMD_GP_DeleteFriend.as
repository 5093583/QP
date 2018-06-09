package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.Memory;

	public class CMD_GP_DeleteFriend
	{
		public function CMD_GP_DeleteFriend()
		{
		}
		
		
		public var dwUserID:uint;
		public var dwFriendID:uint;
		
		
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			DWORD.write(dwUserID,bytes);
			DWORD.write(dwFriendID,bytes);
			return bytes;
		}
		
		public function get size() : uint
		{
			return 4+4;
		}
		
		
	}
}