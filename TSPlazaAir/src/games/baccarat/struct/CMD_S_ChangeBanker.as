package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.WORD;

	//切换庄家 
	public class  CMD_S_ChangeBanker
	{
		public var wBankerUser   :int;   //当庄玩家
		public var lBankerScore  :Number;  //玩家金币
		public function CMD_S_ChangeBanker()
		{			
		}
		public static function _readBuffer(bytes :ByteArray):CMD_S_ChangeBanker
		{
			var result :CMD_S_ChangeBanker= new CMD_S_ChangeBanker();
			result.wBankerUser	= WORD.read(bytes);
			result.lBankerScore = LONGLONG.read(bytes);
			return result;
		}		
	}
}