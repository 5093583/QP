package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.TCHAR;
	import t.cx.air.utils.CType.WORD;

	public class tagMatch
	{
		public static const SIZE : uint = 46;
		public var wServerID : int;
		public var dwTaskID : int;
		public var dwStartDate : int;
		public var dwEndDate : int;
		public var szTaskName : String;

		public function tagMatch()
		{
		}
		
		public static function _readBuffer(bytes : ByteArray) : tagMatch
		{
			var result : tagMatch = new tagMatch();
			result.wServerID 	= WORD.read(bytes);
			result.dwTaskID 	= DWORD.read(bytes);
			result.dwStartDate 	= DWORD.read(bytes);
			result.dwEndDate 	= DWORD.read(bytes);
			result.szTaskName 	= TCHAR.read(bytes,32);
			return result;
		}
		public function Destroy() : void
		{
			szTaskName = null;
		}
	}
}