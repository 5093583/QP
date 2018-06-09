package games.cowlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_C_Aide
	{
		public static const SIZE:uint=10;
		public var bAreaWin:uint;
		public function CMD_C_Aide()
		{
			
		}
		public function toByteArry():ByteArray
		{
			var bytes:ByteArray=Memory._newLiEndianBytes();
			BYTE.write(bAreaWin,bytes);
			return bytes;
		}
		public function get size():uint
		{
			return 1;
		}
	}
}