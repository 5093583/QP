package games.FiveStarBat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;

	public class CMD_S_StatusEnd
	{
		public var cbTimeLeave : uint;
		public var cbIsTryPlay : uint;
		public var cbEndCard : uint;
		public var lTryPlayScore : Number;
		public function CMD_S_StatusEnd()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_StatusEnd
		{
			var result : CMD_S_StatusEnd = new CMD_S_StatusEnd();
			result.cbTimeLeave = BYTE.read(bytes);
			result.cbIsTryPlay = BYTE.read(bytes);
			result.cbEndCard = BYTE.read(bytes);
			result.lTryPlayScore = LONGLONG.read(bytes);
			return result;
		}
	}
}