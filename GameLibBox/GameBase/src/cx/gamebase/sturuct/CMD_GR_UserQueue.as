package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.WORD;

	public class CMD_GR_UserQueue
	{
		public var wQueueCount : uint;						//当前等待人数
		public function CMD_GR_UserQueue()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_GR_UserQueue
		{
			var result : CMD_GR_UserQueue = new CMD_GR_UserQueue();
			result.wQueueCount = WORD.read(bytes);
			return result;
		}
	}
}