package games.zjh.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	/**
	 * @author xf
	 * 用户看牌
	 */
	public class CMD_S_LookCard 
	{
		public static const SIZE : uint = 5;
		public var wLookCardUser : int;					//看牌用户
		public var cbCardData 	 :Array;				//用户扑克
		public function CMD_S_LookCard() 
		{
			
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_LookCard
		{
			var result : CMD_S_LookCard = new CMD_S_LookCard();
			result.wLookCardUser = WORD.read(bytes);
			result.cbCardData = Memory._newArrayAndSetValue(3, 0);
			for (var i : uint = 0; i < 3; i++)
			{
				result.cbCardData[i] = BYTE.read(bytes);
			}
			return result;
		}
		
	}

}