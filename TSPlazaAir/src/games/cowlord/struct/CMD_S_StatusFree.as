package games.cowlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_S_StatusFree
	{
		public static const SIZE:uint=10;
		public var	cbTimeLeave:uint;					//剩余时间
		public var  lUserMaxScore:Number;				//玩家金币
		public var 	wBankerUser:int;					//当前庄家
		public var  bEnableSysBanker:uint;				//系统做庄	
		public var  lApplyBankerCondition:Number;		//申请条件
		public var  lAreaLimitScore:Number;				//区域限制
		public var  lAreaLimitScoreLest:Number;			//最少金币限制
		public var  lChipScore:Array;					//下注分数
		public var  bCardRoomCount:uint;				//牌堆号码
		public var 	cbBankerTime:uint;					//庄家局数
		public var  lBankerWinScore:Number;				//庄家成绩
		public var  szRoomName:String;				    //房间名称
		
		public var cbIsTryPlay : uint;
		public var lTryPlayScore : Number;
		
		public var lBankerScore:Number;				//庄家分数		LONGLONG
		
		
		public function CMD_S_StatusFree()
		{
			lChipScore=Memory._newArrayAndSetValue(7,0);
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_StatusFree
		{
			var result:CMD_S_StatusFree	=	new CMD_S_StatusFree();
			result.cbTimeLeave			=	BYTE.read(bytes);
			result.lUserMaxScore		=	LONGLONG.read(bytes);
			result.wBankerUser			=	WORD.read(bytes);
			result.bEnableSysBanker		=	BYTE.read(bytes);
			result.lApplyBankerCondition=	LONGLONG.read(bytes);
			result.lAreaLimitScore		=	LONGLONG.read(bytes);
			result.lAreaLimitScoreLest	=	LONGLONG.read(bytes);
			
			for(var i:uint=0;i<7;i++)
			{
				result.lChipScore[i]=LONGLONG.read(bytes);	
			}
			result.bCardRoomCount=BYTE.read(bytes);	
//			result.cbBankerTime = BYTE.read(bytes);	
			result.cbBankerTime = WORD.read(bytes);
			result.lBankerWinScore = LONGLONG.read(bytes);
			result.szRoomName	=	TCHAR.read(bytes,32);
			
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONGLONG.read(bytes);
			
			result.lBankerScore		=	LONGLONG.read(bytes);
			
			return result;
		}
			
	}
}