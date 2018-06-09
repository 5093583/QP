package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;

	public class CMD_GP_BankCheck_Result
	{
		public var cbEnble : uint;
		public function CMD_GP_BankCheck_Result()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_GP_BankCheck_Result
		{
			var result : CMD_GP_BankCheck_Result = new CMD_GP_BankCheck_Result();
			result.cbEnble = BYTE.read(bytes);
			
			return result;
		}
	}
}