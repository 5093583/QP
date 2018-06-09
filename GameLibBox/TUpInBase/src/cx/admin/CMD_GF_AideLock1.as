package cx.admin
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.Memory;

	public class CMD_GF_AideLock1
	{
		
		public var cbLock : uint;
		public var dwChangeID : uint;
		public function CMD_GF_AideLock1()
		{
			
		}
		public function ToByteArray() : ByteArray
		{
			var result : ByteArray = Memory._newLiEndianBytes();
			BYTE.write(cbLock,result);
			DWORD.write(dwChangeID,result);
			return result;
		}
		
		
		public function getSize():int
		{
			return 4+1;
		}
		
		
		
		
	}
}