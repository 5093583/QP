package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.TCHAR;

	public class CMD_GR_QueueField
	{
		public var szFailedDescribe : String;
		public function CMD_GR_QueueField()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GR_QueueField
		{
			var result : CMD_GR_QueueField = new CMD_GR_QueueField();
			result.szFailedDescribe = TCHAR.read(bytes,256);
			return result;
		}
	}
}