package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	//游戏空闲
	public class CMD_S_GameFree
	{
		public static const SIZE :uint=2;
		public var cbTimeLeave : uint;//剩余时间
		public function CMD_S_GameFree()
		{
		}
		public static function _readBuffer(bytes :ByteArray) :CMD_S_GameFree
		{
			var result : CMD_S_GameFree = new CMD_S_GameFree();
			result.cbTimeLeave=BYTE.read(bytes);
			return result;
		}
	}
}