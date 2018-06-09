package games.cowcow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;

	/**
	 * ...
	 * @author xf
	 * 游戏状态
	 */
	public class CMD_S_StatusFree 
	{
		public static const SIZE	:uint = 4;
		public var lCellScore		:Number;						//基础积分
		
		public var cbIsTryPlay:uint;
		public var lTryPlayScore:Number;	
		
		public function CMD_S_StatusFree() 
		{
			
		}
		public static function _readBuffer(bytes :ByteArray) : CMD_S_StatusFree
		{
			var result :CMD_S_StatusFree = new CMD_S_StatusFree();
			result.lCellScore = LONG.read(bytes);
			
			result.cbIsTryPlay = BYTE.read(bytes);
			result.lTryPlayScore = LONG.read(bytes);
			
			return result;
		}
		
	}

}