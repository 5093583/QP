package games.landlord.model.vo
{
	import t.cx.air.utils.Memory;

	public class tagAnalyseResult
	{
		public var cbFourCount : uint;				//四张数目
		public var cbThreeCount : uint;				//三张数目
		public var cbDoubleCount : uint;			//两张数目
		public var cbSignedCount : uint;			//单张数目
		public var cbFourCardData : Array;			//四张扑克
		public var cbThreeCardData : Array;			//三张扑克
		public var cbDoubleCardData	: Array;		//两张扑克
		public var cbSignedCardData	: Array;		//单张扑克
		
		public function tagAnalyseResult()
		{
			cbFourCount =  0;
			cbThreeCount =  0;
			cbDoubleCount =  0;
			cbSignedCount =  0;
			cbFourCardData = Memory._newArrayAndSetValue(20,0);
			
			cbThreeCardData = Memory._newArrayAndSetValue(20,0);
			cbDoubleCardData = Memory._newArrayAndSetValue(20,0);
			cbSignedCardData = Memory._newArrayAndSetValue(20,0);
		}
	}
}