package games.dzlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_C_Aide_Change
	{
		public var cbCardData:Array;
		public function CMD_C_Aide_Change()
		{
			cbCardData = Memory._newArrayAndSetValue(2,0);
		}
		public function toByArry():ByteArray
		{
			var bytes :ByteArray=Memory._newLiEndianBytes();
			for(var i:uint=0;i<2;i++) 
			{
				BYTE.write(cbCardData[i],bytes);
			}
			return bytes;
		}
		public function  get size():uint
		{
			return 2;	
		}
	}
}