package games.cowcow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.Memory;

	/**
	 * ...
	 * @author xf
	 * 游戏结束
	 */
	public class CMD_S_GameEnd 
	{
		public static const SIZE		:uint = 32;
		public var lGameTax				:Array;						//游戏税收
		public var lGameScore			:Array;						//游戏得分
		public function CMD_S_GameEnd() 
		{
			
		}
		public static function _readBuffer(bytes :ByteArray) : CMD_S_GameEnd
		{
			var result :CMD_S_GameEnd = new CMD_S_GameEnd();
			var i:uint = 0;
			result.lGameTax = Memory._newArrayAndSetValue(4, 0);
			for (i = 0; i < 4; i++ )
			{
				result.lGameTax[i] = LONG.read(bytes);
			}
			result.lGameScore = Memory._newArrayAndSetValue(4, 0);
			for (i = 0; i < 4; i++ )
			{
				result.lGameScore[i] = LONG.read(bytes);
			}
			return result;
		}
	}
}