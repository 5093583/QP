package games.cowcow.struct
{
	
	import flash.utils.ByteArray;
	
	import games.cowcow.units.CowcowConst;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_StatusScore
	{
		public var lTurnCellScore : Number;					//最大下注
		public var lTableScore : Array;						//下注数目
		public var cbPlayStatus: Array;						//玩家状态
		public var wBankerUser : int;						//庄家用户
		
		
		public var cbIsTryPlay:uint;
		public var lTryPlayScore:Number;	
		
		
		public function CMD_S_StatusScore()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_StatusScore
		{
			var result : CMD_S_StatusScore = new CMD_S_StatusScore();
			
			result.lTurnCellScore = LONG.read(bytes);
			result.lTableScore = new Array(CowcowConst.GAME_PLAYER);
			var i : uint = 0;
			for( i = 0;i<CowcowConst.GAME_PLAYER;i++)
			{
				result.lTableScore[i] = LONG.read(bytes);
			}
			result.cbPlayStatus = new Array(CowcowConst.GAME_PLAYER);
			for( i = 0;i<CowcowConst.GAME_PLAYER;i++)
			{
				result.cbPlayStatus[i] = BYTE.read(bytes);
			}
			result.wBankerUser = WORD.read(bytes);
			
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONG.read(bytes);
			
			return result;
		}
	}
}