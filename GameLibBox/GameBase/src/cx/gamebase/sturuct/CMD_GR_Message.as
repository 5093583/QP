package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;
	
	public class CMD_GR_Message
	{
		public var wMessageType : uint;						//消息类型
		public var wMessageLength : int;						//消息长度
		public var szContent : String;							//消息内容
		
		public function CMD_GR_Message()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_GR_Message
		{
			var msg : CMD_GR_Message = new CMD_GR_Message();
			msg.wMessageType 	= WORD.read(bytes);
			msg.wMessageLength 	= WORD.read(bytes);
			msg.szContent 		= TCHAR.read(bytes,msg.wMessageLength);
			return msg;
		}
	}
}