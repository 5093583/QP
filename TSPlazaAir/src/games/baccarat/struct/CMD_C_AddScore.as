package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.Memory;

	//用户下注
	public class CMD_C_AddScore 
	{
		public var cbJettonArea :uint;						//筹码区域
		public var lJettonScore :uint;						//加注数目
		public function CMD_C_AddScore()
		{		
		}
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			BYTE.write(cbJettonArea,bytes);
			BYTE.write(lJettonScore,bytes);
			return bytes;
		}
		public function get size() : uint
		{
			return 2;
		}
	 }
}