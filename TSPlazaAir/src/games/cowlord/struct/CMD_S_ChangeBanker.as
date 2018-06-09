package games.cowlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_ChangeBanker
	{
		public var wBankerUser:int;
		
		public var lBankerScore  :Number;  //玩家金币
		
//		//切换庄家
//		struct CMD_S_ChangeBanker
//		{
//			WORD							wBankerUser;						//当庄玩家
//		};
		
		public function CMD_S_ChangeBanker()
		{
			
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_ChangeBanker
		{
			var result :CMD_S_ChangeBanker=new CMD_S_ChangeBanker();
			result.wBankerUser=WORD.read(bytes);
			result.lBankerScore = LONGLONG.read(bytes);
			return result;
		}
	}
}