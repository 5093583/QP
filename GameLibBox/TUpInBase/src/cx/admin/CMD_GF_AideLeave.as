package cx.admin
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;

	public class CMD_GF_AideLeave
	{
		public var dwUserID : uint;
		public function CMD_GF_AideLeave()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_GF_AideLeave
		{
			var result : CMD_GF_AideLeave = new CMD_GF_AideLeave();
			result.dwUserID = DWORD.read(bytes);
			return result;
		}
	}
}