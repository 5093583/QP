package games.zjh.struct
{
	
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.WORD;

	/**
	 * ...
	 * @author xf
	 * 用户放弃
	 */
	public class CMD_S_GiveUp 
	{
		public static const SIZE : uint = 2;
		public var wGiveUpUser : int;						//基础积分
		public function CMD_S_GiveUp() 
		{
			
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_GiveUp
		{
			var result : CMD_S_GiveUp = new CMD_S_GiveUp();
			result.wGiveUpUser = WORD.read(bytes);
			return result;
		}
	}
}