package games.zjh.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_C_Aide
	{
		public var cbCardData : Array;
		public function CMD_C_Aide()
		{
			cbCardData = Memory._newArrayAndSetValue(3,0);
		}
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			for(var i : uint = 0;i<3;i++)
			{
				 BYTE.write(cbCardData[i],bytes);
			}
			return bytes;
		}
		
		public function get size() : uint
		{
			return 3;
		}
		
	}
}