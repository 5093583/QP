package games.dzlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_S_Card
	{
		public static const SIZE :uint=10;
		public var cbCards:uint;
		public function CMD_S_Card()
		{
			
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_Card
		{
			var result:CMD_S_Card=new CMD_S_Card();
			result.cbCards=Memory._newLiEndianBytes(52);
			for(var i:uint=0;i<52;i++)
			{
				result.cbCards[i]=BYTE.read(bytes);
			}
			return result;
		}
	}
}