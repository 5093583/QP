package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;

	public class CMD_GP_PlayerOffline
	{
		public function CMD_GP_PlayerOffline()
		{
		}
		
		
		
		public var dwUserID:uint;
		
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_PlayerOffline
		{
			var result : CMD_GP_PlayerOffline = new CMD_GP_PlayerOffline();
			result.dwUserID 	= DWORD.read(bytes);
			return result;
		}
		
		
	}
}