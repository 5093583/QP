package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;

	//取消申请
	public class CMD_S_CancelBanker
	{
		public static const SIZE       :uint =2;
		public var wApplyUser : uint; //取消玩家
		public function CMD_S_CancelBanker()
		{
			
		}
		public static function _readBuffer(bytes :ByteArray):CMD_S_CancelBanker
		{
			var result:CMD_S_CancelBanker = new CMD_S_CancelBanker();
			result.wApplyUser =WORD.read(bytes);
			return result;			
		}
	}
}