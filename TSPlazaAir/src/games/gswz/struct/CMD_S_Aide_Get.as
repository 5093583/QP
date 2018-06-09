package games.gswz.struct
{
	import flash.utils.ByteArray;
	
	import games.gswz.units.GswzConst;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_S_Aide_Get
	{
		public var cbCardData : Array;
		public function CMD_S_Aide_Get()
		{
			cbCardData = Memory._newTwoDimension(GswzConst.GAME_PLAYER,5);
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_Aide_Get
		{
			var result : CMD_S_Aide_Get = new CMD_S_Aide_Get();
			
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