package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.Memory;

	public class CMD_GP_BankCheck
	{
		public var dwUserID:uint;						//用户I D
		public function CMD_GP_BankCheck()
		{
		}
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			DWORD.write(dwUserID,bytes);
			
			return bytes;
		}
		
		public function get size() : uint
		{
			return 4;
		}
	}
}