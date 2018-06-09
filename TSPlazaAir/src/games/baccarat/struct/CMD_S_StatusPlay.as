package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.Memory;
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.WORD;

	//游戏状态
	public class CMD_S_StatusPlay
	{
	public static const SIZE 		:uint =	254;		
	//全局下注
	public var lAllTieScore		: Number;						//买平总注
	public var lAllBankerScore  	: Number;					//买庄总注
	public var lAllPlayerScore 	: Number;					//买闲总注
	public var lAllTieSamePointScore 	: Number;				//平天王注
	public var lAllBankerKingScore 	: Number;				//庄天王注
	public var lAllPlayerKingScore	: Number;				//闲天王注
	public var lAllPlayerTwoPair	: Number;					//闲家对子
	public var lAllBankerTwoPair	: Number;					//庄家对子
	//玩家下注
	public var lUserTieScore	: Number;						//买平总注
	public var lUserBankerScore	: Number;					//买庄总注
	public var lUserPlayerScore	: Number;					//买闲总注
	public var lUserTieSamePointScore	: Number;			//平天王注
	public var lUserBankerKingScore	: Number;				//庄天王注
	public var lUserPlayerKingScore	: Number;				//闲天王注
	public var lUserPlayerTwoPair	: Number;				//闲家对子
	public var lUserBankerTwoPair	: Number;				//庄家对子
	//玩家积分
	public var lUserMaxScore	: Number;						//最大下注							
	//控制信息
	public var lApplyBankerCondition	: Number;				//申请条件
	public var lAreaLimitScore	: Number;					//区域限制
	//扑克信息
 	public var cbCardCount : Array;							//扑克数目
	public var cbTableCardArray : Array;					//桌面扑克
	//庄家信息
	public var wBankerUser : int;							//当前庄家
	public var cbBankerTime : int;							//庄家局数
	public var lBankerWinScore	: Number;					//庄家赢分
	public var lBankerScore	: Number;						//庄家分数
	public var bEnableSysBanker :uint;						//系统做庄
	//结束信息
	public var lEndBankerScore 		: Number;					//庄家成绩
	public var lEndUserScore	: Number;						//玩家成绩
	public var lEndUserReturnScore	: Number;				//返回积分
	public var lEndRevenue	: Number;						//游戏税收
	//全局信息
	public var cbTimeLeave	:uint;							//剩余时间
	public var cbGameStatus	:uint;							//游戏状态
	//房间信息
	public var lAreaLimitScoreLest : Number;				//最少金币限制
	public var lChipScore		: Array;
	public var cbIsTryPlay : uint;
	public var lTryPlayScore : Number;
	public function CMD_S_StatusPlay() 
	{
		lChipScore = new Array();
	}
	public static function _readBuffer(bytes :ByteArray):CMD_S_StatusPlay
	{
		var result : CMD_S_StatusPlay = new CMD_S_StatusPlay();
		result.lAllTieScore 			= LONGLONG.read(bytes);
		result.lAllBankerScore 			= LONGLONG.read(bytes);
		result.lAllPlayerScore 			= LONGLONG.read(bytes);
		result.lAllTieSamePointScore	= LONGLONG.read(bytes);
		result.lAllBankerKingScore 		= LONGLONG.read(bytes);
		result.lAllPlayerKingScore 		= LONGLONG.read(bytes);
		result.lAllPlayerTwoPair 		= LONGLONG.read(bytes);
		result.lAllBankerTwoPair 		= LONGLONG.read(bytes);
		result.lUserTieScore 			= LONGLONG.read(bytes);
		result.lUserBankerScore 		= LONGLONG.read(bytes);
		result.lUserPlayerScore 		= LONGLONG.read(bytes);
		result.lUserTieSamePointScore 	= LONGLONG.read(bytes);
		result.lUserBankerKingScore 	= LONGLONG.read(bytes);
		result.lUserPlayerKingScore 	= LONGLONG.read(bytes);
		result.lUserPlayerTwoPair 		= LONGLONG.read(bytes);
		result.lUserBankerTwoPair 		= LONGLONG.read(bytes);
		result.lUserMaxScore 			= LONGLONG.read(bytes);
		result.lApplyBankerCondition 	= LONGLONG.read(bytes);
		result.lAreaLimitScore 			= LONGLONG.read(bytes);
		var i : uint = 0;
		result.cbCardCount = Memory._newArrayAndSetValue(2);
		for ( i = 0; i < 2; i++ )
		{
			result.cbCardCount[i] = BYTE.read(bytes);
		}
		
		result.cbTableCardArray =Memory._newTwoDimension(2,3);
		for ( i = 0; i < 2; i++ )
		{
			for (var j :uint = 0; j < 3; j++ )
			{
				result.cbTableCardArray[i][j] = BYTE.read(bytes);
			}
		}
		result.wBankerUser 		= WORD.read(bytes);
		result.cbBankerTime 	= WORD.read(bytes);
		result.lBankerWinScore 	= LONGLONG.read(bytes);
		result.lBankerScore 	= LONGLONG.read(bytes);
		result.bEnableSysBanker = BYTE.read(bytes);
		result.lEndBankerScore 	= LONGLONG.read(bytes);
		result.lEndUserScore 	= LONGLONG.read(bytes);					
		result.lEndUserReturnScore = LONGLONG.read(bytes);
		result.lEndRevenue 		= LONGLONG.read(bytes);											
		result.cbTimeLeave 		= BYTE.read(bytes);					
		result.cbGameStatus 	= BYTE.read(bytes);
		result.lAreaLimitScoreLest	= LONGLONG.read(bytes);			
		for ( i = 0; i < 7; i++ )
		{
			result.lChipScore[i] = LONGLONG.read(bytes);
		}
		result.cbIsTryPlay = BYTE.read(bytes);
		result.lTryPlayScore = LONGLONG.read(bytes);
		return result;
	}
	}	
}