package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;

	public class CMD_GP_DeleteFriend_result
	{
		public function CMD_GP_DeleteFriend_result()
		{
		}
		
		public var dwUserID:uint;
		
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_DeleteFriend_result
		{
			var result : CMD_GP_DeleteFriend_result = new CMD_GP_DeleteFriend_result();
			result.dwUserID 	= DWORD.read(bytes);
			return result;
		}
		
		
		
		
	}
}