package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.Memory;

	public class CMD_GP_BindEmail
	{
		public function CMD_GP_BindEmail()
		{
		}
		
		
		public var dwUserID:int;						//用户 I D
		public var szMail:String;							//szMail[50]
		
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			DWORD.write(dwUserID,bytes);
			TCHAR.write(szMail, bytes, 50);
			return bytes;
		}
		
		public function get size() : uint
		{
			return 50+4;
		}
		
		
		
	}
}