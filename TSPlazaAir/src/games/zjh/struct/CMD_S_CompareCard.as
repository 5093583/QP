package games.zjh.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	/**
	 * ...
	 * @author xf
	 */
	public class CMD_S_CompareCard 
	{
		
		public static const SIZE : uint = 6;
		public var wCurrentUser : int;				//当前用户
		public var wCompareUser : Array;			//比牌用户	第一个人选择比牌
		public var wLostUser	: Number;			//输牌用户
		public function CMD_S_CompareCard() 
		{
			
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_CompareCard
		{
			var result : CMD_S_CompareCard = new CMD_S_CompareCard();
			result.wCurrentUser = WORD.read(bytes);
			result.wCompareUser = Memory._newArrayAndSetValue(2, 0);
			for (var i :uint = 0; i < 2; i++)
			{
				result.wCompareUser[i] = WORD.read(bytes);
			}
			result.wLostUser = WORD.read(bytes);
			return result;
		}	
		
	}

}
