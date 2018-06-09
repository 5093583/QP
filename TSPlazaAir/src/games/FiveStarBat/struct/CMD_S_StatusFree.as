package games.FiveStarBat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;

	public class CMD_S_StatusFree
	{
		public var cbTimeLeave : uint;
		public var cbIsTryPlay : uint;
		public var lTryPlayScore : Number;
		public var lAreaLimitScore : Number;							//区域限制
		public function CMD_S_StatusFree()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_StatusFree
		{
			var result : CMD_S_StatusFree = new CMD_S_StatusFree();
			result.cbTimeLeave = BYTE.read(bytes);
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONGLONG.read(bytes);
			result.lAreaLimitScore = LONGLONG.read(bytes);
			return result;
		}
	}
}