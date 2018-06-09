package games.gswz.struct
{
	import flash.utils.ByteArray;
	
	import games.gswz.units.GswzConst;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;
	
	/**
	 * ...
	 * @author xf
	 */
	public class CMD_S_SendCard 
	{
		public static const SIZE	: uint = 21;
		public var wCurrentUser		: int;						//当前用户
		public var lCellScore		: Number;					//最大下注
		public var lTurnLessScore	: Number;					//最小下注
		public var cbSendCardCount	: uint;						//发牌数目
		public var cbCardData		: Array;					//用户扑克
		
		public function CMD_S_SendCard() 
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_SendCard
		{
			var result :CMD_S_SendCard = new CMD_S_SendCard();
			result.wCurrentUser 	= WORD.read(bytes);
			result.lCellScore 		= LONG.read(bytes);
			result.lTurnLessScore 	= LONG.read(bytes);
			result.cbSendCardCount 	= BYTE.read(bytes);
			result.cbCardData 		= Memory._newTwoDimension(GswzConst.GAME_PLAYER, 2);
			for (var i :uint = 0; i < GswzConst.GAME_PLAYER; i++ )
			{
				for (var j :uint = 0; j < 2; j++ )
				{
					result.cbCardData[i][j] = BYTE.read(bytes);
				}
			}
			return result;
		}
		
	}

}
