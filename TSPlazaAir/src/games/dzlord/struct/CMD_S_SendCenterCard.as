package games.dzlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_S_SendCenterCard
	{
		public static const SIZE:uint=10;
		public var cbCenterCardData:Array;
		public function CMD_S_SendCenterCard()
		{
			
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_SendCenterCard
		{
			var result:CMD_S_SendCenterCard=new CMD_S_SendCenterCard();
			result.cbCenterCardData=Memory._newArrayAndSetValue(5,0);
			for(var i:uint;i<5;i++)
			{
				result.cbCenterCardData[i]=BYTE.read(bytes);
			}
			return result;
		}
	}
}