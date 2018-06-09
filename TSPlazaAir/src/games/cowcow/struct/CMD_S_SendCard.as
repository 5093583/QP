package games.cowcow.struct
{
	
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;
	
	/**
	 * ...
	 * @author xf
	 * 发牌数据包
	 */
	public class CMD_S_SendCard 
	{
		
		public static const SIZE 		:uint = 20;
		public var cbCardData			:Array;							//用户扑克
		public function CMD_S_SendCard() 
		{
			cbCardData = Memory._newTwoDimension(4,5);
		}
		public static function _readBuffer(bytes : ByteArray) :CMD_S_SendCard
		{
			var result : CMD_S_SendCard = new CMD_S_SendCard();
			var i:uint = 0;
			var j:uint = 0;
			for (i = 0; i < 4; i++ )
			{
				for (j = 0; j < 5; j++ )
				{
					result.cbCardData[i][j] = BYTE.read(bytes);
				}
			}
			return result;
		}
	}
}

