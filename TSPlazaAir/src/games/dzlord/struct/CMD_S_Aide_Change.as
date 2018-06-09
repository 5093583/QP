package games.dzlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_S_Aide_Change
	{
		public static const SIZE:uint=10;
		public var bIsChange:uint;
		public var cbCardData:Array; 
		public function CMD_S_Aide_Change()
		{
			cbCardData=Memory._newArrayAndSetValue(2);
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_Aide_Change
		{
			var result:CMD_S_Aide_Change=new CMD_S_Aide_Change();
			result.bIsChange=BYTE.read(bytes);
			for(var i:uint=0;i<2;i++)
			{
				result.cbCardData[i]=BYTE.read(bytes);
			}
			return result;
		}
	}
}