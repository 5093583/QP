package games.gswz.struct
{
	import flash.utils.ByteArray;
	
	import games.gswz.units.GswzConst;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.Memory;

	/**
	 * 游戏结束
	 */
	public class CMD_S_GameEnd 
	{
		public static const SIZE :uint = 34;
		public var lGameTax		 :Array;							//游戏税收
		public var lGameScore	 :Array;							//游戏得分
		public var cbCardData	 :Array;							//用户扑克
		public var cbCardType	 : Array;							//扑克类型
		public function CMD_S_GameEnd() 
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_GameEnd
		{
			var result : CMD_S_GameEnd = new CMD_S_GameEnd();
			var i : uint = 0;
			result.lGameTax = Memory._newArrayAndSetValue(GswzConst.GAME_PLAYER, 0);
			for (i = 0; i < GswzConst.GAME_PLAYER;i++ )
			{
				result.lGameTax[i] = LONG.read(bytes);
			}
			result.lGameScore = Memory._newArrayAndSetValue(GswzConst.GAME_PLAYER, 0);
			for (i = 0; i < GswzConst.GAME_PLAYER;i++ )
			{
				result.lGameScore[i] = LONG.read(bytes);
			}
			result.cbCardData = Memory._newArrayAndSetValue(GswzConst.GAME_PLAYER, 0);
			for (i = 0; i < GswzConst.GAME_PLAYER;i++ )
			{
				result.cbCardData[i] = BYTE.read(bytes);
			}
			result.cbCardType = Memory._newArrayAndSetValue(GswzConst.GAME_PLAYER, 0);
			for (i = 0; i < GswzConst.GAME_PLAYER;i++ )
			{
				result.cbCardType[i] = BYTE.read(bytes);
			}
			return result;
		}
	}
}