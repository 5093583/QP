package games.cowlord.struct
{
	import flash.utils.ByteArray;	
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_CancelBanker
	{
		public static const SIZE:uint=10;
		public var wApplyUser:int;
		//		//取消申请
//		struct CMD_S_CancelBanker
//		{
//			WORD							wApplyUser;							//申请玩家
//		};
		public function CMD_S_CancelBanker()
		{
			
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_CancelBanker
		{
			var result:CMD_S_CancelBanker= new CMD_S_CancelBanker();
			result.wApplyUser=WORD.read(bytes);
			return result;
		}
	}
}