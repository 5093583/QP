package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;

	public class tagMatchRankList
	{
		public var dwTaskID : int;
		public var bCount : uint;
		public var tagRankInfo : Array;
		public function tagMatchRankList()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : tagMatchRankList
		{
			var result : tagMatchRankList = new tagMatchRankList();
			
			result.dwTaskID = DWORD.read(bytes);
			result.bCount = BYTE.read(bytes);
			result.tagRankInfo = new Array(11);
			for(var i : uint = 0;i<result.bCount;i++)
			{
				result.tagRankInfo[i] = tagMatchRankInfo._readBuffer(bytes);
			}
			return result;
		}
		public function SortList() : void
		{
			tagRankInfo.sort(sortList);
		}
		private function sortList(t1 : tagMatchRankInfo,t2:tagMatchRankInfo) : int
		{
			if(t1.lScore > t2.lScore) return -1;
			else if(t1.lScore < t2.lScore) return 1;
			return 0;
		}
		public function Destroy() : void
		{
			if(tagRankInfo != null)
			{
				for each(var rank : tagMatchRankInfo in tagRankInfo)
				{
					rank = null;
				}
				tagRankInfo == null;
			}
		}
	}
}