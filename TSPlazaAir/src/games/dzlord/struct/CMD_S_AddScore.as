package games.dzlord.struct
{
	import flash.utils.ByteArray;
	
	import games.dzlord.utils.DZFor_9CMDconst;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_S_AddScore
	{
		public static const SIZE:uint=10;
		public var wCurrentUser:int;			//当前操作玩家
		public var wAddScoreUser:int;			//加注用户
		public var lAddScoreCount:Number;		//加注数目
		public var lTurnLessScore:Number;		//平衡当前注（跟注）
		public var lTurnMaxScore:Number;		//最大下注
		public var lAddLessScore:Number;		//加最小注
		public var cbShowHand:Array; 			//梭哈用户 
		
		
		public function CMD_S_AddScore()
		{
			
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_AddScore
		{
			var result :CMD_S_AddScore= new CMD_S_AddScore();
			result.wCurrentUser=WORD.read(bytes);
			result.wAddScoreUser=WORD.read(bytes);
			result.lAddScoreCount=LONG.read(bytes);
			result.lTurnLessScore=LONG.read(bytes);
			result.lTurnMaxScore=LONG.read(bytes);
			result.lAddLessScore=LONG.read(bytes);
			result.cbShowHand=Memory._newArrayAndSetValue(DZFor_9CMDconst.GAME_PLAYER,0);
			for(var i:uint=0;i<DZFor_9CMDconst.GAME_PLAYER;i++)
			{
				result.cbShowHand[i]=BYTE.read(bytes);
			}
			return result;
		}
	}
}