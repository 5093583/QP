package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.Memory;

	public class CMD_GR_PlayWithFriend
	{
		public function CMD_GR_PlayWithFriend()
		{
		}
		
		
		public var dwUserID:int;
		public var dwFriendID:int;
		
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray =  Memory._newLiEndianBytes();
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