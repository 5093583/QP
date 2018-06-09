package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;

	public class CMD_GP_CheckPhone_Result
	{
		public function CMD_GP_CheckPhone_Result()
		{
		}
		
		public var SmsCod:int;
		public var szMail:String;			//szTel[16];
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_CheckPhone_Result
		{
			var result : CMD_GP_CheckPhone_Result = new CMD_GP_CheckPhone_Result();
			
			result.SmsCod = LONG.read(bytes);
			result.szMail = TCHAR.read(bytes,16);
			
			return result;
		}
		
		
		
	}
}