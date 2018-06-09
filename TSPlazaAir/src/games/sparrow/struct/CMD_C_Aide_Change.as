package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_C_Aide_Change
	{
		public var cbID : uint; //牌墙中的位置i
		public var cbCardData : uint;
		public var cbChangeSelf : uint;
		public function CMD_C_Aide_Change()
		{
			cbChangeSelf = 0;
		}
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			BYTE.write(cbID,bytes);
			BYTE.write(cbCardData,bytes);
			BYTE.write(cbChangeSelf,bytes);
			return bytes;
		}
		
		public function get size() : uint
		{
			return 3;
		}
	}
}