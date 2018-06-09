package games.gswz.struct
{
	import flash.utils.ByteArray;
	
	import games.gswz.units.GswzConst;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_S_Aide_Change
	{
		public var bIsChange : uint;
		public var cbCardData : Array;
		public function CMD_S_Aide_Change()
		{
			cbCardData = Memory._newTwoDimension(GswzConst.GAME_PLAYER,5);
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_Aide_Change
		{
			var result : CMD_S_Aide_Change = new CMD_S_Aide_Change();
			
			result.bIsChange = BYTE.read(bytes);
			for(var i : uint =0;i<GswzConst.GAME_PLAYER;i++)
			{
				for(var j : uint =0;j<5;j++)
				{
					result.cbCardData[i][j] = BYTE.read(bytes);
				}
			}
			
			return result;
		}
	}
}