package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	/**
	 * @author xf
	 *	出牌命令
	 */
	public class CMD_C_OutCard 
	{
		public var cbCardData :  uint;			//扑克数据
		public var cbTingCard : uint;
		public function CMD_C_OutCard() 
		{
		}
		public function toByteArray() : ByteArray
		{
			var bytes :ByteArray = Memory._newLiEndianBytes();
			
			BYTE.write(cbCardData, bytes);
			BYTE.write(cbTingCard, bytes);
			return bytes;
		}
		public function get size() :uint
		{
			return 2;
		}
	}
}