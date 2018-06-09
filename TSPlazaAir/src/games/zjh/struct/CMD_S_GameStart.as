package games.zjh.struct
{
	
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	
	/**
	 * ...
	 * @author xf
	 * //游戏开始
	 */
	public class CMD_S_GameStart 
	{
		public static const SIZE : uint = 28;
		public var  lMaxScore		: Number;					//最大下注
		public var  lCellScore		: Number;					//单元下注
		public var  lCurrentTimes	: Number;					//当前倍数
		public var  lUserMaxScore	: Number;					//分数上限
		public var 	lMaxCellScore	: Number;
		public var 	lGuoDiScore		: Number;						//锅底
		public var  wBankerUser		: int;						//庄家用户
		public var  wCurrentUser	: int;						//当前玩家
		public function CMD_S_GameStart() 
		{
		}
		public static function _readBuffer(bytes :ByteArray):CMD_S_GameStart
		{
			var result : CMD_S_GameStart = new CMD_S_GameStart();
			result.lMaxScore = LONG.read(bytes);
			result.lCellScore = LONG.read(bytes);
			result.lCurrentTimes = LONG.read(bytes);
			result.lUserMaxScore = LONG.read(bytes);
			result.lMaxCellScore = LONG.read(bytes);
			result.lGuoDiScore = LONG.read(bytes);
			result.wBankerUser = WORD.read(bytes);
			result.wCurrentUser = WORD.read(bytes);
			return result;
		}
	}
}
