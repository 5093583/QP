package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;

	public class tagMatchRankInfo
	{
		public static const SIZE : uint = 12;
		public var dwUserID : int;
		public var dwRank : int;
		public var lScore : Number;
		public function tagMatchRankInfo()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : tagMatchRankInfo
		{
			var result : tagMatchRankInfo = new tagMatchRankInfo();
			result.dwUserID = DWORD.read(bytes);
			result.dwRank = DWORD.read(bytes);
			result.lScore = LONG.read(bytes);
			return result;
		}
	}
}