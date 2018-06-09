package games.gswz.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_OpenCard
	{
		public var wChairID : int;							//开牌用户
		public var wCurrentUser : int;						//当前操作用户
		public function CMD_S_OpenCard()
		{
		}
		
		public static function _readBuffer(pBuffer : ByteArray) : CMD_S_OpenCard
		{
			var result : CMD_S_OpenCard = new CMD_S_OpenCard();
			
			result.wChairID = WORD.read(pBuffer);
			result.wCurrentUser = WORD.read(pBuffer);
			return result;
		}
	}
}