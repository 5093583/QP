package games.landlord.struct
{
	
	import flash.utils.ByteArray;
	
	import games.landlord.utils.LandConst;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DOUBLE;
	import t.cx.air.utils.CType.LONG;

	public class CMD_S_StatusFree
	{
		public static const SIZE : uint = 53;
		
		public var lBaseScore 		: Number;					//基础积分
		public var bIsfengding		: uint;						//是否封顶
		//历史积分
		public var lTurnScore		: Array;					//积分信息
		public var lCollectScore	: Array;					//积分信息
		public var cbIsTryPlay:uint;
		public var lTryPlayScore:Number;	
		public function CMD_S_StatusFree()
		{
			lTurnScore = new Array();
			lCollectScore = new Array();
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_StatusFree
		{
			var result : CMD_S_StatusFree = new CMD_S_StatusFree();
			result.lBaseScore = LONG.read(bytes);
			result.bIsfengding = BYTE.read(bytes);
			var i : uint = 0;
			for(i = 0; i<LandConst.GAME_PLAYER; i++)
			{
				result.lTurnScore.push(DOUBLE.read(bytes));
			}
			for(i = 0; i<LandConst.GAME_PLAYER; i++)
			{
				result.lCollectScore.push(DOUBLE.read(bytes));
			}
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONG.read(bytes);
			return result;
		}
	}
}