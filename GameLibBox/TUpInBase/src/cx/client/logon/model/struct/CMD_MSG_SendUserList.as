package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;

	public class CMD_MSG_SendUserList
	{
		public var dwUserID:int;
		public var dwUserIP:int;	
		public var cbFaceID:int;
		public var dwUserRight:int;
		
		public function CMD_MSG_SendUserList()
		{
			
		}
		
		
		public static function _readBuffer(bytes : ByteArray) : CMD_MSG_SendUserList
		{
			var result : CMD_MSG_SendUserList = new CMD_MSG_SendUserList();
			result.dwUserID 	= DWORD.read(bytes);
			result.dwUserIP		= DWORD.read(bytes);
			result.cbFaceID		= BYTE.read(bytes);
			result.dwUserRight	= DWORD.read(bytes);
			return result;
		}
		
		
	}
}