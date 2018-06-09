package games.zjh.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;

	public class CMD_S_Aide_Change
	{
		public var bIsChange : uint;
		public var cbCardData : Array;
		public function CMD_S_Aide_Change()
		{
			cbCardData = new Array(3);
		}
		
		public static function _readBuffer(pBuffer : ByteArray) : CMD_S_Aide_Change
		{
			var result : CMD_S_Aide_Change = new CMD_S_Aide_Change();
			
			result.bIsChange = BYTE.read(pBuffer);
			for(var i : uint = 0;i<3;i++)
			{
				result.cbCardData[i] = BYTE.read(pBuffer);
			}
			return result;
		}
	}
}