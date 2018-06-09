package games.dzlord.struct
{
	import flash.utils.ByteArray;
	
	import games.dzlord.utils.DZFor_9CMDconst;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_S_StatusPlay
	{
		public static const SIZE:uint = 10;
		public var lMaxScore:Number;		//本局封顶
		public var lCellScore:Number;		//单元下注
		public var lTurnMaxScore:Number;	//最大下注
		public var lTurnLessScore:Number;	//最小下注
		public var lCellMaxScore:Number;	//加大小注
		public var lAddLessScore:Number;	//加最小注
		public var lTableScore:Array;//下注数目
		public var lTotalScore:Array;//累计下注
		public var lCenterScore:Number;//中心筹码
		public var wDUser:int;//庄家
		public var wCurrentUser:int;//当前操作玩家
		public var cbPlayStatus:Array;//游戏状态
		public var cbBalanceCount:uint;//平衡次数
		public var wBigUser:int;//大盲
		public var wSmallUser:int;//小盲
		public var cbCenterCardData:Array;//扑克数目
		public var cbHandCardData:Array;//桌面扑克
		public var UserLessTime:Number;//当前定时器剩余时间
		public var TimeIDNow:Number;//当前正在使用的定时器ID
		public var UserOfftime:Array;//用户断线时间 
		public var cbIsTryPlay:uint;//
		public var lTryPlayScore:Number;//用户断线时间 
		//状态信息

		public function CMD_S_StatusPlay()
		{

		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_StatusPlay
		{
			var result:CMD_S_StatusPlay = new CMD_S_StatusPlay();
			var i:int = 0;
			result.lMaxScore = LONG.read(bytes);
			result.lCellScore = LONG.read(bytes);
			result.lTurnMaxScore = LONG.read(bytes);
			result.lTurnLessScore = LONG.read(bytes);
			result.lCellMaxScore = LONG.read(bytes);
			result.lAddLessScore = LONG.read(bytes);
			result.lTableScore = Memory._newArrayAndSetValue(DZFor_9CMDconst.GAME_PLAYER,0);
			for (i=0; i<DZFor_9CMDconst.GAME_PLAYER; i++)
			{
				result.lTableScore[i] = LONG.read(bytes);
			}
			result.lTotalScore = Memory._newArrayAndSetValue(DZFor_9CMDconst.GAME_PLAYER,0);
			for (i=0; i<DZFor_9CMDconst.GAME_PLAYER; i++)
			{
				result.lTotalScore[i] = LONG.read(bytes);
			}
			result.lCenterScore = LONG.read(bytes);
			result.wDUser = WORD.read(bytes);
			result.wCurrentUser = WORD.read(bytes);
			result.cbPlayStatus = Memory._newArrayAndSetValue(DZFor_9CMDconst.GAME_PLAYER,0);
			for (i=0; i<DZFor_9CMDconst.GAME_PLAYER; i++)
			{
				result.cbPlayStatus[i] = BYTE.read(bytes);
			}

			result.cbBalanceCount = BYTE.read(bytes);
			result.wBigUser = WORD.read(bytes);
			result.wSmallUser = WORD.read(bytes);

			result.cbCenterCardData = Memory._newArrayAndSetValue(5,0);
			for (i=0; i<5; i++)
			{
				result.cbCenterCardData[i] = BYTE.read(bytes);
			}
			result.cbHandCardData = Memory._newArrayAndSetValue(2,0);
			for (i=0; i<2; i++)
			{
				result.cbHandCardData[i] = BYTE.read(bytes);
			}
			result.UserLessTime = DWORD.read(bytes);
			result.TimeIDNow = DWORD.read(bytes);
			result.UserOfftime = Memory._newArrayAndSetValue(9,0);
			for (i=0; i<DZFor_9CMDconst.GAME_PLAYER; i++)
			{
				result.UserOfftime[i] = DWORD.read(bytes);
			}
			
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONG.read(bytes);
			return result;
		}
	}
}