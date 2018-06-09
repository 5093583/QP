package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;

	public class CMD_GR_LogonSuccess
	{
		public var dwUserID : Number;							//用户 I D
		public function CMD_GR_LogonSuccess()
		{
			
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GR_LogonSuccess
		{
			var result : CMD_GR_LogonSuccess = new CMD_GR_LogonSuccess();
			
			result.dwUserID = DWORD.read(bytes);
			
			return result;
		}
	}
}