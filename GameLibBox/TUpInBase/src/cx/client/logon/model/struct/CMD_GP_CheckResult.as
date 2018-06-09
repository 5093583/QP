package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;

	public class CMD_GP_CheckResult
	{
		public function CMD_GP_CheckResult()
		{
		}
		
		
		
		public var cbresult:uint;							
		public var dwFriendID:uint;							
		public var cbGender:uint;							
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_CheckResult
		{
			var result : CMD_GP_CheckResult = new CMD_GP_CheckResult();
			
			result.cbresult = BYTE.read(bytes);
			result.dwFriendID = DWORD.read(bytes);
			result.cbGender = BYTE.read(bytes);
			
			return result;
		}
		
		
		
	}
}