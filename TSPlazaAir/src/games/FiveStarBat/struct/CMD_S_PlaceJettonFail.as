package games.FiveStarBat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_PlaceJettonFail
	{
		public var wPlaceUser : int;									//下注玩家
		public var lJettonArea : uint;								//下注区域
		public var lPlaceScore : Number;								//当前下注  类型原为LONGLONG
		public var cbFailType : uint;								//失败原因5：庄家离开 0 : 玩家下注金币大于注册金币 1 ：玩家下注超过区域限制 2：玩家下注超过个人限制 3：超过庄家下注限制4：玩家手中金币不够下注6：下注失败（原因之外）
		public function CMD_S_PlaceJettonFail()
		{
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_PlaceJettonFail
		{
			var result:CMD_S_PlaceJettonFail=new CMD_S_PlaceJettonFail();
			result.wPlaceUser = WORD.read(bytes);
			result.lJettonArea = BYTE.read(bytes);
			result.lPlaceScore = LONGLONG.read(bytes);
			result.cbFailType = BYTE.read(bytes);
			return result;
		}
	}
}