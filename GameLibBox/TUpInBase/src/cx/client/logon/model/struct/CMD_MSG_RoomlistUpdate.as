package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.WORD;

	public class CMD_MSG_RoomlistUpdate
	{
		public var wServerID : int;
		public var dwOnLineCount : int;
		public function CMD_MSG_RoomlistUpdate()
		{
		}
		
		public static function _readBytes(bytes : ByteArray) : CMD_MSG_RoomlistUpdate
		{
			var result : CMD_MSG_RoomlistUpdate = new CMD_MSG_RoomlistUpdate();
			
			result.wServerID = WORD.read(bytes);
			result.dwOnLineCount = DWORD.read(bytes);
			
			return result;
		}
		
		public static function get SIZE() : uint
		{
			return 6;
		}
	}
}