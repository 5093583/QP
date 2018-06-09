package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;

	public class CMD_GF_Message
	{
		public static const SIZE : uint = 1028;
		
		public var wMessageType : uint;					//消息类型
		public var wMessageLength : uint;				//消息长度
		public var szContent : String;					//消息内容
		public function CMD_GF_Message()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GF_Message
		{
			var result : CMD_GF_Message = new CMD_GF_Message();
			
			result.wMessageType 	= WORD.read(bytes);
			result.wMessageLength 	= WORD.read(bytes);
			
			result.szContent = TCHAR.read(bytes,1024);
			
			return result;
		}
		
	}
}