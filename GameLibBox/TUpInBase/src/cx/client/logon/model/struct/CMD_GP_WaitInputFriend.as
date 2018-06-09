package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;

	public class CMD_GP_WaitInputFriend
	{
		public function CMD_GP_WaitInputFriend()
		{
		}
		
		public var dwUserID:uint;
		public var cbGender:uint;
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_WaitInputFriend
		{
			var result : CMD_GP_WaitInputFriend = new CMD_GP_WaitInputFriend();
			result.dwUserID		= DWORD.read(bytes);
			result.cbGender		= BYTE.read(bytes);
			return result;
		}
		
		
	}
}