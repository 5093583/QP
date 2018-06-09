package games.gswz.struct
{
	import flash.utils.ByteArray;
	
	import games.gswz.units.GswzConst;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	/**
	 * ...
	 * @author xf
	 * 游戏开始
	 */
	public class CMD_S_GameStart 
	{
		public static const SIZE	: uint = 24;
		public var lMaxScore		: Number;					//最大下注
		public var lCellScore		: Number;					//单元下注
		public var lTurnMaxScore	: Number;					//最大下注
		public var lTurnLessScore	: Number;					//最小下注
		public var lGuoDiScore		: Number;
		public var wCurrentUser		: int;						//当前玩家
		public var cbObscureCard	: uint;						//底牌扑克
		public var cbCardData		: Array;					//用户扑克
		
		
		public var bGameConfig : Array;
		
		public function CMD_S_GameStart() 
		{
			
		}
		public static function _readBuffer(bytes :ByteArray) : CMD_S_GameStart
		{
			var result : CMD_S_GameStart = new CMD_S_GameStart();
			result.lMaxScore = LONG.read(bytes);
			result.lCellScore = LONG.read(bytes);
			result.lTurnMaxScore = LONG.read(bytes);
			result.lTurnLessScore = LONG.read(bytes);
			result.lGuoDiScore =  LONG.read(bytes);
			result.wCurrentUser = WORD.read(bytes);
			result.cbObscureCard = BYTE.read(bytes);
			result.cbCardData = Memory._newArrayAndSetValue(GswzConst.GAME_PLAYER, 0);
			for (var i : uint = 0; i < GswzConst.GAME_PLAYER; i++ )
			{
				result.cbCardData[i] = BYTE.read(bytes);
			}
			
			result.bGameConfig = Memory._newArrayAndSetValue(5,0);
			for(i=0;i<5;i++)
			{
				result.bGameConfig[i] = LONG.read(bytes);
			}
			
			return result;
		}
		
	}

}