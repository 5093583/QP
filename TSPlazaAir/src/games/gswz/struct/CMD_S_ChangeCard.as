package games.gswz.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;
	

	public class CMD_S_ChangeCard
	{
		public static const SIZE : uint = 4;
		public var wChairID : int;						//用户桌位ID
		public var bIsChange : uint;							//是否换牌
		public var cbCardData : uint;							//用户扑克
		public function CMD_S_ChangeCard()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_ChangeCard
		{
			var result : CMD_S_ChangeCard = new CMD_S_ChangeCard();
			result.wChairID 	= WORD.read(bytes);
			result.bIsChange 	= BYTE.read(bytes);
			result.cbCardData	= BYTE.read(bytes);
			
			return result;
		}
		
	}
}