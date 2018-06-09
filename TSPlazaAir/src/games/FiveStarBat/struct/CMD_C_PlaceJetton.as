package games.FiveStarBat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.Memory;

	public class CMD_C_PlaceJetton
	{
		public var cbJettonArea : uint;								//筹码区域
		public var lJettonScore : Number;								//加注数目
		public function CMD_C_PlaceJetton()
		{
		}
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			BYTE.write(cbJettonArea,bytes);
			LONGLONG.write(lJettonScore,bytes);
			return bytes;
		}
		public function get size() : uint
		{
			return 9;
		}
	}
}