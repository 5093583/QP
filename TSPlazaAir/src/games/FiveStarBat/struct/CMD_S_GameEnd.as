package games.FiveStarBat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;

	public class CMD_S_GameEnd
	{
		public var m_cbEndCard : uint;
		public var lEndScore : Number;
		public function CMD_S_GameEnd()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_GameEnd
		{
			var result : CMD_S_GameEnd = new CMD_S_GameEnd();
			result.m_cbEndCard = BYTE.read(bytes);
			result.lEndScore = LONGLONG.read(bytes);
			return result;
		}
	}
}