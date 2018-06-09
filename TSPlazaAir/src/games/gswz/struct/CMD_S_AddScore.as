package games.gswz.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;

	/**
	 * ...
	 * @author xf
	 * 用户下注
	 */
	public class CMD_S_AddScore 
	{
		public static const SIZE 	: uint = 13;
		public var wCurrentUser		: int;						//当前用户
		public var wAddScoreUser	: int;						//加注用户
		public var lAddScoreCount	: Number;					//加注数目
		public var lTurnLessScore	: Number;					//最少加注
		public var cbControlType	: uint;
		public function CMD_S_AddScore() 
		{
			
		}
		public static function _readBuffer(bytes :ByteArray) :CMD_S_AddScore
		{
			var result : CMD_S_AddScore = new CMD_S_AddScore();
			result.wCurrentUser = WORD.read(bytes);
			result.wAddScoreUser = WORD.read(bytes);
			result.lAddScoreCount = LONG.read(bytes);
			result.lTurnLessScore = LONG.read(bytes);
			result.cbControlType = BYTE.read(bytes);
			return result;
		}
		
	}

}