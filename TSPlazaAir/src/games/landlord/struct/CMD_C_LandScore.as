package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;
	
	public class CMD_C_LandScore
	{
		public var bLandScore : uint;							//地主分数
		public function CMD_C_LandScore()
		{
		}
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			BYTE.write(bLandScore,bytes);
			
			return bytes;
		}
		public function get size() : uint
		{
			return 1;
		}
	}
}