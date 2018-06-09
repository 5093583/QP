package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;
	
	public class CMD_S_UserDouble
	{
		public static const SIZE : uint = 4;
		public var wDoubleUser : uint;						//加倍玩家
		public var bDoubleScore : uint;						//是否加倍
		public var bCurrentScore : uint;					//当前叫分
		public function CMD_S_UserDouble()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_UserDouble
		{
			var result : CMD_S_UserDouble = new CMD_S_UserDouble();
			
			result.wDoubleUser 		= WORD.read(bytes);
			result.bDoubleScore 	= BYTE.read(bytes);
			result.bCurrentScore 	= BYTE.read(bytes);
			
			return result;
		}
	}
}