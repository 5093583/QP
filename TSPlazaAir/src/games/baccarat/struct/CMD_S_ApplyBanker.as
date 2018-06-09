package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.WORD;

	//申请庄家
	public class CMD_S_ApplyBanker
	{
		public static const SIZE      :uint= 4;
		public var wApplyUser         :int; //申请玩家
		public function CMD_S_ApplyBanker()
		{
		}
		public static function _readBuffer(bytes :ByteArray) :CMD_S_ApplyBanker
		{
			var result :CMD_S_ApplyBanker = new CMD_S_ApplyBanker();
			result.wApplyUser =WORD.read(bytes);
			return result;
		}
	}
}