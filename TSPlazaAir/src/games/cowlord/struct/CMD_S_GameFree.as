package games.cowlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;

	public class CMD_S_GameFree
	{
		public static const SIZE:uint=10;
		public var cbTimeLeave:uint;		//剩余时间
		public var bCardRoomCount:uint;	
		
		
//		//游戏空闲
//		struct CMD_S_GameFree
//		{
//			BYTE							cbTimeLeave;						//剩余时间
//			BYTE							bCardRoomCount;
//		};
		public function CMD_S_GameFree()
		{			
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_GameFree
		{
			var result:CMD_S_GameFree=new CMD_S_GameFree();
			result.cbTimeLeave		=	BYTE.read(bytes);
			result.bCardRoomCount	=	BYTE.read(bytes);
			
			return result;
		}
	}
}