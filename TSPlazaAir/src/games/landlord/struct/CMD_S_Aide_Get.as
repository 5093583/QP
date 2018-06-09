package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_S_Aide_Get
	{
		public var cbUserCard : Array;
		public function CMD_S_Aide_Get()
		{
			cbUserCard = Memory._newTwoDimension(3,20,0);
		}
		
		public static function _readBuffer(pBuffer : ByteArray) : CMD_S_Aide_Get
		{
			var result : CMD_S_Aide_Get = new CMD_S_Aide_Get();
			
			for(var i : uint = 0;i<3;i++)
			{
				for(var j : uint = 0;j<20;j++)
				{
					result.cbUserCard[i][j] = BYTE.read(pBuffer);
				}
			}
			return result;
			
		}
	}
}