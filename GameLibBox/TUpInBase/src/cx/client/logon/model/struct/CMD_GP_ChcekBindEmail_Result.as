package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.TCHAR;

	public class CMD_GP_ChcekBindEmail_Result
	{
		public function CMD_GP_ChcekBindEmail_Result()
		{
		}
		
		
		
		public var szMail:String;		//szMail[32];
		
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_ChcekBindEmail_Result
		{
			var result : CMD_GP_ChcekBindEmail_Result = new CMD_GP_ChcekBindEmail_Result();
			
			result.szMail = TCHAR.read(bytes,32);
			
			return result;
		}
		
		
		
	}
}