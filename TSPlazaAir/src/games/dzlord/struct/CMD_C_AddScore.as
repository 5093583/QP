package games.dzlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.Memory;

	public class CMD_C_AddScore
	{
		public var lScore:Number;
		public function CMD_C_AddScore()
		{
			
		}
		public  function toByteArry():ByteArray
		{
			var bytes :	ByteArray =Memory._newLiEndianBytes();
			LONG.write(lScore,bytes);
			return bytes;
		}
		public function get size():uint
		{
			return 4;
		}
	}
}