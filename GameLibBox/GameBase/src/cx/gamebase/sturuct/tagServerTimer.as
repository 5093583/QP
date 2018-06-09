package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;

	public class tagServerTimer
	{
		public static const SIZE : uint = 8;
		public var bTimerType	: uint;							//显示 隐藏
		public var bTimerKind	: uint;							//倒计时类型
		public var wChairID		: int;							//倒计时玩家
		public var lTimer		: Number;						//倒计时时间(s)
		public function tagServerTimer()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : tagServerTimer
		{
			var result : tagServerTimer = new tagServerTimer();
			
			result.bTimerType 	= BYTE.read(bytes);
			result.bTimerKind 	= BYTE.read(bytes);
			result.wChairID 	= WORD.read(bytes);
			result.lTimer 		= LONG.read(bytes);
			
			return result;
		}
	}
}