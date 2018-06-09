package games.cowcow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;

	/**
	 * ...
	 * @author xf
	 * 游戏开始
	 */
	public class CMD_S_GameStart 
	{
		
		public var lTurnCellScore		:Number;					//单元下注
		public var wBankerUser			:int;						//庄家用户
		public var lTurnMaxScore        :Number						//最大下注
		
		public function CMD_S_GameStart() 
		{
		}	
		public static function _readBuffer(bytes :ByteArray) : CMD_S_GameStart
		{
			var result :CMD_S_GameStart = new CMD_S_GameStart();
			var i : int;
			result.lTurnCellScore 	= LONG.read(bytes);
			result.wBankerUser 		= WORD.read(bytes);
			result.lTurnMaxScore    = LONG.read(bytes);
			return result;
		}
	}
}