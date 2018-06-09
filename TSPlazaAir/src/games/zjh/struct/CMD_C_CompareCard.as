package games.zjh.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;
	
	/**
	 * ...
	 * @author xf
	 * //比牌数据包
	 */
	public class CMD_C_CompareCard 
	{
		public var wCompareUser : int;			//比牌用户
		public function CMD_C_CompareCard() 
		{
			
		}
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			WORD.write(wCompareUser, bytes);
			return bytes;
		}
		public function get size() : uint
		{
			return 2;
		}
	}
}