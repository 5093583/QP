package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;

	/**
	 * ...
	 * @author xf
	 */
	public class CMD_S_OutCard 
	{
		public static const SIZE 			:uint	= 3;
		public var wOutCardUser				:int;						//出牌用户
		public var cbOutCardData			:uint;						//出牌扑克
		public function CMD_S_OutCard() 
		{
			
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_OutCard
		{
			var result : CMD_S_OutCard = new CMD_S_OutCard();
			result.wOutCardUser = WORD.read(bytes);
			result.cbOutCardData = BYTE.read(bytes);
			return result;
		}
	}
}