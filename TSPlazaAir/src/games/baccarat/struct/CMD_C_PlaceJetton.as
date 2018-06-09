package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.Memory;

	public class CMD_C_PlaceJetton
	{
		public function CMD_C_PlaceJetton()
		{
		}
		public var cbJettonArea:int;
		public var lJettonScore : Number		//加注数目	lJettonScore[8]
		
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			BYTE.write(cbJettonArea,bytes);
			LONGLONG.write(lJettonScore, bytes);
//			for(var i:int=0; i<8; i++)
//			{
//				LONGLONG.write(lJettonScore[i], bytes);
//			}
			return bytes;
		}
		public function get size() : uint
		{
			return 9;
		}
		
	}
}