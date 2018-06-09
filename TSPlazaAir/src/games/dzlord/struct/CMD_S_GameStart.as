package games.dzlord.struct
{
	import flash.utils.ByteArray;
	
	import games.dzlord.utils.DZFor_9CMDconst;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_S_GameStart
	{
		public static const SIZE:uint=10;
		public var wCurrentUser:int;				//当前玩家第一个操作
		public var wDUser:int;						//庄家	
		public var wMaxChipInUser:int;				//小盲
		public var wBigUser:int;					//大盲
		public var lMaxScore:Number;				//本局封顶
		public var lCellScore:Number;				//单元下注
		public var lTurnMaxScore:Number;			//最大下注
		public var lTurnLessScore:Number;			//最小下注
		public var lAddLessScore:Number;			//加最小注
		public var cbCardData:Array;				//玩家手牌
		public var cbUserCount:uint;				//玩家人数
		
		public function CMD_S_GameStart()
		{
			cbCardData = new Array(DZFor_9CMDconst.GAME_PLAYER)
			for(var i : uint = 0;i<DZFor_9CMDconst.GAME_PLAYER;i++) { cbCardData[i] = new Array(2); }
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_GameStart
		{
			var result:CMD_S_GameStart=new CMD_S_GameStart();
			result.wCurrentUser=WORD.read(bytes);
			result.wDUser=WORD.read(bytes);
			result.wMaxChipInUser=WORD.read(bytes);
			result.wBigUser = WORD.read(bytes);
			result.lMaxScore=LONG.read(bytes);
			result.lCellScore=LONG.read(bytes);
			result.lTurnMaxScore=LONG.read(bytes);
			result.lTurnLessScore=LONG.read(bytes);
			result.lAddLessScore=LONG.read(bytes);
			for(var i:uint=0;i<DZFor_9CMDconst.GAME_PLAYER;i++)
			{
				for(var j:uint=0;j<2;j++)
				{
					result.cbCardData[i][j]=BYTE.read(bytes);
				}
			}
			result.cbUserCount=BYTE.read(bytes);
			return result;
		}
	}
}