package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_GP_GetRoomList2
	{
		public var wKindID :  int;
		
		public var wUserID :  int;
		
		public function CMD_GP_GetRoomList2()
		{
		}
		
		public function toByteArray() : ByteArray
		{
			var result : ByteArray = Memory._newLiEndianBytes();
			WORD.write(wKindID,result);
			DWORD.write(wUserID, result);
			return result;
		}
		
		public function get size() : uint
		{
			return 2+4;
		}
	}
}