package games.cowlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_C_PlaceJetton
	{
//		//用户下注
//		struct CMD_C_PlaceJetton
//		{
//			BYTE							cbJettonArea;						//筹码区域
//			BYTE							lJettonScore;						//加注数目
//		};
		public var cbJettonArea:uint;
		public var lJettonScore:uint;

		public function CMD_C_PlaceJetton()
		{
			
		}
		public function toByteArry():ByteArray
		{
			var bytes:ByteArray=Memory._newLiEndianBytes();
			BYTE.write(cbJettonArea,bytes);
			BYTE.write(lJettonScore,bytes)
			
			return bytes;
		}
		public function get size():uint
		{
			return 2;
		}
	}
}