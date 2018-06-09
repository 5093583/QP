package games.zjh.struct
{
	import flash.utils.ByteArray;
	import t.cx.air.utils.CType.WORD;
	
	public class CMD_S_WaitCompare
	{
		public var wCompareUser : int;						//比牌用户

		public function CMD_S_WaitCompare()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_WaitCompare
		{
			var result : CMD_S_WaitCompare = new CMD_S_WaitCompare();
			result.wCompareUser = WORD.read(bytes);
			return result;
		}
	}
}