package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.Memory;

	public class CMD_GP_BindPhone_CODE
	{
		public function CMD_GP_BindPhone_CODE()
		{
			VCode = '0000';
		}
		
		
		
		
		public var dwUserID:int;						//用户 I D
		
		public var VCode:String;							//VCode[10]
		public var szTel:String;							//szTel[16];
		
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			DWORD.write(dwUserID,bytes);
			TCHAR.write(VCode, bytes, 10);
			TCHAR.write(szTel, bytes, 16);
			return bytes;
		}
		
		public function get size() : uint
		{
			return 16+10+4;
		}
		
		
		
	}
}