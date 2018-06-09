package cx.gamebase.sturuct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	
	[Bindable]
	public class tagUserScore
	{
		public var lScore : Number;								//用户分数
		public var lWinCount : Number;							//胜利盘数
		public var lLostCount : Number;							//失败盘数
		public var lDrawCount : Number;							//和局盘数
		public var lFleeCount : Number;							//断线数目
		public var lExperience : Number;						//用户经验
		public function tagUserScore()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : tagUserScore
		{
			var result : tagUserScore = new tagUserScore();
			result.lScore 		= LONG.read(bytes);
			result.lWinCount 	= LONG.read(bytes);
			result.lLostCount 	= LONG.read(bytes);
			result.lDrawCount 	= LONG.read(bytes);
			result.lFleeCount 	= LONG.read(bytes);
			result.lExperience 	= LONG.read(bytes);
			return result;
		}
		
		public function clone() : tagUserScore
		{
			var result : tagUserScore = new tagUserScore();
			result.lScore 		= this.lScore;
			result.lWinCount 	= this.lWinCount;
			result.lLostCount 	= this.lLostCount;
			result.lDrawCount 	= this.lDrawCount;
			result.lFleeCount 	= this.lFleeCount;
			result.lExperience 	= this.lExperience;
			return result;
		}
	}
}