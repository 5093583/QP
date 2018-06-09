package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;

	public class CMD_GF_Option
	{
		public static const SIZE : uint = 2;
		public var bGameStatus 	: uint;					//游戏状态
		public var bAllowLookon	: uint;					//允许旁观
		public function CMD_GF_Option()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GF_Option
		{
			var result : CMD_GF_Option = new CMD_GF_Option();
			
			result.bGameStatus 	= BYTE.read(bytes);
			result.bAllowLookon = BYTE.read(bytes);
			
			return result;
		}
	}
}