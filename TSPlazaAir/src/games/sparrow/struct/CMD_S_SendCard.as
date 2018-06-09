package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	/**
	 * @author xf
	 * 发送扑克
	 */
	public class CMD_S_SendCard 
	{
		public static const SIZE		: uint	= 12;
		public var cbCardData			: Array;					//扑克数据  取第一张牌  后面的是花牌
		public var cbActionMask			: uint;						//动作掩码
		public var wCurrentUser			: int;						//当前用户

		public function CMD_S_SendCard() 
		{
			cbCardData = Memory._newArrayAndSetValue(9,0);
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_SendCard
		{
			var result : CMD_S_SendCard = new CMD_S_SendCard();
			for(var i : uint = 0;i<9;i++) 
			{
				result.cbCardData[i] = BYTE.read(bytes);
			}
			result.cbActionMask = BYTE.read(bytes);
			result.wCurrentUser = WORD.read(bytes);
			return result;
		}
	}
}