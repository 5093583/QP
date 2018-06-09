package games.zjh.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_S_Aide_Get
	{
		public var cbCardData : Array;
		public function CMD_S_Aide_Get()
		{
			cbCardData = Memory._newTwoDimension(5,3,0);
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_Aide_Get
		{
			var result : CMD_S_Aide_Get = new CMD_S_Aide_Get();
			
			for(var i : uint = 0;i<5;i++)
			{
				for(var j : uint = 0;j<3;j++)
				{
					result.cbCardData[i][j] = BYTE.read(bytes);		
				}
			}
			return result;
		}
	}
}