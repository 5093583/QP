package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;

	public class CMD_MSG_OUTUSER
	{
		public static const SIZE : uint = 4;
		public var OutUser : int;														//目标ID
		public function CMD_MSG_OUTUSER()
		{
		}
		public static function _readBuffer(pBuffer : ByteArray) : CMD_MSG_OUTUSER
		{
			var result : CMD_MSG_OUTUSER = new CMD_MSG_OUTUSER();
			result.OutUser = DWORD.read(pBuffer);
			return result;
		}
	}
}