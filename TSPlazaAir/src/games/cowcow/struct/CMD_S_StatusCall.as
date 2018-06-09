package games.cowcow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_StatusCall
	{
		public var wCallBanker : int;						//叫庄用户
		public var lCellScore : Number;							//基础积分
		
		public var cbIsTryPlay:uint;
		public var lTryPlayScore:Number;
		
		public function CMD_S_StatusCall()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_StatusCall
		{
			var result : CMD_S_StatusCall = new CMD_S_StatusCall();
			
			result.wCallBanker = WORD.read(bytes);
			result.lCellScore = LONG.read(bytes);
			
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONG.read(bytes);
			
			return result;
		}
	}
}