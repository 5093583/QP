package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_C_Trustee
	{
		public var bTrustee : uint;
		public function CMD_C_Trustee()
		{
			bTrustee = 0;
		}
		
		public function toBuffer() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			BYTE.write(bTrustee,bytes);
			
			return bytes;
		}
		
		public function get size() : uint
		{
			return 1;
		}
	}
}