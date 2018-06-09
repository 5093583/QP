package games.gswz.struct
{
	import flash.utils.ByteArray;
	
	import games.gswz.units.GswzConst;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_S_StatusPlay
	{
		//标志变量
		public var bShowHand : uint;							//梭哈标志
		public var bAddScore : uint;							//加注标志
		
		//加注信息
		public var lMaxScore : Number;							//最大下注
		public var lCellScore : Number;							//单元下注
		public var lTurnMaxScore : Number;						//最大下注
		public var lTurnLessScore : Number;						//最小下注
		public var lGuoDiScore : Number;						//锅底
		public var bShowHandNum : uint;						//第几张可以梭哈
		//状态信息
		public var wCurrentUser : int;						//当前玩家
		public var cbPlayStatus : Array;			//游戏状态
		public var lTableScore : Array;			//下注数目
		
		//扑克信息
		public var cbCardCount : Array;			//扑克数目
		public var cbHandCardData : Array;		//桌面扑克
		
		public var UserLessTime:int;						//当前定时器剩余时间
		public var TimeIDNow:int;							//当前正在使用的定时器ID
		public var UserOfftime : Array;			//用户断线时间
		public var bGameConfig : Array;
		
		
		
		public var cbIsTryPlay:uint;
		public var lTryPlayScore:Number;		
		
		
		public function CMD_S_StatusPlay()
		{
			cbPlayStatus = Memory._newArrayAndSetValue(GswzConst.GAME_PLAYER,0);
			lTableScore =  Memory._newArrayAndSetValue(GswzConst.GAME_PLAYER*2,0);
			
			cbCardCount = Memory._newArrayAndSetValue(GswzConst.GAME_PLAYER,0);
			cbHandCardData = new Array(GswzConst.GAME_PLAYER);
			for(var i : uint = 0;i<GswzConst.GAME_PLAYER;i++)
			{
				cbHandCardData[i] = Memory._newArrayAndSetValue(5,0); 
			}
			UserOfftime= Memory._newArrayAndSetValue(GswzConst.GAME_PLAYER,0);
			bGameConfig= Memory._newArrayAndSetValue(GswzConst.GAME_PLAYER,0);
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_StatusPlay
		{
			var result : CMD_S_StatusPlay = new CMD_S_StatusPlay();
			result.bShowHand = BYTE.read(bytes);
			result.bAddScore = BYTE.read(bytes);
		
			result.lMaxScore = LONG.read(bytes);
			result.lCellScore = LONG.read(bytes);
			result.lTurnMaxScore = LONG.read(bytes);
			result.lTurnLessScore = LONG.read(bytes);
			result.lGuoDiScore = LONG.read(bytes);
			result.bShowHandNum = BYTE.read(bytes);
			result.wCurrentUser = WORD.read(bytes);
			var i : uint=0,j : uint = 0;
			for(i = 0;i<GswzConst.GAME_PLAYER;i++)
			{
				result.cbPlayStatus[i] = BYTE.read(bytes);
			}
			for(i = 0;i<GswzConst.GAME_PLAYER*2;i++)
			{
				result.lTableScore[i] = LONG.read(bytes);
			}
			for(i = 0;i<GswzConst.GAME_PLAYER;i++)
			{
				result.cbCardCount[i] = BYTE.read(bytes);
			}
			for(i = 0;i<GswzConst.GAME_PLAYER;i++)
			{
				for(j = 0;j<5;j++)
				{
					result.cbHandCardData[i][j] = BYTE.read(bytes);
				}
			}
			result.UserLessTime = DWORD.read(bytes);
			result.TimeIDNow = DWORD.read(bytes);
			for(i = 0;i<GswzConst.GAME_PLAYER;i++)
			{
				result.UserOfftime[i] = DWORD.read(bytes);
			}
			for(i = 0;i<GswzConst.GAME_PLAYER;i++)
			{
				result.bGameConfig[i] = LONG.read(bytes);
			}
			
			
			
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONG.read(bytes);
			
			
			return result;
		}
	}
}