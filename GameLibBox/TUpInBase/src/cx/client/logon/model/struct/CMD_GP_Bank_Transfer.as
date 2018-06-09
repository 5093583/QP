package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.Memory;

	public class CMD_GP_Bank_Transfer
	{
		
		public var dwUserID	:uint;
		public var dw2UserID:uint;							
		public var lScore:int;
		public var szBankPassword:String;			//银行密码			33

		
		
		public function CMD_GP_Bank_Transfer()
		{
		}
		
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			DWORD.write(dwUserID,bytes);
			DWORD.write(dw2UserID,bytes);
			LONG.write(lScore,bytes);
			TCHAR.write(szBankPassword, bytes, 33);
			return bytes;
		}
		
		public function get size() : uint
		{
			return 4+4+4+33;
		}
		
	}
}