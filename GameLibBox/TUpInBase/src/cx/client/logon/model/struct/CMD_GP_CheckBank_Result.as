package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.TCHAR;

	public class CMD_GP_CheckBank_Result
	{
		public function CMD_GP_CheckBank_Result()
		{
		}
		
		
		public var szUserName:String;								//szUserName[20];	//姓名
		public var szBankName:String;								//szBankName[64];	//开户银行
		public var szBankNum:String;								//szBankNum[25];	//银行账号
		public var szBankAtr:String;								//szBankAtr[255];	//开户网店

		public static function _readBuffer(bytes : ByteArray) : CMD_GP_CheckBank_Result
		{
			var result : CMD_GP_CheckBank_Result = new CMD_GP_CheckBank_Result();
			
			result.szUserName = TCHAR.read(bytes,20);
			result.szBankName = TCHAR.read(bytes,64);
			result.szBankNum = TCHAR.read(bytes,25);
			result.szBankAtr = TCHAR.read(bytes,255);
			
			return result;
		}
		
	}
}