package games.cowcow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	/**
	 * ...
	 * @author ...
	 */
	public class CMD_S_Aide_Get 
	{
		public static const SIZE :uint = 20;
		public var cbCardData : Array;
		public var cbCardType : Array;
		public function CMD_S_Aide_Get() 
		{
			cbCardData = Memory._newTwoDimension(4,5);
			cbCardType = Memory._newArrayAndSetValue(4,0);
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_Aide_Get
		{
			var result : CMD_S_Aide_Get = new CMD_S_Aide_Get();
			var i:uint = 0;
			for ( i = 0; i < 4; i++ ) {
				for (var j:uint = 0; j < 5; j++ ) {
					
					result.cbCardData[i][j] = BYTE.read(bytes);
				}
			}
			for(i=0;i<4;i++)
			{
				result.cbCardType[i] = BYTE.read(bytes);
			}	
			return result;
		}
	}
}