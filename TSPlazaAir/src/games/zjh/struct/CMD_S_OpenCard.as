package games.zjh.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_OpenCard
	{
		public var wWinner : uint;							//胜利用户
		public function CMD_S_OpenCard()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_OpenCard
		{
			var result : CMD_S_OpenCard = new CMD_S_OpenCard();
			result.wWinner = WORD.read(bytes);
			return result;
		}
	}
}