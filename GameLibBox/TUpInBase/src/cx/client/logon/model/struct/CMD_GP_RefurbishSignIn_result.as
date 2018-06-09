package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;

	public class CMD_GP_RefurbishSignIn_result
	{
		public function CMD_GP_RefurbishSignIn_result()
		{
		}
		
//		public var bSignInresult : uint;						//1为已签到0为未签到
		
		
		public var bSignInresult:uint;					//1为已签到0为未签到105为活动未开启			DWORD	
		public var dwServiceTime:uint;					//DWORD
		public var dwSignData:uint;						//DWORD
		
		
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_RefurbishSignIn_result
		{
			var result : CMD_GP_RefurbishSignIn_result = new CMD_GP_RefurbishSignIn_result();
			
//			result.bSignInresult = BYTE.read(bytes);
			
			result.bSignInresult = DWORD.read(bytes);
			result.dwServiceTime = DWORD.read(bytes);
			result.dwSignData	 = DWORD.read(bytes);
			
			return result;
		}
		
		
		
	}
}