package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_Aide_SendCard
	{
		public var cbCardData : uint;
		public var wCurrentUser : int;
		public function CMD_S_Aide_SendCard()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_Aide_SendCard
		{
			bytes.position = 0;
			var result : CMD_S_Aide_SendCard = new CMD_S_Aide_SendCard();
			result.cbCardData = BYTE.read(bytes);
			result.wCurrentUser = WORD.read(bytes);
			return result;
		}
	}
}