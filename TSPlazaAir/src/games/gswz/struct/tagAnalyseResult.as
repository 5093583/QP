package games.gswz.struct
{
	import flash.utils.ByteArray;
	
	public class tagAnalyseResult
	{
		
		public var cbFourCount:int;						//四张数目
		public var cbThreeCount:int;						//三张数目
		public var cbDoubleCount:int;						//两张数目
		public var cbSignedCount:int;						//单张数目
		public var cbFourLogicVolue:Array = new Array(1);				//四张列表
		public var cbThreeLogicVolue:Array = new Array(1);				//三张列表
		public var cbDoubleLogicVolue:Array = new Array(2);				//两张列表
		public var cbSignedLogicVolue:Array = new Array(5);				//单张列表
		public var cbFourCardData:ByteArray = new ByteArray;			//四张列表
		public var cbThreeCardData:ByteArray = new ByteArray;			//三张列表
		public var cbDoubleCardData:ByteArray = new ByteArray;		//两张列表
		public var cbSignedCardData:ByteArray = new ByteArray;		//单张数目
		
		
		
		public function tagAnalyseResult()
		{
		}
		
	}
}