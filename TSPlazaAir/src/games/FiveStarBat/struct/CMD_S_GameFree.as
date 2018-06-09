package games.FiveStarBat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;

	public class CMD_S_GameFree
	{
		public var cbTimeLeave : uint;								//剩余时间
		public var bCardRoomCount : uint;
		
		public var cbIsTryPlay : uint;
		public var lTryPlayScore : Number;
		public function CMD_S_GameFree()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_GameFree
		{
			var result : CMD_S_GameFree = new CMD_S_GameFree();
			result.cbTimeLeave = BYTE.read(bytes);
			result.bCardRoomCount = BYTE.read(bytes);
			result.cbIsTryPlay  = BYTE.read(bytes);
			result.lTryPlayScore = LONGLONG.read(bytes);
			return result;
		}
	}
}