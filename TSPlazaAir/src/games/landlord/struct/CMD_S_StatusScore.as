package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DOUBLE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;
	
	public class CMD_S_StatusScore
	{
		public static const SIZE : uint = 127;
		
		public var bLandScore 		: uint;						//地主分数
		public var lBaseScore 		: Number;					//基础积分
		public var wCurrentUser 	: int;						//当前玩家
		public var bScoreInfo		: Array;					//叫分信息
		public var bCardData		: Array;					//手上扑克
		public var bUserTrustee		: Array;					//玩家托管
		public var bCallScorePhase	: uint;						//叫牌阶段
		public var cbIsfengding : uint;
		public var cbIsTryPlay:uint;
		public var lTryPlayScore:Number;	
		public function CMD_S_StatusScore()
		{
			bScoreInfo 		= Memory._newArrayAndSetValue(3,0);
			bUserTrustee 	= Memory._newArrayAndSetValue(3,0);
			bCardData 		= Memory._newArrayAndSetValue(20,0);
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_StatusScore
		{
			var result : CMD_S_StatusScore = new CMD_S_StatusScore();
			var i : uint = 0;
			var j : uint = 0;
			
			result.bLandScore 	= BYTE.read(bytes);
			result.lBaseScore 	= LONG.read(bytes);
			result.wCurrentUser = WORD.read(bytes);
			for(i = 0;i<3;i++)
			{
				result.bScoreInfo[i] = BYTE.read(bytes);
			}
			for(i = 0;i<20;i++)
			{
				result.bCardData[i] = BYTE.read(bytes);
			}
			for(i = 0;i<3;i++)
			{
				result.bUserTrustee[i] = BYTE.read(bytes);
			}
			result.bCallScorePhase = BYTE.read(bytes);
			result.cbIsfengding = BYTE.read(bytes);
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONG.read(bytes);
			return result;
		}
	}
}