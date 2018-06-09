package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;

	//游戏开始
	public class CMD_S_GameStart
	{
		public static const SIZE     :uint =26;
		public var wBankerUser       :int;      //庄家位置
		public var lBankerScore      :Number;   //庄家金币
		public var lUserMaxScore     :Number;   //我的金币
		public var cbTimeLeave       :uint;     //剩余时间
		public var nChipRobotCount   :int;      //人数上限
		
		
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
		
		
//		public var szGameNum:String;		//牌局号						szGameNum[22];
		
		public function CMD_S_GameStart()
		{
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_GameStart
		{
			var result : CMD_S_GameStart = new CMD_S_GameStart();
			result.wBankerUser 		= WORD.read(bytes);
			result.lBankerScore 	= LONGLONG.read(bytes);
			result.lUserMaxScore 	= LONGLONG.read(bytes);
			result.cbTimeLeave 		= BYTE.read(bytes);
//			result.nChipRobotCount 	= WORD.read(bytes);
			result.nChipRobotCount	= DWORD.read(bytes);
			
//			result.szGameNum 		= TCHAR.read(bytes, 22);
			
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