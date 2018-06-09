package games.cowcow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_PlayerExit
	{
		public var wPlayerID : int;							//退出用户
		public function CMD_S_PlayerExit()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_PlayerExit
		{
			var result : CMD_S_PlayerExit = new CMD_S_PlayerExit();
			result.wPlayerID = WORD.read(bytes);
			return result;
		}
	}
}