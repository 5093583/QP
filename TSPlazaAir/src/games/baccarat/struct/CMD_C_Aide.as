package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_C_Aide
	{
		public var bAreaWin : uint;
		public function CMD_C_Aide()
		{
			bAreaWin = 0;
		}
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			BYTE.write(bAreaWin,bytes);
			return bytes;
		}
		public function get size() : uint
		{
			return 1;
		}
	}
}