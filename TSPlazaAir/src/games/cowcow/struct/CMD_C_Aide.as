package games.cowcow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	/**
	 * ...
	 * @author ...
	 */
	public class CMD_C_Aide 
	{
		public var cbCardData : uint;
		public function CMD_C_Aide() 
		{
		}
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			BYTE.write(cbCardData, bytes);
			return bytes;
		}
		public function get size() : uint
		{
			return 1;
		}
	}

}