package games.cowcow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;
	
	/**
	 * ...
	 * @author xf
	 * 用户叫庄
	 */
	public class CMD_C_CallBanker 
	{
		public var bBanker : uint;					//做庄标志
		public function CMD_C_CallBanker() 
		{
			
		}
		public function toByArray(): ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			BYTE.write(bBanker, bytes);
			return bytes;
		}
		public function get size(): uint
		{
			return 1;
		}
	}

}