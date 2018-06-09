package cx.admin
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.Memory;

	public class CMD_GF_AideLock
	{
		public var cbLock : uint;
		public var dwChangeID : uint;
		public var dwLockUserID : Array;				//锁定玩家id
		public function CMD_GF_AideLock()
		{
			dwLockUserID= Memory._newArrayAndSetValue(8,0);
		}
		public function ToByteArray() : ByteArray
		{
			var result : ByteArray = Memory._newLiEndianBytes();
			BYTE.write(cbLock,result);
			DWORD.write(dwChangeID,result);
			var i : uint = 0;
			for(i = 0;i<8;i++)
			{
				DWORD.write(dwLockUserID[i],result);
			}
			return result;
		}
	}
}