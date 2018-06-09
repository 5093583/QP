package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.Memory;

	public class CMD_GP_BindBank
	{
		public function CMD_GP_BindBank()
		{
		}
		
		public var dwUserID:uint;						//用户I D
		public var szUserName:String;					//szUserName[20];	//姓名
		public var szBankName:String;					//szBankName[64];	//开户银行
		public var szBankNum:String;					//szBankNum[25];	//银行账号
		public var szBankAtr:String;					//szBankAtr[255];	//开户网店

		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			DWORD.write(dwUserID,bytes);
			TCHAR.write(szUserName, bytes, 20);
			TCHAR.write(szBankName, bytes, 64);
			TCHAR.write(szBankNum, bytes, 25);
			TCHAR.write(szBankAtr, bytes, 255);
			
			return bytes;
		}
		
		public function get size() : uint
		{
			return 4+20+64+25+255;
		}
		
		
	}
}