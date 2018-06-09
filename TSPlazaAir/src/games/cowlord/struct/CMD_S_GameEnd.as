package games.cowlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_S_GameEnd
	{
		public static const SIZE:uint=10;
		public var cbTimeLeave:uint;			//剩余时间
		public var cbBankerChairID:int;			//庄家ID
		public var cbTableCardArray:Array;		//桌面扑克
		public var  lBankerScore:Number;		//庄家金币
		public var 	lUserScore:Number;			//玩家本局赢多少
		public var lUserReturnScore:Number;		//返回金币
		public var lRevenue:Number;				//游戏税收	
		public var m_wSiceCount:Array;			//骰子点数
		public var lUserAreaWinScore:Array;		//玩家每个区域的得分
		public var dUserNum:Array;				//排名玩家ID
		public var lUserNumWinScore:Array;		//排名玩家上轮获胜积分
		public var bCardRoomCount:uint;			//牌堆号码
		public var lGameScore:Array;			//游戏分数
		public var m_cbCardOx:Array;			//结束牌型
		public var cbBankerTime:int;			//庄家局数
		public var lBankerTotallScore:Number;	//庄家成绩
		public var cbSortCardArray:Array;		//排序后牌型
		public var cbAreaWinner:Array;			//区域输赢标志（1庄赢,2玩家赢）
		public var m_cbUserScore:Number;		//玩家携带金币
		
		public var ExitUserLostScore:Number;								//玩家携带金币
						
		
		public  function CMD_S_GameEnd()
		{
			cbTableCardArray	=	Memory._newTwoDimension(5,5);
			 m_wSiceCount		=	Memory._newArrayAndSetValue(2,0);
			 lUserAreaWinScore	=	Memory._newArrayAndSetValue(4,0);
			 dUserNum			=	Memory._newArrayAndSetValue(4,0);
			 lUserNumWinScore	=	Memory._newArrayAndSetValue(4,0);
			 lGameScore			=	Memory._newArrayAndSetValue(5,0);
			 m_cbCardOx 		= 	Memory._newArrayAndSetValue(5,0);
			 cbSortCardArray	=	Memory._newTwoDimension(5,5);
			 cbAreaWinner		= 	Memory._newArrayAndSetValue(5,0);
			 
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_GameEnd
		{
			var result:CMD_S_GameEnd=new CMD_S_GameEnd();
			result.cbTimeLeave=BYTE.read(bytes);
			result.cbBankerChairID=WORD.read(bytes);
			var i:uint;
			var j:uint;
			for(i=0;i<5;i++)
			{
				for(j=0;j<5;j++)
				{
					result.cbTableCardArray[i][j]=BYTE.read(bytes);
				}
			}
			result.lBankerScore=LONGLONG.read(bytes);
			result.lUserScore=LONGLONG.read(bytes);
			result.lUserReturnScore=LONGLONG.read(bytes);
			result.lRevenue=LONGLONG.read(bytes);
			for(i=0;i<2;i++)
			{
				 result.m_wSiceCount[i]=BYTE.read(bytes);
			}
			for(i=0;i<4;i++)
			{
				result.lUserAreaWinScore[i]=LONGLONG.read(bytes);
			}
			for(i=0;i<4;i++)
			{
				result.dUserNum[i]=DWORD.read(bytes);
			}
			for(i=0;i<4;i++)
			{
				result.lUserNumWinScore[i]=LONGLONG.read(bytes);
			}
			result.lRevenue=BYTE.read(bytes);
			for(i=0;i<5;i++)
			{
				result.lGameScore[i]=LONG.read(bytes);
			}
			for(i=0;i<5;i++)
			{
				result.m_cbCardOx[i]=BYTE.read(bytes);
			}
			result.cbBankerTime = WORD.read(bytes);
			result.lBankerTotallScore = LONGLONG.read(bytes);
			for(i=0;i<5;i++)
			{
				for(j=0;j<5;j++)
				{
					result.cbSortCardArray[i][j]=BYTE.read(bytes);
				}
			}
			for(i=0;i<5;i++)
			{
				result.cbAreaWinner[i]=BYTE.read(bytes);
			}
			result.m_cbUserScore = LONGLONG.read(bytes);
			result.ExitUserLostScore = LONGLONG.read(bytes);
			return result;
		}
	}
}