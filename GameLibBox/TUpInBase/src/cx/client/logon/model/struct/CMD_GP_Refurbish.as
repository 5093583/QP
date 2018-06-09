package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.Memory;

	public class CMD_GP_Refurbish
	{
		public var dwUserID : int;						//用户I D
		public function CMD_GP_Refurbish()
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