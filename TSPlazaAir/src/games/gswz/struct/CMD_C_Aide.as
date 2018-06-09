package games.gswz.struct
{
	import flash.utils.ByteArray;
	
	import games.gswz.units.GswzConst;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_C_Aide
	{
		public var cbCardData : Array;
		public function CMD_C_Aide()
		{
			cbCardData = Memory._newTwoDimension(GswzConst.GAME_PLAYER,5);
		}
		public function toByteArray() : ByteArray
		{
			var bytes : ByteArray = Memory._newLiEndianBytes();
			
			for(var i : uint =0;i<GswzConst.GAME_PLAYER;i++)
			{
				for(var j : uint=0;j<5;j++)
				{
					BYTE.write(cbCardData[i][j],bytes);
				}
			}
			
			return bytes;
		}
		public function get size() : uint{
			return GswzConst.GAME_PLAYER * 5;
		}
	}
}