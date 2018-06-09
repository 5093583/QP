package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;
	
	public class CMD_C_UserTrustee
	{
		public var wUserChairID : uint;						//玩家椅子
		public var bTrustee : int;							//托管标识
		public function CMD_C_UserTrustee()
		{
		}
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			WORD.write(wUserChairID,bytes);
			BYTE.write(bTrustee,bytes);
			return bytes;
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_C_UserTrustee
		{
			var result : CMD_C_UserTrustee = new CMD_C_UserTrustee();
			result.wUserChairID = WORD.read(bytes);
			result.bTrustee = BYTE.read(bytes);
			
			return result;
		}
		public function get size() : uint
		{
			return 3;
		}
	}
}