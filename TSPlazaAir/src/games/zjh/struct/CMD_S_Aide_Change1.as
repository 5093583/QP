package games.zjh.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_S_Aide_Change1
	{
		public var bIsChange : uint;
		public var cbCardData : Array;
		
		public function CMD_S_Aide_Change1()
		{
			cbCardData = Memory._newTwoDimension(5,3);
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_Aide_Change1
		{
			var result : CMD_S_Aide_Change1 = new CMD_S_Aide_Change1();
			
			result.bIsChange = BYTE.read(bytes);
			for(var i : uint =0;i<5;i++)
			{
				for(var j : uint =0;j<3;j++)
				{
					result.cbCardData[i][j] = BYTE.read(bytes);
				}
			}
			
			return result;
		}
		
	}
}