package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.WORD;

	public class tagOnLineCountInfo
	{
		public static const SIZE : uint = WORD.size + DWORD.size;
		public var wKindID : int;			//类型标识
		public var dwOnLineCount : int;	//在线人数
		public function tagOnLineCountInfo()
		{
			
		}
		
		public static function _readBuffer(bytes : ByteArray) : tagOnLineCountInfo
		{
			var online : tagOnLineCountInfo = new tagOnLineCountInfo();
			online.wKindID		= WORD.read(bytes);
			online.dwOnLineCount= DWORD.read(bytes);
			return online;
		}
	}
}