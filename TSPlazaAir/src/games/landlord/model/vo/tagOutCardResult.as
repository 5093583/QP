package games.landlord.model.vo
{
	import t.cx.air.utils.Memory;

	public class tagOutCardResult
	{	
		public var cbCardCount : uint;						//扑克数目
		public var cbResultCard : Array;			//结果扑克
		public function tagOutCardResult()
		{
			cbCardCount = 0;
			cbResultCard = Memory._newArrayAndSetValue(20,0);
		}
	}
}