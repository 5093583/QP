package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;

	/**
	 *游戏结束
	 * */
	public class CMD_S_GameEnd
	{
		public static const SIZE : uint = 73;
		public var lGameTax 	: Number;						//游戏税收
		public var lGameScore 	: Array;						//游戏积分
		public var bCardCount 	: Array;						//扑克数目
		public var bCardData 	: Array;						//扑克列表 
		public function CMD_S_GameEnd()
		{
			lGameScore = new Array(3);
			bCardCount = new Array(3);
			bCardData = new Array(54);
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_GameEnd
		{
			var result : CMD_S_GameEnd = new CMD_S_GameEnd();
			
			result.lGameTax = LONG.read(bytes);
			var i : uint = 0;
			for(i = 0;i<3;i++)
			{
				result.lGameScore[i] = LONG.read(bytes);
			}
			for(i = 0;i<3;i++)
			{
				result.bCardCount[i] = BYTE.read(bytes);
			}
			for(i = 0;i<54;i++)
			{
				result.bCardData[i] = BYTE.read(bytes);
			}
			return result;
		}
	}
}