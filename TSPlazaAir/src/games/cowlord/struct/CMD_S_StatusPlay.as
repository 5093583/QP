package games.cowlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_S_StatusPlay
	{
		public static const SIZE:uint=10;
		
		
		
		public var m_lAllJettonScore:Array;			//全体总注		LONGLONG
		public var m_lUserJettonScore:Array;		//个人总注		LONGLONG
		public var lUserMaxScore:Number;			//最大下注		LONGLONG
		public var lApplyBankerCondition:Number;	//申请上装条件	LONGLONG
		public var lAreaLimitScore:Number;			//区域限制		LONGLONG
		public var cbCardCount:Array;				//扑克数目		BYTE
		public var cbTableCardArray:Array;			//桌面扑克		BYTE
		public var wBankerUser:int;					//当前庄家		WORD
		
		public var bEnableSysBanker:uint;			//系统做庄		BYTE
		public var lBankerScore:Number;				//庄家分数		LONGLONG
		public var lEndUserScore:Number;			//玩家成绩		LONGLONG
		public var lEndUserReturnScore:Number;		//返回积分		LONGLONG
		public var lEndRevenue:Number;				//游戏税收		LONGLONG
		public var cbTimeLeave:uint;				//剩余时间		BYTE
		public var cbTimeJotton:uint;				//下注时间		BYTE
		public var cbGameStatus:uint;				//游戏状态		BYTE
		
		public var lAreaLimitScoreLest:Number;		//最少金币限制	LONGLONG	
		public var lChipScore:Array;				//区域下注		LONGLONG
		public var bCardRoomCount:uint;				//牌堆号码		BYTE
		public var cbBankerTime:int;				//庄家局数		WORD
		public var lBankerWinScore:Number;			//庄家赢分		LONGLONG
		public var cbCardType:Array;				//排序后牌型		BYTE
		public var wSiceCount:Array	;				//骰子点数		BYTE
		public var lAreaWinner:Array;				//区域输赢(1庄赢,2玩家赢)	BYTE
		public var szRoomName:String;				//房间名称
		
		
		public var cbIsTryPlay : uint;
		public var lTryPlayScore : Number;
		
		
		public function CMD_S_StatusPlay()
		{
			m_lAllJettonScore	=	Memory._newArrayAndSetValue(4,0);
			m_lUserJettonScore	=	Memory._newArrayAndSetValue(4,0);
			cbCardCount			=	Memory._newArrayAndSetValue(5,0);
			cbTableCardArray	=	Memory._newTwoDimension(5,5);
			lChipScore			=	Memory._newArrayAndSetValue(7,0);
			cbCardType			=	Memory._newArrayAndSetValue(5,0);
			wSiceCount			= 	Memory._newArrayAndSetValue(2,0);
			lAreaWinner			= 	Memory._newArrayAndSetValue(5,0);
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_StatusPlay
		{
			var result:CMD_S_StatusPlay=new CMD_S_StatusPlay();
			var i:uint;
			var j:uint;
			for(i=0;i<4;i++)
			{
				result.m_lAllJettonScore[i]=LONGLONG.read(bytes);	
			}
			for(i=0;i<4;i++)
			{
				result.m_lUserJettonScore[i]=LONGLONG.read(bytes);
			}				
			result.lUserMaxScore			=	LONGLONG.read(bytes);
			result.lApplyBankerCondition	=	LONGLONG.read(bytes);
			result.lAreaLimitScore			=	LONGLONG.read(bytes);
			for(i=0;i<5;i++)
			{
				result.cbCardCount[i]=BYTE.read(bytes);
			}
			for(i=0;i<5;i++)
			{
				for(j=0;j<5;j++)
				{
					result.cbTableCardArray[i][j]=BYTE.read(bytes);
				}
			}
			result.wBankerUser			=	WORD.read(bytes);
			result.bEnableSysBanker 	=	BYTE.read(bytes);
			result.lBankerScore			=	LONGLONG.read(bytes);
			result.lEndUserScore		=	LONGLONG.read(bytes);
			result.lEndUserReturnScore	=	LONGLONG.read(bytes);
			result.lEndRevenue			=	LONGLONG.read(bytes);
			result.cbTimeLeave			=	BYTE.read(bytes);
			result.cbTimeJotton			=	BYTE.read(bytes);
			result.cbGameStatus			=	BYTE.read(bytes);
			result.lAreaLimitScoreLest	=	LONGLONG.read(bytes);
			for(i=0;i<7;i++)
			{
				result.lChipScore[i]	=	LONGLONG.read(bytes);
			}
			result.bCardRoomCount		=	BYTE.read(bytes);
			result.cbBankerTime			=   WORD.read(bytes);
			result.lBankerWinScore 		= 	LONGLONG.read(bytes);
			for(i=0;i<5;i++)
			{
				result.cbCardType[i]=BYTE.read(bytes);
			}
			for(i=0;i<2;i++)
			{
				result.wSiceCount[i]	=	BYTE.read(bytes);
			}
			for(i=0;i<5;i++)
			{
				result.lAreaWinner[i]	=	BYTE.read(bytes);
			}
			result.szRoomName	=	TCHAR.read(bytes,32);
			
			
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONGLONG.read(bytes);
			
			return result;
		}
	}
}