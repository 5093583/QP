package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.WORD;

	// 更新积分
	
	public class CMD_S_ChangeUserScore
	{
		public static const SIZE          :uint                =26;
		public var   wChairID             :int;//椅子号码
		public var   lScore               :Number;             // 玩家积分
		public var   wCurrentBankerChairID  :int;             //当前庄家
		public var   cbBankerTime          :uint;              //庄家局数
		public var    lCurrentBankerScore   :Number;           //庄家分数
		public function  CMD_S_ChangeUserScore()
		{
			
		}
		public  static function  _readBuffer(bytes :ByteArray) : CMD_S_ChangeUserScore
		{
			var result : CMD_S_ChangeUserScore = new CMD_S_ChangeUserScore();
			result.wChairID 	=	WORD.read(bytes);
			result.lScore 		= 	LONGLONG.read(bytes);
			result.wCurrentBankerChairID = WORD.read(bytes);
			result.cbBankerTime = BYTE.read(bytes);
			result.lCurrentBankerScore =LONGLONG.read(bytes);
			return result;
		}
	}
}