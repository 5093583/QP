package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_GameStart
	{
		public static const SIZE : uint = 5;
		
		public var wLandUser : uint;							//地主玩家
		public var bLandScore : uint;							//地主分数
		public var wCurrentUser : uint;							//当前玩家
		public function CMD_S_GameStart()
		{
			
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_GameStart
		{
			var result : CMD_S_GameStart = new CMD_S_GameStart();
			
			result.wLandUser 	= WORD.read(bytes);
			result.bLandScore 	= BYTE.read(bytes);
			result.wCurrentUser = WORD.read(bytes);
			
			return result;
		}
	}
}