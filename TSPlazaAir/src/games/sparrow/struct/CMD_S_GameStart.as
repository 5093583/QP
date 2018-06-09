package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	/**
	 * @author xf
	 * 游戏开始
	 */
	public class CMD_S_GameStart 
	{
		public static const SIZE					: uint	= 51;
		public var lCellScore						: Number;								//房间底分
		public var wSiceCount						: Array;								//骰子点数
		public var wBankerUser						: int;									//庄家用户
		public var wCurrentUser						: int;									//当前用户
		public var cbCardData						: Array;								//麻将列表
		public var bTrustee	    					: Array;								//是否托管
	
		//花牌信息
		public var cbFaceCardIndex					: Array;								//花牌
		public var cbFaceCard						: Array;								//自己兑换的花牌
		public var cbLastPai						: uint;									//翻开底牌
		public var cbBaopai							: uint;									//宝牌
		public var cbRoomScoreAdd					: uint;									//当前桌子积分翻倍数

		public function CMD_S_GameStart() 
		{
			wSiceCount		= Memory._newArrayAndSetValue(2);
			cbCardData		= Memory._newArrayAndSetValue(13);
			bTrustee		= Memory._newArrayAndSetValue(2);
			cbFaceCardIndex = Memory._newTwoDimension(2,8);
			cbFaceCard		= Memory._newArrayAndSetValue(8);
		}
		public static function _readBuffer(bytes : ByteArray) :CMD_S_GameStart
		{
			var result : CMD_S_GameStart = new CMD_S_GameStart();
			result.lCellScore = LONG.read(bytes);
			var i : uint = 0;
			for( i =0;i<2;i++)
			{
				result.wSiceCount[i] = WORD.read(bytes);
			}
			result.wBankerUser 	= WORD.read(bytes);
			result.wCurrentUser = WORD.read(bytes);
			for (i = 0; i < 13; i++ )
			{
				result.cbCardData[i] = BYTE.read(bytes);
			}
			for (i = 0; i < 2; i++ )
			{
				result.bTrustee[i] = BYTE.read(bytes);
			}
			
			for(i = 0;i<2;i++)
			{
				for(var j : uint = 0;j<8;j++) {
					result.cbFaceCardIndex[i][j] = BYTE.read(bytes);
				}
			}
			
			for (i = 0; i < 8; i++ )
			{
				result.cbFaceCard[i] = BYTE.read(bytes);
			}
			result.cbLastPai = BYTE.read(bytes);
			result.cbBaopai = BYTE.read(bytes);
			result.cbRoomScoreAdd = BYTE.read(bytes);
			return result;
		}
	}
}