package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_S_StatusDoubleScore
	{
		public var wLandUser  : uint;							//坑主玩家
		public var lBaseScore : Number;							//基础积分
		public var bLandScore : uint;							//地主分数
		public var bBackCard  	: Array;						//底牌扑克
		public var bCardData	: Array;						//手上扑克
		public var bCardCount : Array;						//扑克数目
		public var bUserTrustee : Array;			//玩家托管
		public var bAllowDouble : uint;						//允许加倍
		public var bDoubleUser : Array;			//加倍玩家
		public var cbIsFengding : uint;
		public var cbIsTryPlay:uint;
		public var lTryPlayScore:Number;	
		public function CMD_S_StatusDoubleScore()
		{
			bBackCard = Memory._newArrayAndSetValue(3,0);
			bCardData = Memory._newArrayAndSetValue(20,0);
			bCardCount = Memory._newArrayAndSetValue(3,0);
			bUserTrustee = Memory._newArrayAndSetValue(3,0);
			bDoubleUser = Memory._newArrayAndSetValue(3,0);
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_StatusDoubleScore
		{
			var result : CMD_S_StatusDoubleScore = new CMD_S_StatusDoubleScore();
			result.wLandUser = WORD.read(bytes);
			result.lBaseScore = LONG.read(bytes);
			result.bLandScore = BYTE.read(bytes);
			var i : uint = 0;
			for(i = 0;i<3;i++)
			{
				result.bBackCard[i] = BYTE.read(bytes);
			}
			for(i = 0;i<20;i++)
			{
				result.bCardData[i] = BYTE.read(bytes);
			}
			for(i = 0;i<3;i++)
			{
				result.bCardCount[i] = BYTE.read(bytes);
			}
			for(i = 0;i<3;i++)
			{
				result.bUserTrustee[i] = BYTE.read(bytes);
			}
			result.bAllowDouble = BYTE.read(bytes);
			for(i = 0;i<3;i++)
			{
				result.bDoubleUser[i] = BYTE.read(bytes);
			}
			result.cbIsFengding = BYTE.read(bytes);
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONG.read(bytes);
			return result;
		}
	}
}