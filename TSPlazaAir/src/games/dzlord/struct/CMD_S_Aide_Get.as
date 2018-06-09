package games.dzlord.struct
{
	import away3d.errors.AbstractMethodError;
	
	import flash.utils.ByteArray;
	
	import games.dzlord.utils.DZFor_9CMDconst;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.Memory;

	public class CMD_S_Aide_Get
	{
		public static const SIZE:uint=10;
		public var cbCenterCardData:Array;
		public var cbCardData:Array;
		public function CMD_S_Aide_Get()
		{
			cbCenterCardData=Memory._newArrayAndSetValue(5);
			cbCardData=Memory._newTwoDimension(DZFor_9CMDconst.GAME_PLAYER,2);
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_Aide_Get
		{
			var result :CMD_S_Aide_Get=new CMD_S_Aide_Get();
			for(var i:uint=0;i<5;i++)
			{
				result.cbCenterCardData[i]=BYTE.read(bytes);
			}
			for(i=0;i<DZFor_9CMDconst.GAME_PLAYER;i++)
			{
				for(var j:uint=0;j<2;j++)
				{
					result.cbCardData[i][j]=BYTE.read(bytes);
				}
			}
			return result;
		}
	}
}