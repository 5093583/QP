package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_PassCard
	{
		public static const SIZE : uint = 5;
		
		public var bNewTurn : uint;							//一轮开始
		public var wPassUser : uint;						//放弃玩家
		public var wCurrentUser : uint;						//当前玩家
		public function CMD_S_PassCard()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_PassCard
		{
			var result : CMD_S_PassCard = new CMD_S_PassCard();
			
			result.bNewTurn 	= BYTE.read(bytes);
			result.wPassUser 	= WORD.read(bytes);
			result.wCurrentUser = WORD.read(bytes);
			return result;
		}
	}
}