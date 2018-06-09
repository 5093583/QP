package games.FiveStarBat.struct
{
	import flash.utils.ByteArray;
	
	import games.FiveStarBat.utils.ConstCmd;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.Memory;

	public class tagHistoryRecord
	{
		public static const SIZE : uint = 108;
		public var cbBigCount : uint;									//第几轮
		public var cbSmallCount : uint;									//第几局
		public var lBlackCount : Number;                        //黑桃出现次数
		public var lRedCount : Number;                          //红桃出现次数
		public var lFlowerCount : Number;                      //梅花出现次数
		public var lSquareCount : Number;                      //方片出现次数
		public var lKingCount : Number;                          //大小王出现次数
		public var cbHistoryRcord : Array;				//历史记录
		public function tagHistoryRecord()
		{
			cbHistoryRcord = Memory._newArrayAndSetValue(66,0);
		}
		public static function _readBuffer(bytes :ByteArray):tagHistoryRecord
		{
			var result : tagHistoryRecord = new tagHistoryRecord();
			result.cbBigCount = BYTE.read(bytes);
			result.cbSmallCount = BYTE.read(bytes);
			result.lBlackCount = LONGLONG.read(bytes);
			result.lRedCount = LONGLONG.read(bytes);
			result.lFlowerCount = LONGLONG.read(bytes);
			result.lSquareCount = LONGLONG.read(bytes);
			result.lKingCount = LONGLONG.read(bytes);
			for(var i:int=0;i<ConstCmd.MAX_GAMECOUNT;i++)
			{
				result.cbHistoryRcord[i]=BYTE.read(bytes);
			}		
			return result;
		}
	}
}