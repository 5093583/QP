package games.sparrow.struct
{
	import t.cx.air.utils.Memory;

	public class tagSelectCardInfo
	{
		public var wActionMask 	: int;						//操作码
		public var cbActionCard : uint;						//操作牌
		public var cbCardCount 	: uint;						//选择数目
		public var cbCardData 	: Array;					//选择牌
		public function tagSelectCardInfo()
		{
			cbCardData = Memory._newArrayAndSetValue(14,0);
		}
	}
}