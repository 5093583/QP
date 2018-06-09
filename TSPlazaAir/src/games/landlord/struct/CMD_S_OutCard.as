package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;
	

	/**
	 * 用户出牌
	 * */
	public class CMD_S_OutCard
	{
		public var bCardCount : uint;						//出牌数目
		public var wCurrentUser : uint;						//当前玩家
		public var wOutCardUser : uint;						//出牌玩家
		public var bCardData : Array;						//扑克列表
		public function CMD_S_OutCard()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_OutCard
		{
			var result : CMD_S_OutCard = new CMD_S_OutCard();
			result.bCardCount 	= BYTE.read(bytes);
			result.wCurrentUser = WORD.read(bytes);
			result.wOutCardUser = WORD.read(bytes);
			result.bCardData = new Array(result.bCardCount);
			for(var i : uint = 0;i<result.bCardCount;i++)
			{
				result.bCardData[i] = BYTE.read(bytes);
			}
			return result;
		}
	}
}