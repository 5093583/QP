package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_S_Aide_Get
	{
		public var cbCardData : Array;
		public var cbCenterCardData : Array;
		public var cbLeftIndex : uint;
		public function CMD_S_Aide_Get()
		{
			cbCardData = Memory._newArrayAndSetValue(14,0);
			cbCenterCardData = Memory._newArrayAndSetValue(64,0);
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_Aide_Get
		{
			bytes.position = 0;
			var result : CMD_S_Aide_Get = new CMD_S_Aide_Get();
			var i : uint = 0;
			for(i = 0;i<14;i++)
			{
				result.cbCardData[i] = BYTE.read(bytes);
			}
			for(i = 0;i<64;i++)
			{
				result.cbCenterCardData[i] = BYTE.read(bytes);
			}
			result.cbLeftIndex = BYTE.read(bytes);
			return result;
		}
	}
}