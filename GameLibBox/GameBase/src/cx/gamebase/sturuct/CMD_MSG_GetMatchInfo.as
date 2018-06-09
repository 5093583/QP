package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.Memory;

	public class CMD_MSG_GetMatchInfo
	{
		public var dwUserID : int;
		public var dwTaskID : int;
		public function CMD_MSG_GetMatchInfo()
		{
		}
		
		public function ToByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			DWORD.write(dwUserID,bytes);
			DWORD.write(dwTaskID,bytes);
			return bytes;
		}
		public function get size() : uint
		{
			return 8;
		}
	}
}