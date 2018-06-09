package games.cowcow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	/**
	 * ...
	 * @author xf
	 */
	public class CMD_S_Open_Card 
	{
		public static const SIZE		:uint = 8;
		public var wChairID : uint;							//摊牌用户
		public var bOX : uint;								//牛牛标志
		public var cbCardData : Array;						//用户扑克

		public function CMD_S_Open_Card() 
		{
			
		}
		public static function _readBuffer(bytes :ByteArray) : CMD_S_Open_Card
		{
			var result :CMD_S_Open_Card = new CMD_S_Open_Card();
			result.wChairID = WORD.read(bytes);
			result.bOX = BYTE.read(bytes);
			result.cbCardData = Memory._newArrayAndSetValue(5,0);
			for(var i : uint = 0;i<5;i++)
			{
				result.cbCardData[i] = BYTE.read(bytes);
			}
			return result;
		}
	}

}