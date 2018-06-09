package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_PlaceJetton2
	{
		public function CMD_S_PlaceJetton2()
		{
		}
		
		public var wChairID :int;								//用户位置	WORD
		public var cbJettonArea:int;
		public var lJettonScore : Number;		//加注数目		LONGLONG				lJettonScore[8]
		public var cbAndroidUser: uint;							//机器标识		BYTE
		
		
		
		//玩家下注
		public var lUserTieScore	: Number;						//买平总注
		public var lUserBankerScore	: Number;					//买庄总注
		public var lUserPlayerScore	: Number;					//买闲总注
		public var lUserTieSamePointScore	: Number;			//平天王注
		public var lUserBankerKingScore	: Number;				//庄天王注
		public var lUserPlayerKingScore	: Number;				//闲天王注
		public var lUserPlayerTwoPair	: Number;				//闲家对子
		public var lUserBankerTwoPair	: Number;				//庄家对子
		
		
		
		public var lAllTieScore		: Number;						//买平总注
		public var lAllBankerScore  : Number;					//买庄总注
		public var lAllPlayerScore 	: Number;					//买闲总注
		
		
		
		
		public static function _readBuffer(bytes : ByteArray ) :CMD_S_PlaceJetton2
		{
			var result : CMD_S_PlaceJetton2 = new CMD_S_PlaceJetton2();
			result.wChairID 		= WORD.read(bytes);
			result.cbJettonArea = BYTE.read(bytes);
			result.lJettonScore = LONGLONG.read(bytes);
//			for(var i:int=0; i<8; i++)
//			{
//				result.lJettonScore[i] = LONGLONG.read(bytes);
//			}
			result.cbAndroidUser 	= BYTE.read(bytes);
			
			
			result.lUserTieScore 			= LONGLONG.read(bytes);
			result.lUserBankerScore 		= LONGLONG.read(bytes);
			result.lUserPlayerScore 		= LONGLONG.read(bytes);
			result.lUserTieSamePointScore 	= LONGLONG.read(bytes);
			result.lUserBankerKingScore 	= LONGLONG.read(bytes);
			result.lUserPlayerKingScore 	= LONGLONG.read(bytes);
			result.lUserPlayerTwoPair 		= LONGLONG.read(bytes);
			result.lUserBankerTwoPair 		= LONGLONG.read(bytes);
			
			result.lAllTieScore 			= LONGLONG.read(bytes);
			result.lAllBankerScore 			= LONGLONG.read(bytes);
			result.lAllPlayerScore 			= LONGLONG.read(bytes);
			
			
			return result;
		}
		
	}
}