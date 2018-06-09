package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;

	public class tagTableStatus
	{
		public static const SIZE : uint = 2;
		public var bTableLock : uint;						//锁定状态
		public var bPlayStatus : uint;						//游戏状态
		
		public function tagTableStatus()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : tagTableStatus
		{
			var result : tagTableStatus = new tagTableStatus();
			result.bTableLock = BYTE.read(bytes);
			result.bPlayStatus =BYTE.read(bytes);
			
			return result;
		}
	}
}