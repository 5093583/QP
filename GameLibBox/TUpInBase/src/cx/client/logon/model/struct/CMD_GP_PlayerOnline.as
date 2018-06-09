package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;

	public class CMD_GP_PlayerOnline
	{
		public function CMD_GP_PlayerOnline()
		{
		}
		
		public var dwUserID:uint;
		
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_PlayerOnline
		{
			var result : CMD_GP_PlayerOnline = new CMD_GP_PlayerOnline();
			result.dwUserID 	= DWORD.read(bytes);
			return result;
		}
		
		
	}
}