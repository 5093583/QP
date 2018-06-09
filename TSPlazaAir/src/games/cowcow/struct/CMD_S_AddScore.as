package games.cowcow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;

	/**
	 * ...
	 * @author xf
	 * 用户下注
	 */
	public class CMD_S_AddScore 
	{
		public static const SIZE		:uint = 6;
		public var wAddScoreUser		:int;						//加注用户
		public var lAddScoreCount		:Number;					//加注数目
		public function CMD_S_AddScore() 
		{
			
		}
		public static function _readBuffer(bytes :ByteArray) : CMD_S_AddScore
		{
			var result :CMD_S_AddScore = new CMD_S_AddScore();
			result.wAddScoreUser = WORD.read(bytes);
			result.lAddScoreCount = LONG.read(bytes);
			return result;
		}
		
	}

}