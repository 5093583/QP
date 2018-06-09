package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.DWORD;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_S_GameEnd
	{
		public var wProvideUser : int;						//供应用户
		public var cbProvideCard : uint;
		public var dwChiHuKind : Array;
		public var dwChiHuRight : Array;
		public var wFanCount : int;
		//积分信息
		public var lGameScore : Array;
		
		//麻将信息
		public var cbCardCount : Array;
		public var cbCardData : Array;
		public var cbHuCard : uint;							//胡牌数据
		public var cbFaceFanCount : uint;
		public var cbBaoPaiCount : uint;
		
		public var cbMingGangFan : uint;						//明杠翻数
		public var cbAnGangFan : uint;						//暗杠翻数
		public function CMD_S_GameEnd()
		{
			dwChiHuKind = Memory._newArrayAndSetValue(2,0);
			dwChiHuRight = Memory._newArrayAndSetValue(2,0);
			lGameScore = Memory._newArrayAndSetValue(2,0);
			cbCardCount = Memory._newArrayAndSetValue(2,0);
			cbCardData = Memory._newTwoDimension(2,14,0);
		}
		
		public static function _readBuffer(bytes : ByteArray) : CMD_S_GameEnd
		{
			var result : CMD_S_GameEnd = new CMD_S_GameEnd();
			result.wProvideUser = WORD.read(bytes);
			result.cbProvideCard = BYTE.read(bytes);
			
			var i : uint = 0;
			for( i = 0; i<2; i++ )
			{
				result.dwChiHuKind[i] = DWORD.read(bytes);
			}
			for( i = 0; i<2; i++ )
			{
				result.dwChiHuRight[i] = DWORD.read(bytes);
			}
			result.wFanCount = WORD.read(bytes);
			
			for( i = 0;i<2;i++ )
			{
				result.lGameScore[i] = LONG.read(bytes);
			}
			for( i = 0;i<2;i++ )
			{
				result.cbCardCount[i] = BYTE.read(bytes);
			}
			for(i = 0;i<2;i++)
			{
				for(var j : uint = 0;j<14;j++)
				{
					result.cbCardData[i][j] = BYTE.read(bytes);
				}
			}
			result.cbHuCard = BYTE.read(bytes);
			result.cbFaceFanCount = BYTE.read(bytes);
			result.cbBaoPaiCount = BYTE.read(bytes);
			
			result.cbMingGangFan = BYTE.read(bytes);
			result.cbAnGangFan = BYTE.read(bytes);
			return result;
		}
	}
}