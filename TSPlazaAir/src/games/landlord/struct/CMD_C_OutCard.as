package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;
	
	public class CMD_C_OutCard
	{
		public var bCardCount 	: uint;							//出牌数目
		public var bCardData	: Array;						//扑克列表
		
		private var _size : uint;
		public function CMD_C_OutCard()
		{
			bCardData = Memory._newArrayAndSetValue(20,0);
			_size = 21;
		}
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			BYTE.write(bCardCount,bytes);
			_size = bCardCount;
			for(var i : uint = 0;i<bCardCount;i++)
			{
				BYTE.write(bCardData[i],bytes);
			}
			return bytes;
		}
		public function get size() : uint
		{
			return _size + 1;
		}
	}
}