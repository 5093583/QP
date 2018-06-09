package games.zjh.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	/**
	 * ...
	 * @author xf
	 * 游戏结束
	 */
	public class CMD_S_GameEnd 
	{
		public static const SIZE : uint = 87;
		
		public var lGameTax 		: Number;					//游戏税收	
		public var lGameScore 		: Array;					//游戏得分
		public var cbCardData 		: Array;					//用户扑克
		public var cbCardType		: Array;			
		public var wCompareUser 	: Array;					//比牌用户
		public var wEndState 		: int;						//结束状态
		public var bCardType		: uint;						//胜利者牌型
		public function CMD_S_GameEnd() 
		{
			
		}
		public static function _readBuffer(bytes :ByteArray) : CMD_S_GameEnd
		{
			var result : CMD_S_GameEnd = new CMD_S_GameEnd();
			result.lGameTax = LONG.read(bytes);
			var i :uint = 0;
			var j : uint = 0;
			result.lGameScore = Memory._newArrayAndSetValue(5, 0);
			for ( i = 0; i < 5; i++ )
			{
				result.lGameScore[i] = LONG.read(bytes);
			}
			result.cbCardData = Memory._newTwoDimension(5,3);
			for ( i = 0; i < 5; i++ )
			{
				for (j = 0; j < 3; j++ )
				{
					result.cbCardData[i][j] = BYTE.read(bytes);
				}
			}
			result.cbCardType = Memory._newArrayAndSetValue(5, 0);
			for ( i = 0; i < 5; i++ )
			{
				result.cbCardType[i] = BYTE.read(bytes);
			}
			result.wCompareUser = Memory._newTwoDimension(5, 4);
			for ( i = 0; i < 5; i++ )
			{
				for (j = 0; j < 4; j++ )
				{
					result.wCompareUser[i][j] = WORD.read(bytes);
				}
			}
			result.wEndState = WORD.read(bytes);
			result.bCardType = BYTE.read(bytes);
			return result;
		}
	}
}
