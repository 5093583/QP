package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.Memory;

	public class CMD_GP_InputFriend_Sine
	{
		public function CMD_GP_InputFriend_Sine()
		{
		}
		
		
		public var cbResult:uint;
		public var dwUserID:uint;
		public var dwFriendID:uint;
		
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			BYTE.write(cbResult, bytes);
			DWORD.write(dwUserID,bytes);
			DWORD.write(dwFriendID,bytes);
			return bytes;
		}
		
		public function get size() : uint
		{
			return 1+4+4;
		}
		
		
	}
}