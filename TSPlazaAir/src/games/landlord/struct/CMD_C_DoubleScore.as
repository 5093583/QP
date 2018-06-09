package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_C_DoubleScore
	{
		public var bDoubleScore : uint;						//玩家加倍
		public function CMD_C_DoubleScore()
		{
		}
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			BYTE.write(bDoubleScore,bytes);
			return bytes; 
		}
		
		public function get size() : uint
		{
			return 1;
		}
	}
}