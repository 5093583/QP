package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;

	public class CMD_S_OutPlayerReson
	{
		public function CMD_S_OutPlayerReson()
		{
		}
		
		
		public var cbReson:int;

		
		public static function _readBuffer(bytes :ByteArray) :CMD_S_OutPlayerReson
		{
			var result :CMD_S_OutPlayerReson = new CMD_S_OutPlayerReson();
			result.cbReson =BYTE.read(bytes);
			return result;
		}
		
		
	}
}