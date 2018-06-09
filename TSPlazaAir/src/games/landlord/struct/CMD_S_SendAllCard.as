package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_SendAllCard
	{
		public static const SIZE : uint = 65;
		public var wCurrentUser	 : uint;						//当前玩家
		public var bCardData : Array;							//扑克列表
		public var bBackCardData : Array;						//底牌扑克
		public function CMD_S_SendAllCard()
		{
			bCardData 		= new Array(3);
			for(var i : uint = 0;i<3;i++)
			{
				bCardData[i] = new Array(20);
			}
			bBackCardData 	= new Array(3);
			
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_SendAllCard
		{
			var result : CMD_S_SendAllCard = new CMD_S_SendAllCard();
			result.wCurrentUser = WORD.read(bytes);
			var i : uint = 0;
			var j : uint = 0;
			for(i = 0;i<3;i++)
			{
				for(j = 0;j<20;j++)
				{
					result.bCardData[i][j] = BYTE.read(bytes);
				}
			}
			for(i = 0;i<3;i++)
			{
				result.bBackCardData[i] = BYTE.read(bytes);
			}
			return result;
		}
	}
}