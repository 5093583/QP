package games.cowcow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;
	
	/**
	 * ...
	 * @author xf
	 */
	public class CMD_C_OxCard 
	{
		public var bOX	: uint;				//牛牛标志
		public var cbCardData : Array;				//用户扑克

		public function CMD_C_OxCard() 
		{
			cbCardData = Memory._newArrayAndSetValue(5,0);
		}
		public function toByArray(): ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			BYTE.write(bOX, bytes);
			for(var i : uint = 0;i<5;i++) { BYTE.write(cbCardData[i],bytes); }
			return bytes;
		}
		public function get size():uint
		{
			return 6;
		}
	}
}