package games.zjh.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_C_Aide1
	{
		public var cbCardData : Array;
		
		public function CMD_C_Aide1()
		{
			cbCardData = Memory._newTwoDimension(5,3,0);
		}
		
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			for(var i : uint =0;i<5;i++)
			{
				for(var j : uint=0;j<3;j++)
				{
					BYTE.write(cbCardData[i][j],bytes);
				}
			}
			
			return bytes;
		}
		
		public function get size() : uint
		{
			return 15;
		}
		
		
	}
}