package games.FiveStarBat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_PlaceJetton
	{
		public var wChairID : int;									//用户位置
		public var cbJettonArea : uint;								//筹码区域
		public var lJettonScore : Number;								//加注数目
		public function CMD_S_PlaceJetton()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_PlaceJetton
		{
			var result : CMD_S_PlaceJetton = new CMD_S_PlaceJetton();
			result.wChairID = WORD.read(bytes);
			result.cbJettonArea = BYTE.read(bytes);
			result.lJettonScore = LONGLONG.read(bytes);
			return result;
		}
	}
}