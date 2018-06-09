package games.sparrow.struct
{
	import t.cx.air.utils.Memory;

	public class tagGangCardResult
	{
		public var cbCardCount : uint;				//麻将数目
		public var cbCardData  : Array;				//麻将数据
		public var cbGangType  : Array;				//杠的类型
		public function tagGangCardResult()
		{
			cbCardCount = 0;
			cbCardData 	= Memory._newArrayAndSetValue(4,0);
			cbGangType	= Memory._newArrayAndSetValue(4,0);  
		}
	}
}