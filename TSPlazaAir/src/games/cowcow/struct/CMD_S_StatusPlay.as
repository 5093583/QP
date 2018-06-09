package games.cowcow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	/**
	 * ...
	 * @author xf
	 */
	public class CMD_S_StatusPlay 
	{
		public static const SIZE 		: uint = 46;
		public var lCellScore			: Number;						//基础积分
		public var lTableScore			: Array;						//下注数目
		public var cbPlayStatus			: Array;						//玩家状态
		public var wBankerUser			: int;							//庄家用户
		public var cbHandCardData		: Array;						//桌面扑克
		public var bOxCard				: Array;						//牛牛数据
		
		public var cbIsTryPlay:uint;
		public var lTryPlayScore:Number;	
		
		
		public function CMD_S_StatusPlay() 
		{
			
		}
		public static function _readBuffer(bytes : ByteArray) :CMD_S_StatusPlay
		{
			var result : CMD_S_StatusPlay = new CMD_S_StatusPlay();
			result.lCellScore = LONG.read(bytes);
			var i:uint = 0;
			var j:uint = 0;
			result.lTableScore = Memory._newArrayAndSetValue(4, 0);
			for (i = 0; i < 4; i++ )
			{
				result.lTableScore[i] = LONG.read(bytes);
			}
			result.cbPlayStatus = Memory._newArrayAndSetValue(4, 0);
			for (i = 0; i < 4; i++ )
			{
				result.cbPlayStatus[i] = BYTE.read(bytes);
			}
			
			result.wBankerUser = WORD.read(bytes);
			result.cbHandCardData = Memory._newArrayAndSetValue(5, 0);
			for (i = 0; i < 5; i++ )
			{
				result.cbHandCardData[i] = BYTE.read(bytes);
			}
			result.bOxCard = Memory._newArrayAndSetValue(4, 0);
			for (i = 0; i < 4; i++ )
			{
				result.bOxCard[i] = BYTE.read(bytes);
			}
			
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONG.read(bytes);
			
			return result;
		}
		
	}

}