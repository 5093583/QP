package games.zjh.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	/**
	 * ...
	 * @author xf
	 * 
	 * //游戏状态
	 */
	public class CMD_S_StatusPlay 
	{
		public static const SIZE : uint = 54;
		
		public var lMaxCellScore : Number;			//单元上限
		public var lCellScore	 : Number;			//单元下注
		public var lCurrentTimes : Number;			//当前倍数
		public var lUserMaxScore : Number;			//用户分数上限
		public var lMaxScore	 : Number;			//当前最大加注
		public var lGuoDiScore	 : Number;			//锅底
		public var wBankerUser	 : int;				//庄家用户
		public var wCurrentUser	 : int;				//当前玩家
		public var cbPlayStatus  : Array;			//游戏状态
		public var bMingZhu		 : Array;			//看牌状态
		public var lTableScore   : Array;			//下注数目
		public var cbHandCardData: Array;			//扑克数据
		public var bCompareState : uint;			//比牌状态
		
		public var cbIsTryPlay:uint;
		public var lTryPlayScore:Number;				
		
		public function CMD_S_StatusPlay() 
		{
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_StatusPlay
		{
			var result : CMD_S_StatusPlay = new CMD_S_StatusPlay();
			result.lMaxCellScore = LONG.read(bytes);
			result.lCellScore = LONG.read(bytes);
			result.lCurrentTimes = LONG.read(bytes);
			result.lUserMaxScore = LONG.read(bytes);
			result.lMaxScore	= LONG.read(bytes);
			result.lGuoDiScore = LONG.read(bytes);
			
			result.wBankerUser = WORD.read(bytes);
			result.wCurrentUser = WORD.read(bytes);
			
			var i : uint = 0;
			result.cbPlayStatus = Memory._newArrayAndSetValue(5,0);
			for (i = 0; i < 5; i++)
			{
				result.cbPlayStatus[i] = BYTE.read(bytes);
			}
			result.bMingZhu = Memory._newArrayAndSetValue(5, 0);
			for (i = 0; i < 5; i++)
			{
				result.bMingZhu[i] = BYTE.read(bytes);
			}
			result.lTableScore = Memory._newArrayAndSetValue(5, 0);
			for (i = 0; i < 5; i++)
			{
				result.lTableScore[i] = LONG.read(bytes);
			}
			result.cbHandCardData = Memory._newArrayAndSetValue(3,0);
			for (i = 0; i < 3; i++)
			{
				result.cbHandCardData[i] = BYTE.read(bytes);
			}
			result.bCompareState = BYTE.read(bytes);
			
			
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONG.read(bytes);
			
			return result;
			
		}
		
	}

}