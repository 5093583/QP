package cx.client.logon.model.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.TCHAR;

	public class CMD_MSG_GongGao
	{
		public static const SIZE : uint = 513;
		
		public var MessageByte : uint;												//消息类型、紧急公告，普通消息
		public var MessageTxt : String;												//消息内容
		public function CMD_MSG_GongGao()
		{
			MessageByte = 0;
			MessageTxt = '';
		}
		public static function _readBuffer(pBuffer : ByteArray) : CMD_MSG_GongGao
		{
			var result : CMD_MSG_GongGao = new CMD_MSG_GongGao();
			result.MessageByte = BYTE.read(pBuffer);
			result.MessageTxt = TCHAR.read(pBuffer,512);
			return result;
		}
	}
}