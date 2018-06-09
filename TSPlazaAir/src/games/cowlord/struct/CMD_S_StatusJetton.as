package games.cowlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_S_StatusJetton
	{
		public var lChipScore	: Array;	//筹码初始值
		public var cbTimeLeft	: uint;		//剩余时间
		public var wBankerUser	: int;		//当前庄家
		public var cbBankerTime : int;		//庄家局数
		public var  lApplyBankerCondition:Number;	//申请条件
		public var szRoomName:String;				//房间名称
		public var lAreaLimitScore:Number;				//区域限制
		
		
		public var cbIsTryPlay : uint;
		public var lTryPlayScore : Number;
		
		public var lBankerScore:Number;				//庄家分数		LONGLONG
		public var lUserMaxScore:Number;				//玩家金币
		
		
		public var bEnableSysBanker:uint;			//系统做庄		BYTE
		
		
		public function CMD_S_StatusJetton()
		{
			lChipScore = Memory._newArrayAndSetValue(7,0);
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_StatusJetton
		{
			var result:CMD_S_StatusJetton= new CMD_S_StatusJetton();
			for(var i:uint=0;i<7;i++)
			{
				result.lChipScore[i]=	LONGLONG.read(bytes);	
			}
			result.cbTimeLeft		=	BYTE.read(bytes);
			result.wBankerUser		=	WORD.read(bytes);
			result.cbBankerTime		=	WORD.read(bytes);
			result.lApplyBankerCondition	=	LONGLONG.read(bytes);
			result.szRoomName	=	TCHAR.read(bytes,32);
			result.lAreaLimitScore = LONGLONG.read(bytes);
			
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONGLONG.read(bytes);
			
			result.lBankerScore		=	LONGLONG.read(bytes);
			result.lUserMaxScore	=	LONGLONG.read(bytes);
			
			result.bEnableSysBanker 	=	BYTE.read(bytes);
			
			return result;
		}
	}
}