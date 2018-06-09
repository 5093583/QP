package games.gswz.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_C_ChangeCard
	{
		public var bIsChange : uint;							//是否换牌
		public function CMD_C_ChangeCard()
		{
		}
		public function toByteArray() : ByteArray
		{
			var result : ByteArray = Memory._newLiEndianBytes();
			BYTE.write(bIsChange,result);
			
			return result;
		}
		public function get szie() : uint
		{
			return 1;
		}
	}
}