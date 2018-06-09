package games.zjh.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	
	/**
	 * ...
	 * @author xf
	 * //用户下注
	 */
	public class CMD_S_AddScore 
	{
		public static const SIZE : uint = 18;
		public var wCurrentUser : int;							//当前用户
		public var wAddScoreUser : int;							//加注用户
		public var wCompareState : int;							//比牌状态
	
		public var lAddScoreCount : Number;						//加注数目
		public var lMaxAddScore   : Number;						//最大加注
		public var lCurrentTimes  : Number;						//当前倍数
		public function CMD_S_AddScore() 
		{
			
		}
		public static function _readBuffer(bytes :ByteArray):CMD_S_AddScore
		{
			var result :CMD_S_AddScore = new CMD_S_AddScore();
			result.wCurrentUser = WORD.read(bytes);
			result.wAddScoreUser = WORD.read(bytes);
			result.wCompareState = WORD.read(bytes);
			result.lAddScoreCount = LONG.read(bytes);
			result.lMaxAddScore = LONG.read(bytes);
			result.lCurrentTimes = LONG.read(bytes);
			return result;
		}
		
	}

}