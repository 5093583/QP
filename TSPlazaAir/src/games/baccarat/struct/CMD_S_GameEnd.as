package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	//游戏结束
	public class CMD_S_GameEnd
	{
		public static const SIZE 		:uint =	115;		
		//下局信息
		public var cbTimeLeave : uint;							//剩余时间
		//扑克信息
		public var cbCardCount :Array;							//扑克数目
		public var cbTableCardArray :Array;						//桌面扑克
		//庄家信息
		public var lBankerScore : Number;						//庄家成绩
		public var lBankerTotallScore :Number;					//庄家成绩
		public var nBankerTime :int;							//做庄次数
		//玩家成绩
		public var lUserScore :Number;							//玩家成绩
		public var lUserReturnScore :Number;					//返回积分
		//全局信息
		public var lRevenue :Number;							//游戏税收
		public var lUserAreaWinScore : Array;
		public function CMD_S_GameEnd() 
		{
			
		}
		public static function _readBuffer(bytes :ByteArray):CMD_S_GameEnd
		{
			var result : CMD_S_GameEnd = new CMD_S_GameEnd();
			result.cbTimeLeave 			= BYTE.read(bytes);
			var i : uint = 0;
			result.cbCardCount = Memory._newArrayAndSetValue(2);
			for ( i = 0; i < 2; i++ ) { result.cbCardCount[i] 	= BYTE.read(bytes); }
			result.cbTableCardArray =Memory._newTwoDimension(2,3);
			for ( i = 0; i < 2; i++ )
			{
				for (var j :uint = 0; j < 3; j++ ) { result.cbTableCardArray[i][j] = BYTE.read(bytes); }
			}
			result.lBankerScore 		= LONGLONG.read(bytes);
			result.lBankerTotallScore 	= LONGLONG.read(bytes);
			result.nBankerTime 			= WORD.read(bytes);
			result.lUserScore 			= LONGLONG.read(bytes);
			result.lUserReturnScore 	= LONGLONG.read(bytes);
			result.lRevenue 			= LONGLONG.read(bytes);
			
			result.lUserAreaWinScore		= Memory._newArrayAndSetValue(8,0);
			for(i = 0; i < 8; i++ ){ result.lUserAreaWinScore[i] = LONGLONG.read(bytes); }
			return result;
		}
	}
}