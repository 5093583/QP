package games.dzlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_S_SendCard
	{
		public static const SIZE:uint=12;
		public var cbPublic:uint;				//是否公牌
		public var wCurrentUser:int;			//当前用户
		public var cbSendCardCount:uint;		//发牌数目
		public var cbCenterCardData:Array;		//中心扑克
		public function CMD_S_SendCard()
		{
			
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_SendCard
		{
			var result :CMD_S_SendCard=new CMD_S_SendCard();
			result.cbPublic=BYTE.read(bytes);
			result.wCurrentUser=WORD.read(bytes);
			result.cbSendCardCount=BYTE.read(bytes);
			result.cbCenterCardData=Memory._newArrayAndSetValue(5,0);
			
			for(var i:uint=0;i<5;i++)
			{
				result.cbCenterCardData[i]=BYTE.read(bytes);
			}				
			return result;
		}
	}
}