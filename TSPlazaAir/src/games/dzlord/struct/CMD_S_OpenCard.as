package games.dzlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_OpenCard
	{
		public static const SIZE:uint=2;
		public var wWinUser:int;
		public function CMD_S_OpenCard()
		{
			
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_OpenCard
		{
			var result :CMD_S_OpenCard=new CMD_S_OpenCard();
			result.wWinUser=WORD.read(bytes);
			return result;
		}
	}
}