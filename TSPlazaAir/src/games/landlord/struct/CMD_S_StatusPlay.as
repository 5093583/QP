package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DOUBLE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;
	
	public class CMD_S_StatusPlay
	{
		public static const SIZE 	: uint = 123;
		public var wLandUser 		: int;				//坑主玩家
		public var wBombTime 		: int;				//炸弹倍数
		public var lBaseScore		: Number;			//基础积分
		public var bLandScore		: uint;				//地主分数
		public var wLastOutUser		: int;				//出牌的人
		public var wCurrentUser		: int;				//当前玩家
		public var bBackCard		: Array;			//底牌扑克
		public var bCardData		: Array;			//手上扑克
		public var bCardCount		: Array;			//扑克数目
		public var bTurnCardCount	: uint;				//基础出牌
		public var bTurnCardData	: Array;			//出牌列表
		public var bDoubleUser		: Array;			//加倍玩家
		public var bUserTrustee		: Array;			//玩家托管
		
		public var UserLessTime		: int;						//当前定时器剩余时间
		public var TimeIDNow		: int;							//当前正在使用的定时器ID
		public var UserOfftime		: Array;			//用户断线时间
		public var IsFengding : uint;
		public var cbIsTryPlay:uint;
		public var lTryPlayScore:Number;	
		public function CMD_S_StatusPlay()
		{
			bBackCard = Memory._newArrayAndSetValue(3,0);
			bCardData = Memory._newArrayAndSetValue(20,0);
			bCardCount =  Memory._newArrayAndSetValue(3,0);
			bTurnCardData =   Memory._newArrayAndSetValue(20,0);
			bUserTrustee = Memory._newArrayAndSetValue(3,0);
			bDoubleUser = Memory._newArrayAndSetValue(3,0);
			UserOfftime =  Memory._newArrayAndSetValue(3,0);
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_StatusPlay
		{
			var reslut : CMD_S_StatusPlay = new CMD_S_StatusPlay();
			reslut.wLandUser 	= WORD.read(bytes);
			reslut.wBombTime 	= WORD.read(bytes);
			reslut.lBaseScore 	= LONG.read(bytes);
			reslut.bLandScore 	= BYTE.read(bytes);
			reslut.wLastOutUser = WORD.read(bytes);
			reslut.wCurrentUser = WORD.read(bytes);
			var i : uint = 0;
			
			for(i = 0;i<3;i++)
			{
				reslut.bBackCard[i] = BYTE.read(bytes);
			}
			for(i = 0;i<20;i++)
			{
			 	reslut.bCardData[i] = BYTE.read(bytes);
			}
			
			for(i = 0;i<3;i++)
			{
				reslut.bCardCount[i] 	= BYTE.read(bytes);
			}
			
			reslut.bTurnCardCount 		= BYTE.read(bytes);
			
			for(i = 0;i<20;i++)
			{
				reslut.bTurnCardData[i] = BYTE.read(bytes);
			}
			for(i = 0;i<3;i++)
			{
				reslut.bDoubleUser[i] 	= BYTE.read(bytes);	
			}
			for(i = 0;i<3;i++)
			{
				reslut.bUserTrustee[i] 	= BYTE.read(bytes);
			}
			
			reslut.UserLessTime = DWORD.read(bytes);
			reslut.TimeIDNow = DWORD.read(bytes);
			for(i = 0;i<3;i++)
			{
				reslut.UserOfftime[i] = DWORD.read(bytes);
			}
			reslut.IsFengding = BYTE.read(bytes);
			reslut.cbIsTryPlay = BYTE.read(bytes);
			reslut.lTryPlayScore = LONG.read(bytes);
			return reslut;
		}
	}
}