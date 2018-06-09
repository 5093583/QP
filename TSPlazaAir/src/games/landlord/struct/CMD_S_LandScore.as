package games.landlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;
	
	public class CMD_S_LandScore
	{
		public static const SIZE : uint = 12;
		
		
		public var bLandUser : uint;							//叫分玩家
		public var wCurrentUser : uint;							//当前玩家
		public var bLandScore : uint;							//上次叫分
		public var bCurrentScore : uint;						//当前叫分
		public var bStartDoubleScore : uint;					//叫分结束
		public var wBankUser		 : uint;
		public var bBackCard	: Array;						//公共牌
		public function CMD_S_LandScore()
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_LandScore
		{
			var result : CMD_S_LandScore = new CMD_S_LandScore();
			
			result.bLandUser 		= WORD.read(bytes);
			result.wCurrentUser 	= WORD.read(bytes);
			result.bLandScore 		= BYTE.read(bytes);
			result.bCurrentScore 	= BYTE.read(bytes);
			result.bStartDoubleScore = BYTE.read(bytes);
			result.wBankUser 		= WORD.read(bytes);
			result.bBackCard 		= new Array(3);
			for(var i : uint = 0;i<3;i++)
			{
				result.bBackCard[i] = BYTE.read(bytes);
			}
			return result;
		}
	}
}